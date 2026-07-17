-- ============================================================
-- THE ALU DATABASE — GROUP 2
-- Members: Ismael, Grace, Joy, Blair, Christa, Hassan, Rosanne
-- ============================================================

-- 1. DATABASE (Rosanne)
CREATE DATABASE IF NOT EXISTS group2_alu_db;
USE group2_alu_db;

-- 2. CREATE TABLES (dependency order)

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
    name       VARCHAR(100),
    email      VARCHAR(100),
    department VARCHAR(50)
);

-- STUDENTS TABLE (Ismael)
CREATE TABLE Students (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100),
    email           VARCHAR(100),
    classroom_id    INT,
    enrollment_date DATE,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- COURSES TABLE (Blair)
CREATE TABLE Courses (
    course_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_name  VARCHAR(100),
    credits      INT,
    faculty_id   INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id)   REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- EXTRA_CURRICULAR_ACTIVITIES TABLE (Christa)
CREATE TABLE Extra_Curricular_Activities (
    activity_id        INT PRIMARY KEY AUTO_INCREMENT,
    activity_name      VARCHAR(100),
    faculty_advisor_id INT,
    category           VARCHAR(50),
    FOREIGN KEY (faculty_advisor_id) REFERENCES Faculty(faculty_id)
);

-- JUNCTION TABLES (Hassan)
CREATE TABLE Student_Courses (
    student_id      INT NOT NULL,
    course_id       INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)  ON DELETE CASCADE
);

CREATE TABLE Student_Activities (
    student_id         INT NOT NULL,
    activity_id        INT NOT NULL,
    participation_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id)  REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id) ON DELETE CASCADE
);

-- 3. INSERT STATEMENTS (dependency order)

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
('Jane Mukamana', 'janemukamana@alueducation.com', 'Business'),
('Peter Nkusi', 'peternkusi@alueducation.com', 'Mathematics');

-- Ismael: insert into Students
INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Kayirnaga Uwase',  'uwase@gmail.com',      1, '2025-09-01'),
('Aline Mugisha',    'mugisha@gmail.com',    2, '2025-09-01'),
('Ismail Niyonzima', 'niyonzima@gmail.com',  1, '2026-01-15'),
('Hassan Karim',     'h.karim@gmail.com',    3, '2026-01-15'),
('Brian Habimana',   'habimana@gmail.com',   2, '2025-09-01'),
('Grace Ingabire',   'g.ingabire@gmail.com', 3, '2026-01-15');

-- Blair: insert into Courses
INSERT INTO Courses (course_name, credits, faculty_id, classroom_id) VALUES
('Introduction to Python',     3, 1, 1),
('Database Systems',           4, 2, 2),
('Communication Skills',       2, 3, 3),
('Entrepreneurial Leadership', 3, 1, 2),
('Web Development',            4, 2, 1),
('Data Structures',            3, 3, 3);

-- Christa: insert into Extra_Curricular_Activities
INSERT INTO Extra_Curricular_Activities (activity_name, faculty_advisor_id, category) VALUES
('Debate Club',   1, 'Academic'),
('Robotics Club', 2, 'STEM'),
('Chess Club',    3, 'Academic'),
('Drama Society', 1, 'Arts'),
('Football Team', 4, 'Sports');

-- Hassan: insert into junction tables
INSERT INTO Student_Courses (student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 2),
(5, 1);

INSERT INTO Student_Activities (student_id, activity_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 4),
(5, 2);

-- 4. INDIVIDUAL UPDATE / DELETE / SELECT (labeled by name)

-- Ismael: UPDATE — correct a student's email
UPDATE Students SET email = 'kayirnaga.uwase@gmail.com' WHERE student_id = 1;

-- Ismael: DELETE — remove one student
DELETE FROM Students WHERE student_id = 6;

-- Ismael: SELECT — students who enrolled in 2025
SELECT name, email FROM Students WHERE enrollment_date < '2026-01-01';

-- Grace: UPDATE — increase capacity of B201 after renovation
UPDATE Classroom SET capacity = 45 WHERE room_number = 'B201';

-- Grace: DELETE — remove classroom C105 (out of service)
DELETE FROM Classroom WHERE room_number = 'C105';

