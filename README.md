# TrueNorthReddit Challenge:
This is a challenge proposed by TrueNorth

# Install:

This application use Swift Package Manage (SPM) to avoid upload Pods, and you  ⚠️⚠️⚠️   DO NOT  ⚠️ ⚠️ ⚠️ have to run `pod install`

clone proyect with 
1. `git clone git@github.com:manuuualvarez/TrueNorthReddit.git` or, 
2.  `git clone https://github.com/manuuualvarez/TrueNorthReddit.git`

then, go to the `<app-root>` and open the file   ✅  `TrueNothReddit.xcodeproj`

#Behavior:

 What the app show:

- Title of the post
- Author
- Entry date (as format like "x hours ago"
- A thumbaild for who have a picture and empty is not.
- Number of comments
- Unread Stat
![Simulator Screen Shot - iPhone 11 Pro Max - 2022-01-23 at 22 32 05](https://user-images.githubusercontent.com/30216587/150708167-ce850026-f009-48b0-84b7-ecdabb3300b6.png)
us
- Pull to refresh, and update the data
-  Pagination Support
- Saving picture in the picture gallery:


> 1.  You should to tap on the image, allow to gallery permissions and you receive an activeSheet alert about the success.
> 2.  If you not allow access, another alert suggest that you should allow to save image.
> ![simulator_screenshot_B2665C73-CD2C-42A6-87D3-6552F04CC861](https://user-images.githubusercontent.com/30216587/150708381-bbce1c9b-d124-43cb-a9e1-35b0b7218fc2.png)
> ![Simulator Screen Shot - iPhone 11 Pro Max - 2022-01-23 at 22 36 01](https://user-images.githubusercontent.com/30216587/150708407-40efab7d-b0ed-4a23-bcff-49b7fe118a16.png)
> ![Simulator Screen Shot - iPhone 11 Pro Max - 2022-01-23 at 22 36 36](https://user-images.githubusercontent.com/30216587/150708444-4647571d-a3c5-44da-9829-76066beba81f.png)

- Indicator of unread/read post (updated status, after post it´s selected)
- Dismiss Post Button (this acction execute when you swipe the cell, an animation delete de post)
- Dismiss All Button (in the right top of the view, you can delete all post you can be see).

All the data and cache is handle with CoreData, if Core Data is empty, you will see a Button in the top left of the screen, to remove the data stored.






    



