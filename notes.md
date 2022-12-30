=== How was the Zitro Connect project created: ===

1. Create the project: $ flutter create zitro_connect_v1
2. Install Amplify Libraries:
    dependencies:
      amplify_flutter: ^0.6.0
      amplify_auth_cognito: ^0.6.0

    flutter pub get -> To install dependencies
3. $ amplify init 
4. Initialize Amplify in the application:
    Add the necessary dart dependencies at the top of main.dart alongside to other imports:

    // Amplify Flutter Packages
    import 'package:amplify_flutter/amplify_flutter.dart';
    import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

    // Generated in previous step
    import 'amplifyconfiguration.dart';

   -  Add _configureAmplify() code

5. Create a REST API

To add a backend Amplify API
$ amplify add api (Then follow the instructions)

To remove a backend Amplify API
$ amplify api remove

To remove a backend Amplify Function
$ amplify function remove

To see the status of Amplify services
$ amplify status


== ENDPOINTS ==

homewners API
REST API endpoint: https://2341jzc4hc.execute-api.us-west-2.amazonaws.com/dev

https://h5vw9hnyhk.execute-api.us-west-2.amazonaws.com/dev/homeowners

==  Roles ==
The lambda function are using the IAM Role with full dynamoDB Full Access Permission:

zitroconnectv1LambdaRolec88c8e1e-dev

================