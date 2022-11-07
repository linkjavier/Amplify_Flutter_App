# zitro_connect_v1

Zitro Connect App - A Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

Initial modifications ====== 25 Oct

- In pubspec.yaml  added amplify dependencies:
    amplify_flutter: ^0.6.0
    amplify_datastore: ^0.6.0

- Plugin amplify_datastore requires a higher Android SDK version.On build.gradle in android/app: 
     android -> defaultConfig -> minSdkVersion 21     

Added Amplify Storage: dynamoZitroConnect
Table Name: homeOwner-dev

Added Amplify Function: mylambda
Function Name: mylambda-dev

Create new Lambda (In CLI)
- $amplify add function (follow steps. Important to assign the role. Permit to write and read the database).


