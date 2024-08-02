-- NOTE: THIS CODE WORKS UNDER THE ASSUMPTION THAT THE SCHEMA CREATED IN TASK1 EXISTS
-- 1. Stored procedure, here im converting ENUM responses to numbers using CASE again to use it as a simple scoring algorithmm,
-- this procedure is used to score the surveys, as stated in the instructions each response have a weight, im declaring a total
-- score variable that sums the numeric convertions of each response for each survey and then returns the sum as the score for the 
-- survey. So basically the higher the puntation the better since positive responses have a higher score as it can be seen in the 
-- CASE, strongly agree equals 5, agree equals 4, neutral equals 3, disagree equals 2, strongly disagree equals 1.

DELIMITER //

CREATE PROCEDURE CalculateSurveyScore(IN p_survey_id INT)
BEGIN
    DECLARE total_score INT DEFAULT 0;
    
    SELECT 
        SUM(CASE r.response_text
                WHEN 'Strongly Agree' THEN 5
                WHEN 'Agree' THEN 4
                WHEN 'Neutral' THEN 3
                WHEN 'Disagree' THEN 2
                WHEN 'Strongly Disagree' THEN 1
                ELSE 0
            END) INTO total_score
    FROM responses r
    JOIN questions q ON r.question_id = q.question_id
    WHERE q.survey_id = p_survey_id;
    
    SELECT total_score AS SurveyScore;
END //

DELIMITER ;


-- 2. View creatuib, again im using a CASE to create a scoring system, im optimizing this view using only the needed columns,
-- using joins and indexes at the join clauses, if i were not to use primary keys, indexes and joins this would be a less
-- efficient code 

CREATE VIEW SurveyResults AS
SELECT 
    s.survey_name,
    q.question_text,
    r.response_text,
    CASE r.response_text
        WHEN 'Strongly Agree' THEN 5
        WHEN 'Agree' THEN 4
        WHEN 'Neutral' THEN 3
        WHEN 'Disagree' THEN 2
        WHEN 'Strongly Disagree' THEN 1
        ELSE 0
    END AS score
FROM responses r
INNER JOIN questions q ON r.question_id = q.question_id
INNER JOIN surveys s ON q.survey_id = s.survey_id;