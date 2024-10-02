-- select C1.visited_on, sum(C2.amount) as amount, round(avg(C2.amount),2) as average_amount
-- from Customer C1 cross join Customer C2 
-- -- on C1.visited_on = C2.visited_on
-- where C1.visited_on >= (select min(visited_on) from Customer)+6
-- and (C1.visited_on - C2.visited_on <= 6 and C1.visited_on - C2.visited_on >= 0)
-- group by C1.visited_on
-- order by C1.visited_on

-- select C1.visited_on, sum(C2.amount) as amount, round(avg(C2.amount),2) as average_amount
-- FROM 
--   (SELECT visited_on, SUM(amount) as amount
--    FROM Customer 
--    GROUP BY visited_on) C1
-- cross JOIN 
--   (SELECT visited_on, SUM(amount) as amount
--    FROM Customer 
--    GROUP BY visited_on) C2 
-- where C1.visited_on >= (select min(visited_on) from Customer)+6
-- and (C1.visited_on - C2.visited_on <= 6 and C1.visited_on - C2.visited_on >= 0)
-- GROUP BY C1.visited_on
-- HAVING COUNT(DISTINCT C2.visited_on) = 7
-- order by C1.visited_on

select C1.visited_on, sum(C2.amount) as amount, round(avg(C2.amount),2) as average_amount
FROM 
  (SELECT visited_on, SUM(amount) as amount
   FROM Customer 
   GROUP BY visited_on) C1
LEFT JOIN 
  (SELECT visited_on, SUM(amount) as amount
   FROM Customer 
   GROUP BY visited_on) C2 
  ON C1.visited_on >= C2.visited_on 
  AND C1.visited_on <= C2.visited_on + 6
WHERE C1.visited_on >= (SELECT MIN(visited_on) FROM Customer) + 6
GROUP BY C1.visited_on
HAVING COUNT(DISTINCT C2.visited_on) = 7
order by C1.visited_on
