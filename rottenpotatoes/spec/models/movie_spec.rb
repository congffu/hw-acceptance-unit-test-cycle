require 'rails_helper'

describe Movie do
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Movie1', director: 'David') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Movie2', director: 'David') }
    let!(:movie3) { FactoryGirl.create(:movie, title: "Movie3", director: 'Kevin') }
    let!(:movie4) { FactoryGirl.create(:movie, title: "Moviedefault") }

    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.director_same_movies(movie1.title)).to eql([movie1, ['Movie1', "Movie2"]])
        expect(Movie.director_same_movies(movie1.title)).to_not include([movie1, ['Movie3']])
      end
    end

    context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.director_same_movies(movie4.title)).to eql([movie4, nil])
      end
    end
  end
  
  describe '.all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 R))
    end
  end
end