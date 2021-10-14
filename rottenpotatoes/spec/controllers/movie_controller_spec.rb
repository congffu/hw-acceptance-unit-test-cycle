require 'rails_helper'

RSpec.describe MoviesController do
  describe 'Search movies by the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:director_same_movies).with('Movie1')
      get :director_same, { title: 'Movie1' }
    end

    it 'should assign similar movies if director exists' do
      movies = ['Movie1', 'Movie1']
      Movie.stub(:director_same_movies).with('Movie1').and_return(['Movie2',movies])
      get :director_same, { title: 'Movie1' }
      expect(assigns(:director_same_movies)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:director_same_movies).with('Moviedefault').and_return(['Moviedefault',nil])
      get :director_same, { title: 'Moviedefault' }
      expect(response).to redirect_to(root_url)
    end
  end
  
  describe 'preexisting method test in before(:each)' do
    it 'should call find model method' do
      Movie.should_receive(:find).with('1')
      get :show, :id => '1'
    end

    it 'should redirect to appropriate url' do
      get :index,                       # method
          {},                           # url params
          {ratings: {G: 'G', PG: 'PG'}} # session
      response.should redirect_to :ratings => {G: 'G', PG: 'PG'}
    end
    
    it 'should create movie and redirect' do
      post :create,
           {:movie => { :title => "title", :description => "description", :director => "director", :rating => "R", :release_date =>"09/09/2010"}}
      response.should redirect_to movies_path
      expect(flash[:notice]).to be_present

    end
  
    it 'should update render edit view' do
      Movie.should_receive(:find).with('1')
      get :edit,
          {id: '1'}
    end

  end
end