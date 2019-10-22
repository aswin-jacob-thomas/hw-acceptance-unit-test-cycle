require 'rails_helper'
 describe Movie do
    fixtures :movies
    describe ' - Find Similar Movies feature works properly' do
         context 'when director exists' do
          it 'returns similar movies correctly' do
            expect(Movie.similar_movies(movies(:starwars_movie))).to eql([movies(:starwars_movie).title, movies(:thx1138_movie).title])
            expect(Movie.similar_movies(movies(:starwars_movie))).to_not include(movies(:chocolat_movie).title)
            expect(Movie.similar_movies(movies(:chickenrun_movie))).to eql([movies(:chickenrun_movie).title])
          end
        end
         context 'when director does not exist' do
          it 'returns no movies' do
            expect(Movie.similar_movies(movies(:chocolat_movie))).to eql(nil)
          end
        end
    end
    describe 'Returns all ratings:' do
        it 'returns all ratings which can be associated with a movie' do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end
end