-- Grace: SELECT — Main Block classrooms seating 35+
SELECT room_number, building, capacity
FROM Classroom
WHERE building = 'Main Block' AND capacity >= 35;

-- Joy: UPDATE — change Dr. Alice Smith's email
UPDATE Faculty
SET email = 'dr.alice.smith@alueducation.com'
WHERE faculty_id = 1;

-- Joy: DELETE — remove Peter Nkusi
DELETE FROM Faculty WHERE name = 'Peter Nkusi';

-- Joy: SELECT — faculty in the Business department
SELECT name, email FROM Faculty WHERE department = 'Business';

-- Blair: UPDATE — change a course's credit value
UPDATE Courses SET credits = 5 WHERE course_id = 2;

-- Blair: DELETE — remove one course
DELETE FROM Courses WHERE course_id = 6;

-- Blair: SELECT — all courses worth 3+ credits
SELECT course_name, credits FROM Courses WHERE credits >= 3;

-- Christa: UPDATE — recategorize Football Team
UPDATE Extra_Curricular_Activities
SET category = 'Athletics'
WHERE activity_name = 'Football Team';

-- Christa: DELETE — remove Chess Club
DELETE FROM Extra_Curricular_Activities WHERE activity_name = 'Chess Club';

-- Christa: SELECT — activities advised by faculty 1
SELECT activity_name, category
FROM Extra_Curricular_Activities
WHERE faculty_advisor_id = 1;

-- Hassan: UPDATE — change a student's enrollment date in a course
UPDATE Student_Courses SET enrollment_date = '2026-02-01'
WHERE student_id = 1 AND course_id = 1;

-- Hassan: DELETE — student 4 drops activity 4
DELETE FROM Student_Activities WHERE student_id = 4 AND activity_id = 4;

-- Hassan: SELECT — everyone enrolled in course 1
SELECT student_id, enrollment_date FROM Student_Courses WHERE course_id = 1;

-- 5. GROUP QUERIES

-- Join query 1 (Ismael + Blair): student → course → faculty → classroom
SELECT CONCAT(s.name, ' is enrolled in ', c.course_name,
              ', taught by ', f.name,
              ', in ', cl.building, ' room ', cl.room_number) AS sentence
FROM Students s
JOIN Student_Courses sc ON s.student_id   = sc.student_id
JOIN Courses c          ON sc.course_id   = c.course_id
JOIN Faculty f          ON c.faculty_id   = f.faculty_id
JOIN Classroom cl       ON c.classroom_id = cl.classroom_id;

-- Join query 2 (Grace + Joy): student → activity → faculty
SELECT CONCAT(s.name, ' participates in ', a.activity_name,
              ', advised by ', f.name, '.') AS sentence
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f ON a.faculty_advisor_id = f.faculty_id;

-- Join query 3 (Rosanne): classroom hosts course with N students
SELECT
    CONCAT(cl.building, ' room ', cl.room_number) AS classroom,
    c.course_name,
    COUNT(sc.student_id) AS enrolled_students
FROM Classroom cl
JOIN Courses c               ON c.classroom_id = cl.classroom_id
LEFT JOIN Student_Courses sc ON sc.course_id   = c.course_id
GROUP BY cl.classroom_id, c.course_id;

-- Aggregate query (Rosanne + Hassan): how many students in each course
SELECT
    c.course_name,
    COUNT(sc.student_id) AS total_students
FROM Courses c
LEFT JOIN Student_Courses sc ON sc.course_id = c.course_id
GROUP BY c.course_id
ORDER BY total_students DESC;

-- 6. NORMALIZATION PARAGRAPH (Christa drafts, team reviews)

-- Our schema avoids data duplication by keeping each fact in exactly one
-- table. Faculty details (name, email, department) are stored once in
-- Faculty and referenced by ID from Courses and
-- Extra_Curricular_Activities, rather than repeating advisor names in
-- each row. Classroom details live only in Classroom and are referenced
-- by Students and Courses. The many-to-many relationships (a student
-- takes many courses, a course has many students; likewise for
-- activities) are handled by the junction tables Student_Courses and
-- Student_Activities, which store only ID pairs. Without them we would
-- either repeat full student rows per course or store course lists
-- inside the Students table, both of which cause update anomalies. Each
-- table has a primary key, and every non-key column depends on that key,
-- so the design satisfies third normal form (3NF).