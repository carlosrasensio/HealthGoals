<h1 align="center">HealthGoals</h1>

*Author:* Carlos Rodriguez Asensio


## Requirements
- Xcode 14.2
- Swift 5.0

## Objective
- This is a simple project capable to show a basic health goals list, their details and progress using MVP-C architecture, Core Data, HealthKit and unit testing. The app uses the following API (https://d9fd1bed-3c81-43a5-bb37-bc97488093f7.mock.pstmn.io/goals).
 
## Installation
- Clean and build the project in Xcode

## 3rd-Party Libraries
 - None

## Design pattern
 - **MVP-C** - means Model, View, Presenter and Coordinator. Also, util classes are used like CoreDataManager or NetworkManager.
 
    - *Model* - defines the API response data.
    - *View* - created with .xib and UIViewController, configures UI.
    - *Presenter* - business logic, gets the data from service and injects it to the view.
    - *Coordinator* - creates and instances the view through the SceneDelegate. Provides the app navigation.
    
    - *NetworkManager* - responsible for making API calls.
    - *CoreDataManager* - responsible for handling the Core Data database.
    
    - *Tests* - all the files needed to make presenters and network Unit Testing.
 
 ## Potential improvements
- More information in the detail view.
- Improve the app UI/UX. Add some animations.
- Improve the app Unit Tests and implement UI and Integration Tests.
- Add more languages to the app.
