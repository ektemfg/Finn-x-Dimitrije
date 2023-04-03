# Finn-x-Dimitrije
Description of Solution:
As part of my iOS developer position technical challenge, I created an app that serves as a concept for FINN's Torget, a feature of their official app. To begin, I focused on creating a minimum viable product (MVP) that would fetch and decode JSON data from a remote source using a model of an ad. This data was then displayed in a list, along with the option for users to favorite specific ads, which was saved using UserDefaults to allow for offline usage.

During the development process, I aimed to challenge myself by creating a polished and visually appealing demo app that mimics the style and layout of FINN's official app. I paid close attention to design elements such as padding and color schemes, and included a fun cat motif as a playful touch.

The app includes five main pages, each serving a unique purpose. 
The Torget page displays a list of all ads fetched from the remote JSON file. If the user is offline or the list is empty, a view shows they are online but hints them to head over to favorites which are available offline.

Users can click on an ad to view its details in a dedicated AdDetailsView. They can also like the Ad from there and read more about "Fix ferdig".
I may not be a professional designer, but I did my best to make the AdDetailsView look like FINN's real ad DetailView.

The Notifications page includes mock content from FINN's "Lagrede søk" and "Sjekk dette" pages. 

The Favorites page displays all of the user's saved favorite ads, which persist even after the app is closed. User can dislike or remove all favorites.

The Messages page includes a fun animation of a "Finn Pus" cat appearing from the bottom of the screen, along with FINN's "no messages" content. 
Finally, the Extras page offers users the option to toggle a "Favorites only" mode in the main Torget ad list.

Did create some simple unit tests which app is running on build.

Anything I feel particularly proud of:
I spent a lot of time researching the design elements, like the colors and padding, and making sure they matched the real FINN app. It was a fun and rewarding experience to see the app come together and I like the final result.

If there’s anything you believe could have been done better:
Of course there are some areas where I believe improvements could be made! 

One potential issue is the handling of saving and removing Ads from UserDefaults. 
It's possible that the app is saving them more frequently than necessary, which could impact performance. 
To address this, I'm considering implementing additional Boolean state variables to ensure that saving only occurs when required.

Another issue is with the bottomBar icons (tabView), which cannot be resized as normal images. While this isn't a significant problem, it does impact the overall aesthetic of the app.

My use of a single viewModel works well for the current codebase, it may not be the best solution for a larger, more complex app. 
While I initially started with multiple viewmodels, I consolidated them to a single one. 

I'm still unsure if the approach I took to running API calls from DataService is optimal, but it's currently working well.

What else you could have done with more time:
SplashScreen of course 😉
If I had more time, I would definitely focus on implementing Combine and using sinks instead of the current approach. 
While I am still learning how to use it properly, I believe that it would greatly improve the efficiency and possibly readability of the code. 

Even though the app runs quite fast on my phone and simulator, I would still like to improve the performance of the app, particularly with regards to network requests and data handling. 
I personaly think that implementing Combine would help alot.

I would like to add more features and functionality to the app, such as search functionality,
Add button actions to some navigationItems that are missing action:{} or .onTapGesture right now.
I would love implementing sort function to sort Ads by available values like:
score (i believe its relevance for either user / search query)
price
And Filter function to filter with values like:
shippingOption is not nil (would mean Ad has "Fix-ferdig" option in this case)
location
adType - B2B, BAP or REALESTATE

Thats it.
Happy Easter!


