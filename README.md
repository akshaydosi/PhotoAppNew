# PhotoAppNew
- Fetches the JSON data from the given url
- displays the UI using the collectionview via anchors for autolayout : created extension for the same.
- MVVM design used
- Added SwiftLint as a tool for Code Review process as well. Made sure that all default rules are passed.
- dynamic cell content height based on the description of the image, if no description a default height is set to have a proper UI to the end user shown properly.
- Default image placeholder added
- Logic is part of the ViewModel class and controller just takes care of displaying the UI/handling iteractions if any.
- Extension added related to Anchors for autolayout.
- Test cases added for the ViewModel logic and the Networking class using expectations.
- Comments added wherever it was not readable directly from the 3rd person view point.
