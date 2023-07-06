# Movie App

This Movie App allows users to search for movies using a free public movie database service. Users can enter a search term, and the app displays a list of matching movies with their titles, overviews, and posters (if available).

## Features
- Search movies: Enter a search term to find movies based on the title.
- Display movie details: View the movie title, overview, and poster.
- Search results: See a list of matching movies in a scrollable table view.

# Architecture

- The Movie App follows the MVVM (Model-View-ViewModel) architectural pattern, which separates the user interface (View) from the data and business logic (ViewModel). The key components are: 
- Model: The data model represents the structure and properties of the Movie entity, including the title, overview, and poster path. - -View: The view layer is responsible for displaying the user interface and handling user interactions. In this app, the view is implemented using UIKit
- ViewModel: The view model acts as an intermediary between the view and the model. It retrieves movie data from the API service, processes it, and exposes it to the view for display. It also handles user interactions and triggers appropriate actions.


 ## Unit Test Cases The Movie App includes unit tests to ensure the correctness and reliability of the code.
