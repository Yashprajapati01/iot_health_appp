IoT Health Devices App
Overview
The IoT Health Devices App is a sleek and sophisticated mobile application designed to manage and visualize data from IoT-enabled health devices such as heart rate monitors, oxygen saturation sensors, and temperature measurement devices. By integrating Bluetooth and Wi-Fi connectivity, this app serves as a cutting-edge solution for tracking health metrics in real-time.

Utilizing Flutter, the app is cross-platform, supporting both Android and iOS devices. With a modern design and seamless functionality, the app provides an engaging user experience for individuals looking to track their health data, visualize real-time trends, and manage their devices efficiently.

Key Features
Bluetooth & Wi-Fi Connectivity: Seamlessly connect to health devices via Bluetooth and Wi-Fi. Automatically manage the connection to a variety of IoT devices.
Real-Time Data Visualization: Monitor critical health metrics like Heart Rate, SpO2, and Temperature in real-time with engaging charts.
Device Management: Add, remove, and manage devices directly within the app.
Permissions Handling: Request and manage Bluetooth and Wi-Fi permissions in real-time, ensuring smooth functionality on both Android and iOS.
Cross-Platform Support: Built with Flutter, making it available on both Android and iOS with a single codebase.
Tech Stack
Frontend:

Flutter - A powerful, fast, and flexible SDK to build natively compiled applications for mobile, web, and desktop.
Dart - The programming language used with Flutter, optimized for building high-performance apps.
Backend:

Bluetooth Connectivity: flutter_blue_plus for Bluetooth management on Android and iOS.
Wi-Fi Connectivity: wifi_iot for managing Wi-Fi-enabled devices.
Permission Handling: permission_handler to request runtime permissions like Bluetooth and Location services.
Data Visualization:

Syncfusion Flutter Charts for high-quality, real-time data visualization with smooth updates and interactive UI.
Database:

Currently, mock data is used for the simulation, but you can easily integrate Firebase or a similar backend service for real-time data storage.
App Architecture
The app follows a Model-View-Controller (MVC) pattern for clear separation of concerns:

Model:

Represents the data structure for devices and health metrics (Heart Rate, SpO2, Temperature).
View:

Flutter widgets for rendering the UI, including action cards, charts, and dialogs for adding devices.
Controller:

Manages interactions between the Bluetooth/Wi-Fi service and the app’s UI, handling device connection, data visualization updates, and user inputs.
Permissions
For full functionality, the app requests the following permissions:

Bluetooth:

Bluetooth Connect permission to interact with Bluetooth devices.
Location permission (required by Android) for Bluetooth scanning.
Wi-Fi:

Wi-Fi Control and Location permissions to manage Wi-Fi devices and ensure access to networks.
Setup & Installation
Follow the instructions below to set up the app on your local machine and get it running.

1. Clone the Repository
bash
Copy code
git clone https://github.com/yourusername/iot-health-devices.git
cd iot-health-devices
2. Install Dependencies
bash
Copy code
flutter pub get
3. Set Up Android & iOS
Ensure that you have Flutter installed and set up on your local machine.
If you're targeting Android, ensure your AndroidManifest.xml includes the necessary permissions for Bluetooth and Wi-Fi.
For iOS, ensure Info.plist contains the relevant permissions for Bluetooth and Wi-Fi.
4. Run the App
On Android:
bash
Copy code
flutter run
On iOS:
bash
Copy code
flutter run
UI/UX Design
Modern Design: The app follows material design principles, ensuring an intuitive, beautiful, and seamless user experience.
Interactive Visuals: Charts display health metrics in an interactive manner, where users can see trends over time and get real-time updates on their health status.
How It Works
Bluetooth/Wi-Fi Management:

The app automatically handles the Bluetooth and Wi-Fi states, prompting users to enable Bluetooth/Wi-Fi when they tap on the respective icons. It also checks permissions dynamically and requests them when necessary.
Device List:

After enabling Bluetooth or Wi-Fi, the app scans for nearby health devices and allows users to select and manage them.
Real-Time Data:

Once a device is connected, data such as heart rate, SpO2, and temperature is fetched and displayed on interactive charts. Data updates every few seconds to ensure users are receiving real-time health stats.
Device Name & Connection Type:

Users can add devices via an intuitive dialog that collects the device name and connection type (Bluetooth/Wi-Fi). The connection type dropdown is dynamically handled to provide flexibility to the user.
Potential Improvements
Firebase Integration:

Integrate a real-time database such as Firebase to store historical data and sync across devices.
Enhanced Charts:

Add more advanced data analytics and predictions, such as trend forecasting, using machine learning models.
User Authentication:

Integrate a user authentication system to provide personalized health data tracking and storage.
Contributors
Yash [Your Full Name] - Developer, Architect
GitHub Profile
LinkedIn Profile
Feel free to open issues or contribute to this repository! ✨

License
MIT License. See LICENSE for more information.

Screenshots

Contact
For any questions or feedback, feel free to reach out:

