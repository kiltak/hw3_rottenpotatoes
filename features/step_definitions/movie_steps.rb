# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split.each do |rating|
    if uncheck
      step "I uncheck \"ratings_#{rating}\""
    else
      step "I check \"ratings_#{rating}\""
    end
  end
end

# Use a list of movies to see (or not).

Then /I should (not )?see the following movies: (.*)/ do |visible, movie_list|
  movie_list.split("\" \"").each do |movie|
    movie.delete!("\"")
    step "I should #{visible}see \"#{movie}\""
  end
end

# Check for all of the movies

Then /I should see (all|none) of the movies/ do |quantity|
  if quantity == "all"
    movie_count = 10
  elsif quantity == "none"
    movie_count = 0
  end
  
  row_count = movie_count + 1  # the title row
  
  page.all('table#movies tr').count.should == row_count
end
