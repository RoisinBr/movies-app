create database movieapp;

create table movies (
  id serial primary key, 
  title text,
  plot text,
  review_rating FLOAT,
  rated text,
  image_url text,
  year_released INTEGER,
  director text,
  genre text,
  imdbid text
);