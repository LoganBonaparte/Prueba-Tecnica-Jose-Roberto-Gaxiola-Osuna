-- NOTE THIS QUERIES ARE MADE IN THE ASSUMPTION THAT THE EXACT SCHEMA CREATED IN TASK1 EXISTS

-- 1. Basic query, query is optimized selecting only the needed columns for the query and not all columns of all tables, the join clauses
-- used here are the indexes I declared while creating the tables in  TASK 1 thus, improving performance and by using joins instead of
-- subqueries

SELECT
    s.survey_name,
    q.question_text,
    r.response_text,
    u.user_name
FROM surveys s
INNER JOIN questions q ON s.survey_id = q.survey_id
INNER JOIN responses r ON q.question_id = r.question_id
INNER JOIN users u ON r.user_id=u.user_id
WHERE s.survey_id =1; -- in this case I use survey1 because thats what the task request "for a given survey" so should another survey be wanted to show this 1 value should be changed

-- 2. Query to calculate average score grouped by survey name, since I used an enum contraint I used a CASE here to convert each 
-- response into a numeric value and then calculate the average. 
-- query is optimized selecting only the needed columns for the query and not all columns of all tables, the join clauses
-- used here are the indexes I declared while creating the tables in  TASK 1 thus, improving performance and by using joins instead
-- subqueries. Using GROUP BY to group every response for each survey

SELECT 
    s.survey_name,
    AVG(
        CASE r.response_text
            WHEN 'Strongly Disagree' THEN 1
            WHEN 'Disagree' THEN 2
            WHEN 'Neutral' THEN 3
            WHEN 'Agree' THEN 4
            WHEN 'Strongly Agree' THEN 5
        END) AS average_score
FROM surveys s
INNER JOIN questions q ON s.survey_id = q.survey_id
INNER JOIN responses r ON q.question_id = r.question_id
GROUP BY s.survey_name;
    
-- 3. Query to find top 3 users, same as number 2 since I used enum now I used a CASE to convert responses into numeric values
-- and get the average
-- query is optimized selecting only the needed columns for the query and not all columns of all tables, the join clauses
-- used here are the indexes I declared while creating the tables in  TASK 1 thus, improving performance and by using joins instead
-- subqueries. Using GROUP BY to group every response for each user, which would give me a full list of users, I use ORDER BY
-- to arrange a descending order and then I use LIMIT 3 to show only the top 3 from the list thus showing the top 3 users with
-- highest average response 

SELECT 
    u.user_name,
    AVG(
        CASE r.response_text
            WHEN 'Strongly Disagree' THEN 1
            WHEN 'Disagree' THEN 2
            WHEN 'Neutral' THEN 3
            WHEN 'Agree' THEN 4
            WHEN 'Strongly Agree' THEN 5
        END) AS average_score
FROM users u
INNER JOIN responses r ON u.user_id = r.user_id
GROUP BY u.user_name
ORDER BY average_score DESC
LIMIT 3;

-- 4. response count for the questions of a given survey.
-- query is optimized selecting only the needed columns for the query and not all columns of all tables, the join clauses
-- used here are the indexes I declared while creating the tables in  TASK 1 thus, improving performance and by using joins instead
-- subqueries. I used where to specify the given survey
SELECT 
    q.question_text,
    r.response_text,
    COUNT(*) AS response_count
FROM questions q
INNER JOIN responses r ON q.question_id = r.question_id
WHERE q.survey_id =1 -- in this case I use survey1 because thats what the task request "for a given survey" so should another survey be wanted to show this 1 value should be changed
GROUP BY q.question_text, r.response_text;