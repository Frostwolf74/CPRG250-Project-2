----------------------------------------------------------------------
--     Database Modelling and Reporting Project: Create Reports     --
--                                                                  --
-- This project encapsulates creating tables, automating the        --
-- creation of sample data, populating tables with the sample       --
-- data and filtering and sorting data to prepare database reports. --
----------------------------------------------------------------------

-- This file is used for filtering and sorting data to prepare individual
-- reports on the database

SELECT -- show a quick view of all students with relevant information
    firstname || ' ' || lastname as name,
    email,
    phonenumber as phone_number
FROM
    student
ORDER BY lastname
;

SELECT -- show a quick view of all courses with relevant information
    coursecode as course_code,
    name,
    numofcredits as number_of_credits,
    prereqcoursecode as prerequisite_course_code
FROM
    course
;

SELECT -- show all scheduled courses in section A and B
    *
FROM
    scheduled_course
WHERE
    sectioncode = 'A' OR sectioncode == 'B'
ORDER BY
    sectioncode DESC
;

SELECT -- preview student performance
    (CASE
        WHEN lettergrade = 'A+' OR lettergrade = 'A'
        THEN 'Excellent'
        ELSE (CASE
                WHEN lettergrade = 'A-' OR lettergrade = 'B+' OR lettergrade = 'B' OR lettergrade = 'B-'
                THEN 'Good'
                ELSE (CASE
                        WHEN lettergrade = 'C+' OR lettergrade = 'C' OR lettergrade = 'C-'
                        THEN 'Average'
                        ELSE 'Limited'
                      END)
              END)
     END) as performance,
    student.studentid as student_id,
    firstname || ' ' || lastname as name,
    lettergrade,
    email,
    phonenumber as phone_number,
    status
FROM
    scheduled_course LEFT JOIN student_course_record
        ON scheduled_course.crn = student_course_record.crn
        LEFT JOIN student
            ON student.studentid = student_course_record.studentid
ORDER BY
    performance
;

SELECT -- select all failing students belonging to a specific course section
    sectioncode as section,
    firstname || ' ' || lastname as name,
    (SELECT
         coursecode
     FROM
         student_course_record
     WHERE
         student.studentid = student_course_record.studentid
    ) as courses,
    lettergrade,
    email,
    phonenumber as phone_number,
    status
FROM
    student_course_record LEFT JOIN student USING(studentid)
        LEFT JOIN scheduled_course using (crn)
WHERE
    lettergrade = 'F' and sectioncode = 'C'
;

SELECT -- count the number of courses that are in section E
    count(sectioncode) number_of_sections,
    coursecode
FROM
    (SELECT * FROM scheduled_course
        WHERE sectioncode = 'E') as sc
GROUP BY
    coursecode
;



