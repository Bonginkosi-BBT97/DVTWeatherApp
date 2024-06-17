# DVTWeatherApp
 DVT's Weather App Assessment  V1.0
**Overview**

WeatherApp is an iOS application that provides weather forecasts for the user's current location and allows users to save their favourite cities to view their weather information. The app covers only South African cities. It is built using a combination of SwiftUI and UIKit, employing the MVVM architecture with Combine for data binding. Core Data is used for saving and retrieving city names, and SwiftLint and SwiftFormatter are integrated for maintaining code quality. CoreLocation is used to get the user's live location. (The app is also available on TestFlight. Send a request to brightwelltshabalala@gmail.com)

**Conventions**
Code Style: SwiftLint and SwiftFormatter are used to enforce coding standards and style.
Naming Conventions: CamelCase for variables and methods, PascalCase for types and protocols.
File Structure: Separate folders for Models, Views, ViewModels, and Utilities.
Architecture

The project employs the MVVM (Model-View-ViewModel) architecture, leveraging SwiftUI and UIKit for different parts of the app.
Pure Vanilla iOS Development: No third-party JSON parsers or HTTP clients are used.
Core Data: Used for local persistence to save and retrieve favorite cities.
Combine: Used for reactive programming and data binding within the MVVM architecture.
CoreLocation: Used to fetch the user's current location for weather updates.
Third-Party Dependencies

The project uses Cocoapods for managing dependencies related to cross-cutting concerns.

SwiftLint: Linter tool to enforce Swift style and conventions.
SwiftFormatter: Code formatter for consistent code style.
How to Build the Project

**Clone the Repository:**

bash
Copy code
git clone https://github.com/Bonginkosi-BBT97/WeatherApp.git 
cd WeatherApp
Install Dependencies:
Ensure you have Cocoapods installed. If not, install it using:

bash
Copy code
sudo gem install cocoapods
Then, install the required pods:

bash
Copy code
pod install
Open the Project:
Open the WeatherApp.xcworkspace file with Xcode.

**Build and Run:**
Select your target device or simulator and press Cmd+R to build and run the project.

**Additional Notes**

Testing: A link for TestFlight testing can be provided on request. send a request to brightwelltshabalala@gmail.com

