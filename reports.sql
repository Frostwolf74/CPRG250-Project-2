SELECT
    firstname || ' ' || lastname as name,
    email,
    phonenumber as phone_number
FROM
    student
;

SELECT
    coursecode as course_code,
    name,
    numofcredits as number_of_credits,
    prereqcoursecode as prerequisite_course_code
FROM
    course
;

SELECT
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

SELECT -- select failing students belonging to a specific course section
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

SELECT -- count number of courses that

FROM
    student_course_record
;


