topmovies = LOAD '/user/hadoop/topmovies' USING PigStorage(',') AS (movie_id:int, rating_count:int);
metadata = LOAD 's3://movieratingdataset' USING PigStorage('|') AS (movie_id:int, movieTitle:chararray, releaseData:chararray, videoRelease:chararray, imdbLink:chararray);
topMoviesWithNames = JOIN topmovies BY movie_id, metadata by movie_id;
topMoviesWithNamesSorted = ORDER topMoviesWithNames BY topmovies::rating_count DESC;
STORE topMoviesWithNamesSorted INTO '/user/hadoop/topMoviesOut' USING PigStorage('|');