# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer


def movie_names_before_1940
  # Find all the movies made before 1940. Show the id, title, and year.
  Movie.select(:id, :title, :yr)
  .where("yr < 1940")
end

def eighties_b_movies
	# List all the movies from 1980-1989 with scores falling between 3 and 5 (inclusive). Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score)
  .where("score BETWEEN 3 AND 5 AND yr BETWEEN 1980 AND 1989")
end

def vanity_projects
  # List the title of all movies in which the director also appeared as the starring actor. Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.select("movies.id", :title, "actors.name")
  .joins(:actors)
  .where("movies.director_id=actors.id AND castings.ord = 1 ")
end

def starring(whazzername)
	# Find the movies with an actor who had a name like `whazzername`.
	# A name is like whazzername if the actor's name contains all of the letters in whazzername, ignoring case, in order.

	# ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  #Movie.select(:yr).maximum(:score)
  letters = whazzername.split("").join("%")
  
  Movie.joins(:actors)
  .where("actors.name ILIKE '%#{letters}%'")
  .reload
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie.select(:yr)
  .group(:yr)
  .having("MAX(score) < 8")
  .pluck(:yr)
end

def golden_age
	# Find the decade with the highest average movie score.
  Movie.select("AVG(score) AS average", "((yr / 10) * 10) AS decade")
  .group("((yr / 10) * 10)")
  .order("AVG(score) DESC")
  .limit(1)
  .first
  .decade
  .to_i
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.  Sort the results by starring order (ord).
  Movie.select("actors.id", "actors.name")
  .joins(:actors)
  .where("movies.title" => title)
  .order("castings.ord")
  .reload
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.

  Actor.select("a.name")
  .distinct
  .joins(:movies, "JOIN castings AS c ON c.movie_id=movies.id JOIN actors AS a ON a.id=c.actor_id")
  .where("actors.name = '#{name}' AND a.name != '#{name}'")
  .map(&:name)
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles. Show each actor's id, name and number of supporting roles.
  Actor.select('actors.id', 'actors.name', 'COUNT(*) AS roles')
  .joins(:castings)
  .where("castings.ord > 1")
  .group("actors.id")
  .order('COUNT(*) DESC')
  .limit(2)
end

def what_was_that_one_with(those_actors)
	# Find the movies starring all `those_actors` (an array of actor names). Show each movie's title and id.
  Movie.select("movies.title", "movies.id")
  .joins(:actors)
  .where("actors.name IN (?)", those_actors)
  .group("movies.id")
  .having("COUNT(actors.id) = #{those_actors.length}")
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.joins("LEFT OUTER JOIN castings ON castings.actor_id = actors.id")
  .where("castings.actor_id IS NULL")
  .count
end

def longest_career
	#Find the actor and list all the movies of the actor who had the longest career (the greatest time between first and last movie).
  Actor.select("(MAX(movies.yr) - MIN(movies.yr)) AS career", "actors.id", "actors.name")
  .joins(:movies)
  .group("actors.id")
  .order("(MAX(movies.yr) - MIN(movies.yr)) DESC, actors.name")
  .limit(1)
  .first
end
