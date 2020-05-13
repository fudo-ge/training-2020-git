CREATE SEQUENCE meibo_id_seq;
CREATE TABLE gender(
    gender_type varchar(6) NOT NULL,
    gender_name char(2) NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    updated_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_gender PRIMARY KEY (gender_type)
);
CREATE TABLE meibo(
    id integer NOT NULL DEFAULT nextval('meibo_id_seq'),
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    gender_type varchar(255) NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    updated_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_meibo PRIMARY KEY (id),
    CONSTRAINT fk_gender_type FOREIGN KEY (gender_type)
        REFERENCES gender(gender_type) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT ck_gender_type CHECK ( gender_type IN ('MALE', 'FEMALE') )
);
CREATE SEQUENCE subjects_id_seq;
CREATE TABLE subjects(
    id integer NOT NULL DEFAULT nextval('subjects_id_seq'),
    name varchar(255) NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    updated_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_subjects PRIMARY KEY (id)
);
CREATE SEQUENCE points_id_seq;
CREATE TABLE points(
    id integer NOT NULL DEFAULT nextval('points_id_seq'),
    student_id integer NOT NULL,
    subjects_id integer NOT NULL,
    points integer NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    updated_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_points PRIMARY KEY (id),
    CONSTRAINT fk_student_id FOREIGN KEY (student_id)
        REFERENCES meibo(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_subjects_id FOREIGN KEY (subjects_id)
        REFERENCES subjects(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO gender(gender_type, gender_name) VALUES
    ('MALE', '男性'),
    ('FEMALE', '女性');
SELECT gender.gender_type, gender.gender_name FROM gender;
/*
*  gender_type | gender_name
* -------------+-------------
*  MALE        | 男性
*  FEMALE      | 女性
*/

INSERT INTO meibo(first_name, last_name, gender_type) VALUES
    ('陽介', '岡本', 'MALE'),
    ('俊', '新里', 'MALE'),
    ('美穂', '野上', 'FEMALE'),
    ('明夫', '蓮沼', 'MALE'),
    ('沙耶', '杉本', 'FEMALE'),
    ('恵里香', '園崎', 'FEMALE'),
    ('修一郎', '城山', 'MALE'),
    ('涼香', '園崎', 'FEMALE'),
    ('栄一', '戸田', 'MALE'),
    ('美穂', '山野', 'FEMALE');
SELECT meibo.id, meibo.last_name, meibo.first_name, meibo.gender_type
    FROM meibo ORDER BY meibo.id;
/*
*  id | last_name | first_name | gender_type
* ----+-----------+------------+-------------
*   1 | 岡本      | 陽介       | MALE
*   2 | 新里      | 俊         | MALE
*   3 | 野上      | 美穂       | FEMALE
*   4 | 蓮沼      | 明夫       | MALE
*   5 | 杉本      | 沙耶       | FEMALE
*   6 | 園崎      | 恵里香     | FEMALE
*   7 | 城山      | 修一郎     | MALE
*   8 | 園崎      | 涼香       | FEMALE
*   9 | 戸田      | 栄一       | MALE
*  10 | 山野      | 美穂       | FEMALE
*/

INSERT INTO subjects(name) VALUES
    ('Java'),
    ('RDBMS'),
    ('HTML/CSS'),
    ('JavaScript'),
    ('jQuery'),
    ('PhotoShop');
SELECT subjects.id, name FROM subjects ORDER BY subjects.id;
/*
*  id |    name
* ----+------------
*   1 | Java
*   2 | RDBMS
*   3 | HTML/CSS
*   4 | JavaScript
*   5 | jQuery
*   6 | PhotoShop
*/

INSERT INTO points(student_id, subjects_id, points, created_at, updated_at) VALUES
    (1, 1, 45, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (2, 1, 75, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (3, 1, 80, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (4, 1, 75, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (5, 1, 50, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (6, 1, 65, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (7, 1, 45, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (8, 1, 95, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (9, 1, 85, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06'),
    (10, 1, 30, TIMESTAMP '2019-05-08 17:05:06', TIMESTAMP '2019-05-08 17:05:06');
INSERT INTO points(student_id, subjects_id, points, created_at, updated_at) VALUES
    (1, 3, 75, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (2, 3, 65, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (3, 3, 75, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (4, 3, 60, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (5, 3, 65, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (6, 3, 30, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (7, 3, 55, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (8, 3, 85, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (9, 3, 100, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32'),
    (10, 3, 85, TIMESTAMP '2019-05-13 16:45:32', TIMESTAMP '2019-05-13 16:45:32');
INSERT INTO points(student_id, subjects_id, points, created_at, updated_at) VALUES
    (1, 2, 85, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (2, 2, 85, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (3, 2, 95, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (4, 2, 90, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (5, 2, 100, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (6, 2, 75, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (7, 2, 70, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (8, 2, 100, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (9, 2, 70, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42'),
    (10, 2, 65, TIMESTAMP '2019-05-15 17:08:42', TIMESTAMP '2019-05-15 17:08:42');
INSERT INTO points(student_id, subjects_id, points, created_at, updated_at) VALUES
    (1, 1, 60, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (2, 1, 75, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (3, 1, 40, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (4, 1, 55, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (5, 1, 85, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (6, 1, 40, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (8, 1, 25, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (9, 1, 35, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12'),
    (10, 1, 40, TIMESTAMP '2019-05-22 16:56:12', TIMESTAMP '2019-05-22 16:56:12');
INSERT INTO points(student_id, subjects_id, points, created_at, updated_at) VALUES
    (1, 5, 80, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (2, 5, 60, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (3, 5, 55, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (4, 5, 80, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (5, 5, 100, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (6, 5, 95, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (8, 5, 95, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (9, 5, 50, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56'),
    (10, 5, 70, TIMESTAMP '2019-05-26 16:53:56', TIMESTAMP '2019-05-26 16:53:56');
INSERT INTO points(student_id, subjects_id, points, created_at, updated_at) VALUES
    (1, 4, 80, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (2, 4, 65, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (3, 4, 85, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (4, 4, 90, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (5, 4, 75, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (6, 4, 80, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (8, 4, 45, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (9, 4, 70, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31'),
    (10, 4, 95, TIMESTAMP '2019-06-02 16:50:31', TIMESTAMP '2019-06-02 16:50:31');
SELECT points.id, points.student_id, points.subjects_id, points.points
    FROM points ORDER BY points.id;
/*
*  id | student_id | subjects_id | points
* ----+------------+------------+--------
*   1 |          1 |          1 |     45
*   2 |          2 |          1 |     75
*   3 |          3 |          1 |     80
*   4 |          4 |          1 |     75
*   5 |          5 |          1 |     50
*   6 |          6 |          1 |     65
*   7 |          7 |          1 |     45
*   8 |          8 |          1 |     95
*   9 |          9 |          1 |     85
*  10 |         10 |          1 |     30
*  11 |          1 |          3 |     75
*  12 |          2 |          3 |     65
*  13 |          3 |          3 |     75
*  14 |          4 |          3 |     60
*  15 |          5 |          3 |     65
*  16 |          6 |          3 |     30
*  17 |          7 |          3 |     55
*  18 |          8 |          3 |     85
*  19 |          9 |          3 |    100
*  20 |         10 |          3 |     85
*  21 |          1 |          2 |     85
*  22 |          2 |          2 |     85
*  23 |          3 |          2 |     95
*  24 |          4 |          2 |     90
*  25 |          5 |          2 |    100
*  26 |          6 |          2 |     75
*  27 |          7 |          2 |     70
*  28 |          8 |          2 |    100
*  29 |          9 |          2 |     70
*  30 |         10 |          2 |     65
*  31 |          1 |          1 |     60
*  32 |          2 |          1 |     75
*  33 |          3 |          1 |     40
*  34 |          4 |          1 |     55
*  35 |          5 |          1 |     85
*  36 |          6 |          1 |     40
*  37 |          8 |          1 |     25
*  38 |          9 |          1 |     35
*  39 |         10 |          1 |     40
*  40 |          1 |          5 |     80
*  41 |          2 |          5 |     60
*  42 |          3 |          5 |     55
*  43 |          4 |          5 |     80
*  44 |          5 |          5 |    100
*  45 |          6 |          5 |     95
*  46 |          8 |          5 |     95
*  47 |          9 |          5 |     50
*  48 |         10 |          5 |     70
*  49 |          1 |          4 |     80
*  50 |          2 |          4 |     65
*  51 |          3 |          4 |     85
*  52 |          4 |          4 |     90
*  53 |          5 |          4 |     75
*  54 |          6 |          4 |     80
*  55 |          8 |          4 |     45
*  56 |          9 |          4 |     70
*  57 |         10 |          4 |     95
*/

SELECT meibo.id AS "生徒番号",
    (meibo.last_name || ' ' || meibo.first_name) AS "生徒氏名",
    gender.gender_name AS "性別"
    FROM meibo
    INNER JOIN gender ON meibo.gender_type = gender.gender_type
    ORDER BY id;
/*
*  生徒番号 |  生徒氏名   | 性別
* ----------+-------------+------
*         1 | 岡本 陽介   | 男性
*         2 | 新里 俊     | 男性
*         3 | 野上 美穂   | 女性
*         4 | 蓮沼 明夫   | 男性
*         5 | 杉本 沙耶   | 女性
*         6 | 園崎 恵里香 | 女性
*         7 | 城山 修一郎 | 男性
*         8 | 園崎 涼香   | 女性
*         9 | 戸田 栄一   | 男性
*        10 | 山野 美穂   | 女性
*/

SELECT meibo.id AS "生徒番号",
    (meibo.last_name || ' ' || meibo.first_name) AS "生徒氏名",
    gender.gender_name AS "性別"
    FROM meibo
    INNER JOIN gender ON meibo.gender_type = gender.gender_type
    WHERE meibo.first_name = '美穂'
    ORDER BY id;
/*
*  生徒番号 | 生徒氏名  | 性別
* ----------+-----------+------
*         3 | 野上 美穂 | 女性
*        10 | 山野 美穂 | 女性
*/

SELECT meibo.id AS "生徒番号",
    (meibo.last_name || ' ' || meibo.first_name) AS "生徒氏名",
    gender.gender_name AS "性別"
    FROM meibo
    INNER JOIN gender ON meibo.gender_type = gender.gender_type
    WHERE meibo.last_name LIKE '%野%'
    ORDER BY id;
/*
*  生徒番号 | 生徒氏名  | 性別
* ----------+-----------+------
*         3 | 野上 美穂 | 女性
*        10 | 山野 美穂 | 女性
*/

SELECT meibo.id AS "生徒番号",
    (meibo.last_name || ' ' || meibo.first_name) AS "生徒氏名",
    gender.gender_name AS "性別"
    FROM meibo
    INNER JOIN gender ON meibo.gender_type = gender.gender_type
    WHERE meibo.id IN (2, 3, 5, 7)
    ORDER BY id;
/*
*  生徒番号 |  生徒氏名   | 性別
* ----------+-------------+------
*         2 | 新里 俊     | 男性
*         3 | 野上 美穂   | 女性
*         5 | 杉本 沙耶   | 女性
*         7 | 城山 修一郎 | 男性
*/

SELECT meibo.id AS "生徒番号",
    (meibo.last_name || ' ' || meibo.first_name) AS "生徒氏名",
    gender.gender_name AS "性別"
    FROM meibo
    INNER JOIN gender ON meibo.gender_type = gender.gender_type
    WHERE meibo.id BETWEEN 4 AND 6
    ORDER BY id;
/*
*  生徒番号 |  生徒氏名   | 性別
* ----------+-------------+------
*         4 | 蓮沼 明夫   | 男性
*         5 | 杉本 沙耶   | 女性
*         6 | 園崎 恵里香 | 女性
*/

SELECT subjects.name AS "教科名",
    (meibo.last_name || ' ' || meibo.first_name) AS "生徒氏名",
    points.points AS "点数"
    FROM points
    INNER JOIN subjects ON points.subjects_id = subjects.id
    INNER JOIN meibo ON points.student_id = meibo.id
    WHERE subjects.name = 'Java'
    ORDER BY meibo.id;
/*
*   教科名  |  生徒氏名   | 点数
* ----------+-------------+------
*  HTML/CSS | 岡本 陽介   |   75
*  HTML/CSS | 新里 俊     |   65
*  HTML/CSS | 野上 美穂   |   75
*  HTML/CSS | 蓮沼 明夫   |   60
*  HTML/CSS | 杉本 沙耶   |   65
*  HTML/CSS | 園崎 恵里香 |   30
*  HTML/CSS | 城山 修一郎 |   55
*  HTML/CSS | 園崎 涼香   |   85
*  HTML/CSS | 戸田 栄一   |  100
*  HTML/CSS | 山野 美穂   |   85
*/

SELECT u.name AS "教科名",
    SUM(u.points) AS "合計点"
    FROM (
        SELECT subjects.name, points.points
            FROM points
            RIGHT OUTER JOIN subjects ON points.subjects_id = subjects.id
    ) AS u
    GROUP BY u.name
    ORDER BY SUM(u.points) DESC NULLS LAST, u.name;
/*
*    教科名   | 合計点
* ------------+--------
*  Java       |   1100
*  RDBMS      |    835
*  HTML/CSS   |    695
*  JavaScript |    685
*  jQuery     |    685
*  PhotoShop  |
*/