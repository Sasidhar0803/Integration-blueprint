import { LightningElement, track } from 'lwc';
import searchmovie from '@salesforce/apex/omdbmovie.searchmovie';

export default class Omdb extends LightningElement {
    @track error;
    @track movies = [];
    @track moviename = '';

    handlesearch(event) {
        this.moviename = event.target.value;
    }

    handlesearchbutton() {
        searchmovie({ movieName: this.moviename })
            .then((result) => {
                let movie = JSON.parse(result); // Parse the JSON response
                if (movie.Response === 'True') {
                    // Extract movie details
                    this.movies = [
                        {
                            title: movie.Title,
                            year: movie.Year,
                            rating: movie.imdbRating || 'N/A',
                            genre: movie.Genre || 'N/A',
                            director: movie.Director || 'N/A'
                        }
                    ];
                    this.error = null;
                } else {
                    this.error = movie.Error || 'No results found';
                    this.movies = [];
                }
            })
            .catch((error) => {
                this.error = 'An error occurred while fetching data.';
                this.movies = [];
                console.error(error);
            });
    }
}
