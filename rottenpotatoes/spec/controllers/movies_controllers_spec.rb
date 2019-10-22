require 'rails_helper'

describe MoviesController do
  fixtures :movies
  describe 'Search movies by the same director' do
    it 'should call the model method with movie id, to search over the movie director name' do
      movie = movies(:starwars_movie)
      Movie.should_receive(:similar_movies).with(movie)
      get :search, id: movie
    end 
    it 'should select the Search Results template for rendering if director exists' do
      movie = movies(:starwars_movie)
      similar_movies = [movies(:starwars_movie).title, movies(:thx1138_movie).title]
      Movie.stub(:similar_movies).with(movie).and_return(similar_movies)
      get :search, id: movie
      response.should render_template('search')
    end  
    it 'should make the similar movies results available to the template if director exists' do
      movie = movies(:starwars_movie)
      similar_movies = [movies(:starwars_movie).title, movies(:thx1138_movie).title]
      Movie.stub(:similar_movies).with(movie).and_return(similar_movies)
      get :search, {:id => movie}
      expect(assigns(:similar_movies)).to eql(similar_movies)
    end 
    it 'should redirect to home page if the director is not defined' do
      movie = movies(:chickenrun_movie)
      Movie.stub(:similar_movies).with(movie).and_return(nil)
      get :search, id: movie
      expect(response).to redirect_to('/movies') 
    end  
  end
  
  describe 'get all movies' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end  
    it 'should call the all ratings function from Movie' do
      Movie.should_receive(:all_ratings).and_return( %w(G PG PG-13 NC-17 R));
      get :index
    end
  end  
  
  describe 'create new movies' do
    it 'should call create function in movie model' do
      bg_count = Movie.count
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(Movie.count).to eql(bg_count + 1)
    end  
    it 'should redirect to home page after successful creation' do
      m = FactoryGirl.attributes_for(:movie)
      Movie.should_receive(:create!).with(m).and_return(movie: m)
      post :create, movie: m
      expect(response).to redirect_to('/movies')
    end  
  end
  
  describe 'destroy existing movie' do
    it 'should call the model function find to identify the movie to be deleted' do 
      movie = movies(:starwars_movie)
      Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
      delete :destroy, id: movie
    end  
    it 'should call the model function destroy to delete the movie and reduce the count by 1' do
      before_movie_count = Movie.count
      movie = movies(:starwars_movie)
      delete :destroy, id: movie
      expect(Movie.count).to eq(before_movie_count - 1)
    end  
    it 'should redirect to the home page after successful deletion' do
      movie = movies(:starwars_movie)
      delete :destroy, {:id => movie.id} 
      expect(response).to redirect_to('/movies')
    end   
  end
  
  describe 'show existing movie' do
    it 'should call find function of Movie to find the corresponding movie' do
      movie = movies(:thx1138_movie)
      Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
      get :show, id: movie
    end  
    it 'should render the show page for the movie' do
      movie = movies(:thx1138_movie)
      get :show, id: movie
      expect(response).to render_template('show')
    end
    it 'should make the movie values available to the show template' do
      movie = movies(:thx1138_movie)
      get :show, id: movie 
      expect(assigns(:movie)).to eql(movie)
    end  
  end
  
  describe 'edit the exiting movie' do
    it 'should first call the find method to identify the movie to be edited' do
      movie = movies(:thx1138_movie)
      Movie.should_receive(:find).with(movie.id.to_s)
      get :edit, {:id => movie}
    end
    it 'should call the update attributes on the passed movie' do
      m = FactoryGirl.create(:movie)
      put :update, id: m['id'], movie: FactoryGirl.attributes_for(:movie, title: 'New title')
      m.reload
      expect(m.title).to eql('New title')
    end
    it 'should redirect to the corresponding movie page' do
      m = FactoryGirl.create(:movie)
      put :update, id: m['id'], movie: FactoryGirl.attributes_for(:movie, title: 'New title')
      expect(response).to redirect_to('/movies/'+m.id.to_s)
    end
  end
  
end