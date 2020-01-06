# Contacts

This iOS coding challenge is part of the interview process for the iOS engineer role at Outlook Mobile iOS team at Microsoft Suzhou. I have completed this challenge without any outside help. It took me a little over 2 business days worth of work to complete this challenge. I've tried my best to replicate all the behaviors exhibted in the [video of the Contacts app](challenge.mov). The requirements orignal challenge can be found here:
https://github.com/outlook/jobs/blob/master/instructions/ios/ios-engineer.md 

## Implementation
This is a single view app. The main view can be broken into two collection views (top: profile image collection view, bottom: profile information collection view). Profile image collection scrolls horizontally, and profile information collection view scrolls vertically. I followed the model view controller designer pattern in this project. The app is data driven with the data derived from the [contacts.json](contacts.json) and images from [avatars.zip](avatars.zip). 

## Features
- Synchronize scrolling between the profile image collection view and profile information collection view
- Update selection when either of the collection view is being scrolled
- Enable paging on the bottom collection
- Center the profile image cell when it is selected
- Stop the scrolling with a profile image cell alwasy in the center of the profile image collection view
- Animate a shadow showing and hiding during and after scrolling

## Limitations
- The cirlcular profile images are set to a fixed size of 80 px by 80 px. 
- The app is set to portrait only. If I were to add support for landscape mode, I would use an alternative layout to have the profile image collection view on the left hand side of the screen and make it scroll vertically. 
- The shadow animation is triggered by either of the top or bottom collectin view. The [video of the Contacts app](challenge.mov) only showed it triggered by scrolling on the bottom collection view.
- I used storyboard and autolayout for building the view instead of building it in code. In my view controller, I overriden some of the methods for UICollectionViewDataSource, UICollectionViewDelegate, and UICollectionViewLayout to achieve the desired behavior. 
