import random
import string

import psycopg2

def write_database(query: str):
    conn = None
    cur = None

    try:
        conn = psycopg2.connect(
            host='localhost',
            database='postgres',
            user='postgres',
            password='admin',
            port=5432
        )

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()

    except Exception as e:
        print(e)
    finally:
        if cur is not None:
            cur.close()
        if conn is not None:
            conn.close()


for i in range(1,100+1):
    random_letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    rand_postcode = ""

    for _ in range(0,6):
        rand_postcode += random_letters[random.randint(0, len(random_letters)-1)]

    insert_query = f'''
        INSERT INTO instructor VALUES (
            {i},
            'First Name {i}',
            'Last Name {i}',
            'Address {i}',
            'City {i}',
            'AB',
            '{rand_postcode}',
            RPAD({i}::text, 10, '1')::BIGINT,
            'instructor{i}@example.com'
        );
    '''
    write_database(insert_query)


for i in range(1,200+1):
    sect_code = ['A', 'B', 'C', 'D', 'E', 'F']
    random_letter = sect_code[random.randint(0, len(sect_code)-1)]

    insert_query = f'''
        INSERT INTO scheduled_course VALUES (
            LPAD({i}::text, 5, '0')::INT,
            202503,
            'CCCC' || LPAD({1+i}::text, 3, '0')::VARCHAR,
            '{random_letter}'
        );
    '''
    write_database(insert_query)


j = 1
k = 1
for i in range(1,5000+1):
    if i % 125 == 0: # iterates through 5000 without going over 40 (course limit)
        j += 1

    if i % 500 == 0:
        k += 1

    grades = ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F']
    random_grade = grades[random.randint(0, len(grades)-1)]

    insert_query = f'''
        INSERT INTO student_course_record VALUES (
            LPAD({j}::text, 5, '0')::INT,
            {i},
            202503,
            'CCCC' || LPAD({1+k}::text, 3, '0')::VARCHAR,
            {j},
            '{random_grade}'
        );
    '''
    write_database(insert_query)


for i in range(1,5000+1):
    status = ['A', 'AP', 'S', 'E']
    random_status = status[random.randint(0, len(status)-1)]
    if(random_status == 'A'):
        random_status = 'A - 202403'

    insert_query = f'''
        INSERT INTO student VALUES (
            {i},
            'First Name {i}',
            'Last Name {i}',
            '{random_status}',
            RPAD({i+100}::text, 10, '1')::BIGINT,
            'student{i}@example.com'         
        );
    '''
    write_database(insert_query)


for i in range(1,40+1):
    insert_query = f'''
        INSERT INTO credential VALUES (
            {i},
            'School Name',
            'Credential Name',
            'CT'
        );
    '''
    write_database(insert_query)


for i in range(1,200+1):
    insert_query = f'''
        INSERT INTO course VALUES (
            'CCCC' || LPAD({1+i}::text, 3, '0')::VARCHAR,
            'Course Name',
            5,
            'CCCC' || LPAD({i-1}::text, 3, '0')::VARCHAR
        );
    '''
    write_database(insert_query)