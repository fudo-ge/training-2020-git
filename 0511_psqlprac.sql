CREATE ROLE prac0511 LOGIN PASSWORD 'password';
\du
/*
*                                             ロール一覧
*  ロール名 |                                   属性                                   | 所属グループ
* ----------+--------------------------------------------------------------------------+--------------
*  emplo    |                                                                          | {}
*  postgres | スーパユーザ, ロール作成可, DB作成可, レプリケーション可, RLS のバイパス | {}
*  prac0511 |                                                                          | {}
*/

CREATE DATABASE "prac0511" WITH OWNER = prac0511 ENCODING = 'utf8'
CREATE SCHEMA prac_join AUTHORIZATION prac0511;

CREATE SEQUENCE prac_join.dogs_id_seq;
CREATE TABLE prac_join.dogs(
    id integer NOT NULL DEFAULT nextval('prac_join.dogs_id_seq'),
    name varchar(255) NOT NULL,
    owner_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_dogs PRIMARY KEY (id)
    );
\dn
/*
*      スキーマ一覧
*    名前    |  所有者
* -----------+----------
*  prac_join | prac0511
*  public    | postgres
*/
SHOW search_path;
/*
*  prac_join
* -------------
*  search_path
*/
SET search_path TO prac_join;
CREATE SEQUENCE owners_id_sqe;
CREATE TABLE owners(
    id integer  NOT NULL DEFAULT nextval('prac_join.owners_id_sqe'),
    name varchar(255) NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_owners PRIMARY KEY (id)
    );
DROP TABLE dogs;
CREATE TABLE dogs(
    id integer NOT NULL DEFAULT nextval('prac_join.dogs_id_seq'),
    name varchar(255) NOT NULL,
    owner_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_dogs PRIMARY KEY (id),
    CONSTRAINT fk_dogs FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE NO ACTION ON UPDATE NO ACTION
    );
\d
/*
*                  リレーション一覧
*  スキーマ  |     名前      |     型     |  所有者
* -----------+---------------+------------+----------
*  prac_join | dogs          | テーブル   | prac0511
*  prac_join | dogs_id_seq   | シーケンス | prac0511
*  prac_join | owners        | テーブル   | prac0511
*  prac_join | owners_id_sqe | シーケンス | prac0511
*/

INSERT INTO owners(name) VALUES('ichiro');
INSERT INTO owners(name) VALUES('jiro');
INSERT INTO owners(name) VALUES('saburo');

INSERT INTO dogs(name, owner_id) VALUES
    ('aka', 1),
    ('ao', 2),
    ('shiro', 1),
    ('kuro', 4);
/*
* ERROR:  テーブル"dogs"への挿入、更新は外部キー制約"fk_dogs"に違反しています
* DETAIL:  テーブル"owners"にキー(owner_id)=(4)がありません
*/
ALTER TABLE dogs DROP CONSTRAINT fk_dogs;
INSERT INTO dogs(name, owner_id) VALUES
    ('aka', 1),
    ('ao', 2),
    ('shiro', 1),
    ('kuro', 4);

SELECT * FROM dogs INNER JOIN owners ON dogs.owner_id = owners.id;
/*
*  id | name  | owner_id |         created_at         | id |  name  |         created_at
* ----+-------+----------+----------------------------+----+--------+----------------------------
*   5 | aka   |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*   6 | ao    |        2 | 2020-05-11 10:53:40.232976 |  2 | jiro   | 2020-05-11 10:47:08.23473
*   7 | shiro |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*/

SELECT * FROM dogs LEFT OUTER JOIN owners ON dogs.owner_id = owners.id;
/*
*  id | name  | owner_id |         created_at         | id |  name  |         created_at
* ----+-------+----------+----------------------------+----+--------+----------------------------
*   5 | aka   |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*   6 | ao    |        2 | 2020-05-11 10:53:40.232976 |  2 | jiro   | 2020-05-11 10:47:08.23473
*   7 | shiro |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*   8 | kuro  |        4 | 2020-05-11 10:53:40.232976 |    |        |
*/

SELECT * FROM dogs RIGHT OUTER JOIN owners ON dogs.owner_id = owners.id;
/*
*  id | name  | owner_id |         created_at         | id |  name  |         created_at
* ----+-------+----------+----------------------------+----+--------+----------------------------
*   5 | aka   |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*   6 | ao    |        2 | 2020-05-11 10:53:40.232976 |  2 | jiro   | 2020-05-11 10:47:08.23473
*   7 | shiro |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*     |       |          |                            |  3 | saburo | 2020-05-11 10:47:09.30002
*/

SELECT * FROM dogs FULL OUTER JOIN owners ON dogs.owner_id = owners.id;
/*
*  id | name  | owner_id |         created_at         | id |  name  |         created_at
* ----+-------+----------+----------------------------+----+--------+----------------------------
*   5 | aka   |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*   6 | ao    |        2 | 2020-05-11 10:53:40.232976 |  2 | jiro   | 2020-05-11 10:47:08.23473
*   7 | shiro |        1 | 2020-05-11 10:53:40.232976 |  1 | ichiro | 2020-05-11 10:46:46.256198
*   8 | kuro  |        4 | 2020-05-11 10:53:40.232976 |    |        |
*     |       |          |                            |  3 | saburo | 2020-05-11 10:47:09.30002
*/