import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:runn_wear/injector/injector.dart';
import 'package:runn_wear/repositories/user_repository.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'race_event.dart';
part 'race_state.dart';

class RaceBloc extends Bloc<RaceEvent, RaceState> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();

  UserRepository userRepository = injector.get<UserRepository>();

  Position previousPosition;

  RaceBloc() : super(RaceInitial()) {
    initPlatformState();
  }

  Future<Either<Exception, Position>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Either<Exception, Position> either =
        await Task(Geolocator.getCurrentPosition)
            .attempt()
            .map((a) => a.leftMap((l) => (l as Exception)))
            .run();

    return either;
  }

  Future<void> initPlatformState() async {
    stopWatchTimer.secondTime.listen(sendRaceData);
  }

  void sendRaceData(int seconds) async {
    if (state is RaceStarted && seconds % 10 == 0) {
      Either<Exception, Position> position = await determinePosition();
      position.fold((l) {}, (r) {
        if (previousPosition != null && previousPosition != r) {
          userRepository.sendUserStatsByMarathon(
              (state as RaceStarted).marathonId,
              (state as RaceStarted).email,
              r.latitude,
              r.longitude);
        }
        previousPosition = r;
      });
    }
  }

  @override
  Future<void> close() {
    stopWatchTimer.dispose();
    return super.close();
  }

  Stream<RaceState> mapStartRaceToState(StartRace event) async* {
    yield RaceStarted(event.marathonId, event.email);
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  Stream<RaceState> mapStopRaceToState(EndRace event) async* {
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    yield RaceEnded();
  }

  @override
  Stream<RaceState> mapEventToState(
    RaceEvent event,
  ) async* {
    print(event);
    if (event is StartRace) {
      yield* mapStartRaceToState(event);
    } else if (event is EndRace) {
      yield* mapStopRaceToState(event);
    }
  }
}
