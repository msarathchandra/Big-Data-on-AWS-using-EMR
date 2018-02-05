create database if not exists movielens;

use movielens;

create external table if not exists ratings (
  user_id int,
  movie_id int,
  rating int,
  rating_time int
) row format delimited fields terminated by '\t'
stored as textfile
location 's3://movieratingsdataset/hadoop/ratings';

select movie_id, count(*) as ratingcount from ratings group by movie_id order by ratingcount DESC;

create table if not exists top_movies
row format delimited fields terminated by ','
stored as textfile
location '/user/hadoop/top_movies' as
select movie_id, count(*) as ratingcount from movielens.ratings group by movie_id;