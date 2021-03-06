# Project 1 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **4** hours spent in total

## User Stories

The following **required** user stories are complete:

- [x] User sees app icon in home screen and styled launch screen (+1pt)
- [x] User can scroll through a list of movies currently playing in theaters from The Movie DB API (+5pt)
- [x] User can "Pull to refresh" the movie list (+2pt)
- [x] User sees a loading state while waiting for the movies to load (+2pt)

The following **stretch** user stories are implemented:

- [x] User sees an alert when there's a networking error (+1pt)
- [x] User can search for a movie (+3pt)
- [x] While poster is being fetched, user see's a placeholder image (+1pt)
- [ ] User sees image transition for images coming from network, not when it is loaded from cache (+1pt)
- [ ] Customize the selection effect of the cell (+1pt)
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete (+2pt)

The following **additional** user stories are implemented:

- [x] User can scroll to view more movies (add infinite scrolling)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I’d like to discuss how I laid out my views with code rather than with a storyboard or xib.
2. I’d like to discuss how I created `Manager` objects to handle network calls to reduce the amount of specific networking code in the `ViewController`s.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/nateansel/flix/blob/master/week_1.gif' title='Video Walkthrough' width='300px' alt='Video Walkthrough'/>

GIF created with [Gifox](https://gifox.io).

## Notes

Describe any challenges encountered while building the app.

The most notable challenge I encountered was getting the infinite scrolling and searching feature to work together. I handle infinite scrolling by loading in more movies when a certain cell scrolls into view, and that cell would appear when searching, which would then reload the view, removing the User’s search results. This issue created a very jarring experience for the User. I fixed this issue by putting the MovieListView into a “searching” state that temporarily removed the Loading Cell from the list, which prevents this issue from occuring.

## License

    Copyright 2018 Nathan Ansel

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# Project 2 - *Flix*

**Flix** is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **2** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can tap a cell to see a detail view (+5pts)
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView (+5pts)

The following **stretch** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie (+3pts)
- [ ] In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer (+3pts)
- [ ] Customize the navigation bar (+1pt)
- [ ] List in any optionals you didn't finish from last week (+1-3pts)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I’d like to discuss my use of a blur view in the Movie Details screen, as it is something that not very intuitive to use.
2. I’d like to discuss how I could improve the layout of my views. I think I could improve the general look and feel of this app quite a bit.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/nateansel/flix/blob/master/week_2.gif' title='Video Walkthrough' width='300px' alt='Video Walkthrough'/>

GIF created with [Gifox](https://gifox.io).

## Notes

Describe any challenges encountered while building the app.

I ran into a few layout issues when using the UICollectionView. I don’t use Collection Views in many of my projects, so I usually have to refresh myself on how they layout their cells.

## License

    Copyright [2018] [Nathan Ansel]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.