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

<img src='https://github.com/nateansel/flix/blob/master/flix_walkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

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