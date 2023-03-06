This folder contains code related to data.
### api.dart
    This contains the class API which has three methods:
    1.  init()
    2.  login()
    3.  signUp()

### directory.dart
    This contains the ServerDirectory class, which matches @server names to IP addresses. This has 2 methods:
    1. init()
    2. getIPFromEmail()

### feedback_journey.dart
    This contains the data structure declarations for:
    1. EMFeedbackJourney
    2. FLFeedbackJourney

### frontliner_data.dart
    This contains the FLDataService which collects code for retrieving data from the server. It has 2 methods:
    1. getAllSubmittedJourneys - this returns a list of FLFeedbackJourneys.


### manager_data.dart
    Similar to frontliner_data, but this collects code for retrieving EM data from the server. 
    1. getAllFeedbackGiven - this returns a list of EMFeedbackJourneys.
