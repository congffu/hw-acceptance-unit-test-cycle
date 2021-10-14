
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /^the director of "(.*)" should be "(.*)"$/ do |title_value, director_value|
  movie = Movie.find_by_title(title_value)
  expect(movie.director).to eq(director_value)
end

###########################################################

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end


Then /I should (not )?see movies with titles: (.*)$/ do |display, movies_list|
  movies = movies_list.split(', ')
  movies.each do |movie|
    if display.nil?
      expect(page).to have_content(movie)
    else
      expect(page).not_to have_content(movie)
    end
  end
end

