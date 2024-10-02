
-- select min(names) as results from (
-- select name as names from Users where user_id in
-- (select user_id from MovieRating 
-- group by user_id
-- having count(*) = 
-- (select max(theCount) from (select count(*) as theCount from MovieRating 
-- group by user_id) as meow)
-- )
-- ) as meow2

-- union all

-- select min(title) from Movies where movie_id in (
-- select movie_id from MovieRating 
-- where created_at >= "2020-02-01" and created_at <= "2020-02-29"
-- group by movie_id
-- having round(avg(rating),2) = (
-- select round(max(ratings),2) as maxRatings from (
-- select avg(rating) as ratings from MovieRating
-- where created_at >= "2020-02-01" and created_at <= "2020-02-29"
-- group by movie_id
-- ) as meow3 
-- )
-- )


-- Much Better Solution 
-- using joins and 
-- using aggregate fucntions in order by clause and
-- using more than 1 variables in order by caluse
(
select U.name as results from
Users U left join MovieRating MR on U.user_id = MR.user_id
group by U.user_id
order by count(*) desc, U.name
limit 1
)
union all
(
select M.title from
Movies M left join MovieRating MR on M.movie_id = MR.movie_id
where MR.created_at >= "2020-02-01" and MR.created_at <= "2020-02-29"
group by M.movie_id
order by avg(MR.rating) desc, M.title
limit 1
)


-- Same solution as above, but uses CTE instead
-- WITH 
-- TheMostActiveUser AS (
--     SELECT name
--     FROM 
--         Users
--         NATURAL JOIN MovieRating
--     GROUP BY user_id
--     ORDER BY COUNT(*) DESC, name
--     LIMIT 1
-- ),
-- TheBestMovieFebruary AS (
--     SELECT title
--     FROM
--         Movies
--         NATURAL JOIN MovieRating
--     WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
--     GROUP BY movie_id
--     ORDER BY AVG(rating) DESC, title
--     LIMIT 1
-- )

-- SELECT name AS results
-- FROM TheMostActiveUser
-- UNION ALL
-- SELECT title
-- FROM TheBestMovieFebruary


