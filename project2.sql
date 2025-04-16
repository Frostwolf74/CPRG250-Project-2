----------------------------------------------------------------------
--     Database Modelling and Reporting Project: Create Tables      --
--                                                                  --
-- This project encapsulates creating tables, automating the        --
-- creation of sample data, populating tables with the sample       --
-- data and filtering and sorting data to prepare database reports. --
----------------------------------------------------------------------

-- This file is for creating the tables when the database is being first
-- initialized and for clearing and resetting all tables (if needed)
-- when the database already exists

BEGIN; -- start by deleting all tables
DROP TABLE IF EXISTS STUDENT_CREDENTIAL;
DROP TABLE IF EXISTS CREDENTIAL;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS STUDENT_COURSE_RECORD;
DROP TABLE IF EXISTS SCHEDULED_COURSE;
DROP TABLE IF EXISTS INSTRUCTOR;
COMMIT;

BEGIN; -- create the table that holds all instructors
CREATE TABLE INSTRUCTOR(
    instructorID INT NOT NULL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    prov VARCHAR(255) NOT NULL,
    postalCode VARCHAR(255) NOT NULL,
    phoneNumber BIGINT NOT NULL,
    email VARCHAR(255) NOT NULL
);
COMMIT;

BEGIN; -- create the table that holds all scheduled courses
CREATE TABLE SCHEDULED_COURSE(
    CRN INT NOT NULL PRIMARY KEY,
    semesterCode INT NOT NULL,
    courseCode VARCHAR(7) UNIQUE NOT NULL,
    sectionCode VARCHAR(1) NOT NULL
);
COMMIT;

BEGIN; -- create the table that holds all student course records
CREATE TABLE STUDENT_COURSE_RECORD(
    CRN INT NOT NULL REFERENCES SCHEDULED_COURSE(CRN),
    studentID INT UNIQUE NOT NULL,
    semesterCode INT NOT NULL,
    courseCode VARCHAR(7) NOT NULL REFERENCES SCHEDULED_COURSE(courseCode),
    credentialID INT NOT NULL,
    letterGrade VARCHAR(2) NOT NULL
);
COMMIT;

BEGIN; -- create the table that holds all students
CREATE TABLE STUDENT(
    studentID INT NOT NULL PRIMARY KEY REFERENCES STUDENT_COURSE_RECORD(studentID),
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    status VARCHAR(255) NOT NULL,
    phoneNumber BIGINT NOT NULL,
    email VARCHAR(255) NOT NULL
);
COMMIT;

BEGIN; -- create the table that holds all courses
CREATE TABLE COURSE(
    courseCode VARCHAR(7) UNIQUE NOT NULL PRIMARY KEY REFERENCES SCHEDULED_COURSE(courseCode),
    name VARCHAR(255) NOT NULL,
    numOfCredits INT NOT NULL,
    prereqCourseCode VARCHAR(7) NOT NULL
);
COMMIT;

BEGIN; -- create the table that holds all credentials
CREATE TABLE CREDENTIAL(
    credentialID INT NOT NULL PRIMARY KEY,
    school VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL
);
COMMIT;

BEGIN; -- create the table that holds all student credentials
CREATE TABLE STUDENT_CREDENTIAL(
    startDate DATE NOT NULL,
    completionDate DATE NOT NULL,
    credentialStatus VARCHAR(255) NOT NULL,
    GPA VARCHAR(255) NOT NULL
); 
COMMIT;