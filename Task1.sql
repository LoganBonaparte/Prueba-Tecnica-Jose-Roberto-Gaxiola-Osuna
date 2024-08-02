-- Creating the database

CREATE DATABASE task_1;

-- Select the database to use it

USE task_1;

-- Creation of table survey, I limited the survey_name to 50 characters due to being only the name. I definied the primary key in the
-- same row for simplicity, since I am not going to use a composite primary key, same applies to all tables
-- since evidently it is not efficient to use an index for each column on each table I will just define indexes for the columns that
-- will be most used in this hypotethical scenario

CREATE TABLE surveys (
    survey_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_name VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX (survey_id)
);

-- Creation of the users table, I am creating first the tables that do not reference any other 

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) UNIQUE NOT NULL,
    INDEX (user_id)
);

-- Creation of the table questions, limiting the question text to 100 since in this scenario the questions will not use more space than
-- that, added on delete cascade in the case a survey gets deleted in surveys table the rows that referenced that survey get deleted 
-- accordingly in questions table 

CREATE TABLE questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT,
    question_text VARCHAR(100) NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id) ON DELETE CASCADE,
    INDEX (question_id)
);

-- Creation of the responses table, delimiting the response text to a fixed range of answers using enum to enhance proper analytics

CREATE TABLE responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    question_id INT,
    response_text ENUM('Strongly Agree', 'Agree', 'Neutral', 'Disagree', 'Strongly Disagree') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE,
    INDEX (response_text)
);

-- now adding values

INSERT INTO surveys (survey_name, created_at) VALUES 
('Service Feedback', NOW()),
('Product Feedback', NOW()),
('Employee Satisfaction', NOW()),
('Customer Satisfaction', NOW());

-- IAdding data into 'questions'
INSERT INTO questions (survey_id, question_text) VALUES 
(1, 'Are you satisfied with the quality of our service?'),
(1, 'Would you recommend our service to a friend or colleague?'),
(2, 'Are you satisfied with the quality of our product?'),
(2, 'Would you recommend our product to a friend or colleague?'),
(3, 'Do you feel in a safe and secure work environment?'),
(3, 'Do you feel valued at work?'),
(4, 'Were you treated with respect by our staff?'),
(4, 'Would you visit us again?');

-- Adding data into 'users'
INSERT INTO users (user_name, user_email) VALUES 
('Jesus Salazar', 'jesussalazar@task1.com'),
('Roberto Gaxiola', 'robertogaxiola@task1.com'),
('Dayan Osuna', 'dayanosuna@task1.com'),
('Jose Osuna', 'jose@task1.com'),
('Evelyn Marin', 'evelyn@task1.com'),
('Julieta Martinez', 'julieta@task1.com');

-- Adding data into 'responses'
INSERT INTO responses (user_id, question_id, response_text) VALUES 
(1, 1, 'Agree'),
(1, 2, 'Agree'),
(1, 3, 'Agree'),
(1, 4, 'Agree'),
(1, 5, 'Agree'),
(1, 6, 'Agree'),
(1, 7, 'Agree'),
(1, 8, 'Agree'),
(2, 1, 'Agree'),
(2, 2, 'Agree'),
(2, 3, 'Agree'),
(2, 4, 'Agree'),
(2, 7, 'Agree'),
(2, 8, 'Agree'),
(3, 1, 'Agree'),
(3, 2, 'Agree'),
(3, 3, 'Agree'),
(3, 4, 'Agree'),
(3, 7, 'Agree'),
(3, 8, 'Agree'),
(4, 1, 'Agree'),
(4, 2, 'Agree'),
(4, 3, 'Agree'),
(4, 4, 'Agree'),
(4, 7, 'Agree'),
(4, 8, 'Agree'),
(5, 1, 'Agree'),
(5, 2, 'Agree'),
(5, 3, 'Agree'),
(5, 4, 'Agree'),
(5, 7, 'Agree'),
(5, 8, 'Agree'),
(6, 1, 'Agree'),
(6, 2, 'Agree'),
(6, 3, 'Agree'),
(6, 4, 'Agree');

-- SUMMARY
-- 1. SQL scripts to create the tables - done
-- 2. SQL scripts to insert sample data - done
-- 3. SQL scripts to create indexes - done in the create table statements