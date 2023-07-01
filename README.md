# *Tipper App*

**Tipper** is a tip calculator application for iOS.

Created by: **Edilberto F. Carrizales Cavazos**

Time spent: **About 20** hours spent in total

## User Stories

The following functionality is complete:

* [✅] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [✅] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly
* [✅] Using locale-specific currency and currency thousands separators.
* [✅] UI animations
* List anything else that you can get done to improve the app functionality!
* [✅] Added a slider which updates as you slide and shows from 0% - 30%
* [✅] Added a Split check functionality allowing the total to be split by any number of people (integers)
* [✅] Added a settings view controller to allow more app settings
* [✅] Added a segmented controller which allows the user to change the theme of the app to 4 different colors
* [✅] Added a picker view which allows the user to change the currency symbol in the app
* [✅] Added a thousands separator for larger numbers
* [✅] Made the keyboard only a numeric keypad to allow easier input and only numbers and decimals
* [✅] Added a "done" and "cancel" button to the top of the keypad to allow for easier way to hide the keyboard
* [✅] Designed an app icon using sketch so that multiple devices could see an app logo
* [✅] Added a nice user user interface with calm colors and easy to understand descriptors
* [✅] Had family members test the app and received feedback which led me to add a "calculate total" button which would update the totals once clicked (to avoid total cost confusion)
* [✅] Added a Split check switch which is a nice intuitive UI addition and works sort of like a boolean to make sure the user actually wants split check
* [✅] When any of the totals is not a calculation they both automatically revert back to zero to avoid user confusion
* [✅] Added user defaults saving capability to the theme color and the currency symbol chosen by the user, this setting will prevail even after app restart

Additional features to be implemented:

* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

## Video Walkthrough

Here's a walkthrough/Demo of the App:

![](https://github.com/Eddie-Carrizales/CodePath-IOS/blob/main/Prework-Tipper%20App/Tipper.gif)

GIF created with https://imgur.com

## Notes

Describe any challenges encountered while building the app.
There were a couple of challenges while building the app.
1. Since I did not know anything about Swift and this was a prework I was pretty much learning on my own and experimenting with the code and the different buttons, labels, segmented controllers, text fields, slider, and a picker view.
2. After getting more familiar and finishing the first view controller, I wanted to add the settings screen and thus learned how to add a navigation panel and a second view controller. This posed a challenge since I did not know how to add a second one nor did I know how to connect the first one to the second and move between them. I finally figured out how to do it and added some transitions.
3. The first most challenging step was sending data between each view controller. At first I tried sending the data through a reference from the second view controller to the first, but this was not working as expected, I also tried another method with protocols, but the documentation found online was getting confusing. I ultimately ended up using singletons and managed to pass the theme/color and currency symbol information back to the first view controller.
4. The second most challenging step was saving the theme and the currency symbol to user defaults in both view controllers. Initially I struggled saving this data after app restart in the second view controller, but after researching and reading about the way user defaults worked, I managed to save it in the second view controller (where the user choice was being made). Next, after sending the data back to the first view controller I again struggled to save the theme, but ultimately after trial and error and a lot of research, I managed to make it work.
4. Setting up the view constrains was also a bit challenging and I learned about a small pyramid symbol at the bottom of the main pane where it would add and update the constrains automatically. However, I still had some warnings regarding these constrains that I needed to fix to avoid weird formats on other iphones (the current Iphone I tested the format with was the iphone 13).
5. Finally, I decided to test the app directly by signing it and downloading it on both my iphone and my family members' phones, and I noticed that the format was acting strange to which I found out that darkmode was affecting the style of the app. Thus, I learned that I had to modify the info.plist to have the UIUserStyle always on "light" regardles of user mode (this fixed the issue and the app worked great after that), and even though my app has no dark mode I added 4 different theme colors for the user, which I preferred over darkmode.
