
-- THE ALU DATABASE — GROUP 2
-- Members: Ismael, Grace, Joy, Blair, Christa, Hassan, Rosanne

-- 1. DATABASE (Rosanne)
CREATE DATABASE group2_alu_db;
USE group2_alu_db;

-- 2. CREATE TABLES (in dependency order!)

-- STUDENTS TABLE (Ismael)
-- ===== STUDENTS TABLE (Ismael) =====
CREATE TABLE Students (
    student_id       INT PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(100),
    email            VARCHAR(100),
    classroom_id     INT,
    enrollment_date  DATE,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);;

-- CLASSROOM TABLE (Grace)
CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number  VARCHAR(10) NOT NULL,
    building     VARCHAR(50) NOT NULL,
    capacity     INT NOT NULL
);
-- FACULTY TABLE (Joy) 
CREATE TABLE Faculty ( 
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50)
);

-- COURSES TABLE (Blair)
CREATE TABLE Courses ( ... );

-- EXTRA_CURRICULAR_ACTIVITIES TABLE (Christa)
CREATE TABLE Extra_Curricular_Activities ( ... );

-- JUNCTION TABLES (Hassan)

CREATE TABLE Student_Courses (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
 );

CREATE TABLE Student_Activities (
    student_id INT NOT NULL,
    activity_id INT NOT NULL,
    participation_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id) ON DELETE CASCADE
);

-- 3. INSERT STATEMENTS

-- Ismael: insert into Students 
INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Kayirnaga Uwase',  'uwase@gmail.com',      1, '2025-09-01'),
('Aline Mugisha',    'mugisha@gmail.com',    2, '2025-09-01'),
('Ismail Niyonzima', 'niyonzima@gmail.com',  1, '2026-01-15'),
('Hassan Karim',     'h.karim@gmail.com',    3, '2026-01-15'),
('Brian Habimana',   'habimana@gmail.com',   2, '2025-09-01'),
('Grace Ingabire',   'g.ingabire@gmail.com', 3, '2026-01-15');;

-- Grace: insert into Classroom
INSERT INTO Classroom (room_number, building, capacity) VALUES
('A101', 'Main Block', 40),
('A102', 'Main Block', 35),
('B201', 'Science Wing', 30),
('B202', 'Science Wing', 25),
('C105', 'Innovation Hub', 50);

-- Joy: insert into Faculty
INSERT INTO Faculty (name, email, department) VALUES  
('Dr. Alice Smith', 'alice.smith@alueducation.com', 'Computer Science'),
('John Allen', 'johnallen@alueducation.com', 'Software Engineering'),
('Simeon Karekezi', 'simeonkare@alueducation.com', 'Leadership Skills'),
('Belyse Keza', 'belysekez@alueducation.com', 'Communication'),
('Jane Mukamana', 'janemukamana@alueducation.com', 'Business');

-- Hassan: insert into Junction Tables
INSERT INTO Student_Courses (student_id, course_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(4, 102),
(5, 101);

INSERT INTO Student_Activities (student_id, activity_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 2);


-- (and so on for each member)



-- 4. INDIVIDUAL UPDATE / DELETE / SELECT (labeled by name)

-- Ismael: DELETE — remove one student
DELETE FROM Students WHERE student_id = 6;

-- Ismael: SELECT — students who enrolled in 2025
SELECT name, email FROM Students WHERE enrollment_date < '2026-01-01';
-- (each member adds theirs the same way)
-- Joy: UPDATE - Change Dr. Alice Smith's email
UPDATE Faculty
SET email = 'dr.alice.smith@alueducation.com'
WHERE faculty_id = 1;

-- Joy : DELETE - remove John Allen
DELETE FROM Faculty
WHERE name = 'John Allen';

--Joy : SELECT - Faculty in the Business department
SELECT name, email
FROM Faculty
WHERE department = 'Business';

-- Grace: UPDATE — increase capacity of B201 after renovation
UPDATE Classroom SET capacity = 45 WHERE room_number = 'B201';

-- Grace: DELETE — remove classroom C105 (out of service)
DELETE FROM Classroom WHERE room_number = 'C105';

-- Grace: SELECT — Main Block classrooms seating 35+
SELECT room_number, building, capacity
FROM Classroom
WHERE building = 'Main Block' AND capacity >= 35;

-- Hassan: Individual Update (Change a student's enrollment date in a course)
UPDATE Student_Courses 
SET enrollment_date = '2026-02-01' 
WHERE student_id = 1 AND course_id = 101;

-- Hassan: Individual Delete (Drop a student from an activity)
DELETE FROM Student_Activities 
WHERE student_id = 4 AND activity_id = 3;

-- Hassan: Individual Select (See all students enrolled in course 101)
SELECT student_id, enrollment_date 
FROM Student_Courses 
WHERE course_id = 101;


-- 5. GROUP QUERIES

-- Join query 1 (Ismael + Blair): student → course → faculty → classroom

-->

-- Join query 2 (Grace + Joy): student → activity → faculty

SELECT CONCAT(s.name, ' participates in ', a.activity_name,
              ', advised by ', f.name, '.') AS sentence
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f ON a.faculty_advisor_id = f.faculty_id;

-- Join query 3 (Rosanne): our choice

-->

-- Aggregate query (Rosanne + Hassan): COUNT / GROUP BY
SELECT 
    c.course_name AS 'Course Name', 
    COUNT(sc.student_id) AS 'Total Students Enrolled'
FROM Courses c
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_name;
-->


-- 6. NORMALIZATION PARAGRAPH (Christa drafts, team reviews)


-- Our tables avoid duplication because... [short paragraph as a comment]

