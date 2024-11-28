# IoT Health Devices App

## Overview

The **IoT Health Devices App** is a sleek and sophisticated mobile application designed to manage and visualize data from IoT-enabled health devices such as heart rate monitors, oxygen saturation sensors, and temperature measurement devices. By integrating **Bluetooth** and **Wi-Fi** connectivity, this app serves as a cutting-edge solution for tracking health metrics in real-time.

Built with **Flutter**, the app is cross-platform, supporting both **Android** and **iOS** devices. With modern design and seamless functionality, the app provides an engaging user experience for individuals looking to track their health data, visualize real-time trends, and manage their devices efficiently.

---

## Key Features

- **Bluetooth & Wi-Fi Connectivity**: Seamlessly connect to health devices via Bluetooth and Wi-Fi. Automatically manage the connection to a variety of IoT devices.
- **Real-Time Data Visualization**: Monitor critical health metrics like **Heart Rate**, **SpO2**, and **Temperature** in real-time with engaging charts.
- **Device Management**: Add, remove, and manage devices directly within the app.
- **Permissions Handling**: Request and manage Bluetooth and Wi-Fi permissions in real-time, ensuring smooth functionality on both Android and iOS.
- **Cross-Platform Support**: Built with **Flutter**, making it available on both **Android** and **iOS** with a single codebase.

---

## Tech Stack

- **Frontend**:
  - **Flutter** - A powerful, fast, and flexible SDK to build natively compiled applications for mobile, web, and desktop.
  - **Dart** - The programming language used with Flutter, optimized for building high-performance apps.

- **Backend**:
  - **Bluetooth Connectivity**: `flutter_blue_plus` for Bluetooth management on Android and iOS.
  - **Wi-Fi Connectivity**: `wifi_iot` for managing Wi-Fi-enabled devices.
  - **Permission Handling**: `permission_handler` to request runtime permissions like Bluetooth and Location services.
  - **Bluetooth Scanning**: `flutter_bluetooth_serial` to request scanning bluetooth devices in the area.
  - **WiFi Scanning**: `wifi_info_flutter` to request scanning WiFi devices in the area.

- **Data Visualization**:
  - **Syncfusion Flutter Charts** for high-quality, real-time data visualization with smooth updates and interactive UI.

- **Database**:
  - Currently, mock data is used for the simulation, but you can easily integrate Firebase or a similar backend service for real-time data storage.

---

## App Architecture

The app follows a **Model-View-Controller (MVC)** pattern for clear separation of concerns:

1. **Model**:
   - Represents the data structure for devices and health metrics (Heart Rate, SpO2, Temperature).

2. **View**:
   - Flutter widgets for rendering the UI, including action cards, charts, and dialogs for adding devices.

3. **Controller**:
   - Manages interactions between the Bluetooth/Wi-Fi service and the app’s UI, handling device connection, data visualization updates, and user inputs.

---

## Permissions

For full functionality, the app requests the following permissions:

- **Bluetooth**:
  - **Bluetooth Connect** permission to interact with Bluetooth devices.
  - **Location** permission (required by Android) for Bluetooth scanning.

- **Wi-Fi**:
  - **Wi-Fi Control** and **Location** permissions to manage Wi-Fi devices and ensure access to networks.

---

## Setup & Installation

Follow the instructions below to set up the app on your local machine and get it running.

### 1. Clone the Repository

```bash
git clone https://github.com/YashPrajapati01/iot-health-devices.git
cd iot-health-devices
```
2. Install Dependencies
Install the necessary Flutter dependencies:
```bash
flutter pub get
```

3. Set Up Android & iOS
For Android:

Ensure that your AndroidManifest.xml includes Bluetooth and Wi-Fi permissions.
Example permissions:
```bash
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
```
4. Run the App
To run the app on Android or iOS, simply use the following command:
```bash
flutter run
```
📊 How It Works
1. Bluetooth/Wi-Fi Management:
The app manages Bluetooth and Wi-Fi connectivity seamlessly. Upon tapping the Bluetooth or Wi-Fi icon, it checks if the services are enabled and prompts users to turn them on if necessary.
2. Device List & Connection:
Once Bluetooth or Wi-Fi is enabled, the app scans for nearby devices and allows users to select and connect to health devices.
3. Real-Time Data:
After successfully connecting to a device, the app starts fetching data like Heart Rate, SpO2, and Temperature, and displays it in real-time using Syncfusion Flutter Charts.
4. Add Device:
Users can add devices by entering a device name and selecting the connection type (Bluetooth or Wi-Fi) through a clean and intuitive dialog for the mock data.

---

💻 Contributors
Yash - Developer, Architect
Feel free to open issues or contribute to this repository! ✨

📜 License
MIT License. See LICENSE for more information.

📧 Contact
For any questions or feedback, feel free to reach out:

Email: prajapatiyash0011@gmail.com
