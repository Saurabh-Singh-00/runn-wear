![App Poster](images/WearAppPoster.jpg "App Poster")

# Runn Wear App
A smart watch (Android) app for participating in Marathons virtually

- This app has its backend setup with Django and Datastax Astra&trade;
- [Backend Repository Link](https://github.com/Saurabh-Singh-00/runn-backend/tree/astra "Backend")


### Features
- [Connected Flutter App](https://github.com/Saurabh-Singh-00/runn "Flutter App")
- A standalone wear app that can run independently 
- Google Sign In
- Participate in marathons Virtually or Onsite
- Just participate and run whenever you like


### Getting Started
- Before running the app please setup and start the [Backend server](https://github.com/Saurabh-Singh-00/runn-backend/tree/astra "Backend Astra")

> **Below steps are only required if you are testing your wear app on actual Wear device. No setup needed for emulator.**

- After your backend has successfully started please obtain the IP address of your local computer

- Linux / Mac `ifconfig`

- Windows `ipconfig`

- You will see the IPv4 address like `192.168.0.104`

- Replace `baseUrl` in `lib/providers/base_data_provider.dart` with your IP address

