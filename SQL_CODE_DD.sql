Oracle/SQL Server Metadata SQL Code
--SQL Server
SELECT A.TABLE_NAME,A.COLUMN_NAME,
    CASE
     WHEN A.DATA_TYPE='int' THEN 'INT'
     WHEN A.DATA_TYPE='bigint' THEN 'BIGINT'
     WHEN A.DATA_TYPE='smallint' THEN 'SMALLINT'
     WHEN A.DATA_TYPE='tinyint' THEN 'TINYINT'
     WHEN A.DATA_TYPE='float' THEN 'FLOAT'
     WHEN A.DATA_TYPE='real' THEN 'REAL'
     WHEN A.DATA_TYPE='date' THEN 'DATE'
     WHEN A.DATA_TYPE='smalldatetime' THEN 'SMALLDATETIME'
     WHEN A.DATA_TYPE='datetime' THEN 'DATETIME'
     WHEN A.DATA_TYPE='datetime2' THEN 'DATETIME2'
     WHEN A.DATA_TYPE='time' THEN 'TIME'
     WHEN A.DATA_TYPE='varchar'
         THEN 'VARCHAR('
              + CONVERT(VARCHAR,CHARACTER_MAXIMUM_LENGTH) + ')'
    END AS DATTYP,
    CASE WHEN A.IS_NULLABLE='YES' THEN 'NULL'
         WHEN A.IS_NULLABLE='NO' THEN 'NOT NULL'
    END AS NULLRES,
    DENSE_RANK() OVER (ORDER BY A.TABLE_NAME) as TABLE_NUM,
    COUNT(*) OVER (PARTITION BY A.TABLE_NAME) as TOTAL_COLS,
    B.TOTAL_TABLES
    FROM TESTDB.INFORMATION_SCHEMA.COLUMNS A,
        (SELECT COUNT(DISTINCT TABLE_NAME) AS TOTAL_TABLES
          FROM TESTDB.INFORMATION_SCHEMA.Columns
          WHERE TABLE_NAME IN (...subset for tables here...)) B
    WHERE A.TABLE_NAME IN (...subset for tables here...)
    ORDER BY A.TABLE_NAME,A.ORDINAL_POSITION;

--Oracle
SELECT TABLE_NAME,
       COLUMN_NAME,
       CASE
        WHEN DATA_TYPE='DATE' THEN 'DATE'
        WHEN DATA_TYPE='VARCHAR2'
            THEN 'VARCHAR2(' || TO_CHAR(DATA_LENGTH) || ')'
         WHEN DATA_TYPE='NUMBER' AND DATA_PRECISION IS NOT NULL
             THEN 'NUMBER(' || TO_CHAR(DATA_PRECISION)
                            || ',' || TO_CHAR(DATA_SCALE) || ')'
         WHEN DATA_TYPE='NUMBER' AND DATA_PRECISION IS NULL
             THEN 'NUMBER'
         WHEN DATA_TYPE='BLOB' THEN 'BLOB'
         WHEN DATA_TYPE='ROWID' THEN 'ROWID'
         WHEN DATA_TYPE='CHAR'
             THEN 'CHAR(' || TO_CHAR(DATA_LENGTH) || ')'
         ELSE 'UNKNOWN'
        END AS DATTYP,
        CASE
         WHEN NULLABLE='N' THEN 'NOT NULL'
         WHEN NULLABLE='Y' THEN 'NULL'
         ELSE 'NULL?'
        END AS NULLRES,
        DENSE_RANK() OVER (ORDER BY TABLE_NAME) as TABLE_NUM,
        COUNT(*) OVER (PARTITION BY TABLE_NAME) as TOTAL_COLS,
        COUNT(DISTINCT TABLE_NAME) OVER () as TOTAL_TABLES
  FROM ALL_TAB_COLUMNS
  WHERE (OWNER='enter-schema-name-here')
  ORDER BY TABLE_NAME,COLUMN_ID;

Oracle/SQL Server Data Dictionary Tables
--SQL Server
CREATE TABLE DATADICT_DB_DEFN(DB_ID int,
                              DB_NAME varchar(30))

CREATE TABLE DATADICT_TABLE_NAME(DB_ID int,
                                 TABLE_ID int,
                                 TABLE_NAME varchar(30))

CREATE TABLE DATADICT_TABLE_DESC(DB_ID int,
                                 TABLE_ID int,
                                 TABLE_DESC varchar(2000))

CREATE TABLE DATADICT_COLUMN_DEFN(DB_ID int,
                                  TABLE_ID int,
                                  COLUMN_ID int,
                                  COLUMN_NAME varchar(30),
                                  DATA_TYPE varchar(20),
                                  NULLABILITY varchar(10))

CREATE TABLE DATADICT_COLUMN_DESC(DB_ID int,
                                  TABLE_ID int,
                                  COLUMN_ID int,
                                  COLUMN_NAME varchar(30),
                                  COLUMN_DESC varchar(2000))

CREATE TABLE DATADICT_CAVEAT_DESC(DB_ID int,
                                  TABLE_ID int,
                                  CAVEAT_ID int,
                                  CAVEAT_DESC varchar(2000))

CREATE TABLE DATADICT_FUNCPROC_NAME(DB_ID int,
                                    FUNCPROC_ID int,
                                    FUNCPROC_TYPE varchar(1),
                                    FUNCPROC_NAME varchar(30))

CREATE TABLE DATADICT_FUNCPROC_DESC(DB_ID int,
                                    FUNCPROC_ID int,
                                    FUNCPROC_DESC varchar(2000))

CREATE TABLE DATADICT_FUNCPROCCAVEAT_DESC(DB_ID int,
                                      FUNCPROC_ID int,
                                      CAVEAT_ID int,
                                      CAVEAT_DESC varchar(2000))

CREATE TABLE DATADICT_ARGUMENT_DESC(DB_ID int,
                                    FUNCPROC_ID int,
                                    ARGUMENT_ID int,
                                    ARGUMENT_NAME varchar(30),
                                    ARGUMENT_DESC varchar(2000))

CREATE TABLE DATADICT_ARGUMENT_DEFN(DB_ID int,
                                    FUNCPROC_ID int,
                                    ARGUMENT_ID int,
                                    ARGUMENT_NAME varchar(30),
                                    DIRECTION varchar(6),
                                    DATATYPE varchar(10))

CREATE TABLE DATADICT_CODEFRAGMENTS_DESC(DB_ID int,
                                         TABLE_ID int,
                                         FRAGMENT_ID int,
                                         FRAGMENT_LINE int,
                                         FRAGMENT_DESC varchar(2000),
                                         FRAGMENT_CODE varchar(2000))

--Oracle
CREATE TABLE DATADICT_DB_DEFN(DB_ID NUMBER,
                              DB_NAME VARCHAR2(30));

CREATE TABLE DATADICT_CAVEAT_DESC(DB_ID NUMBER,
                                  TABLE_ID NUMBER,
                                  CAVEAT_ID NUMBER,
                                  CAVEAT_DESC VARCHAR2(2000))


CREATE TABLE DATADICT_COLUMN_DEFN(DB_ID NUMBER,
                                  TABLE_ID NUMBER,
                                  COLUMN_ID NUMBER,
                                  COLUMN_NAME VARCHAR2(30),
                                  DATA_TYPE VARCHAR2(20),
                                  NULLABILITY VARCHAR2(10))


CREATE TABLE DATADICT_COLUMN_DESC(DB_ID NUMBER,
                                  TABLE_ID NUMBER,
                                  COLUMN_ID NUMBER,
                                  COLUMN_NAME VARCHAR2(30),
                                  COLUMN_DESC VARCHAR2(2000))


CREATE TABLE DATADICT_TABLE_DESC(DB_ID NUMBER,
                                 TABLE_ID NUMBER,
                                 TABLE_DESC VARCHAR2(2000))

CREATE TABLE DATADICT_TABLE_NAME(DB_ID NUMBER,
                                 TABLE_ID NUMBER,
                                 TABLE_NAME VARCHAR2(30))

CREATE TABLE DATADICT_FUNCPROC_NAME(DB_ID NUMBER,
                                    FUNCPROC_ID NUMBER,
                                    FUNCPROC_TYPE VARCHAR2(1),
                                    FUNCPROC_NAME VARCHAR2(30))

CREATE TABLE DATADICT_FUNCPROC_DESC(DB_ID NUMBER,
                                    FUNCPROC_ID NUMBER,
                                    FUNCPROC_DESC VARCHAR2(2000))

CREATE TABLE DATADICT_FUNCPROCCAVEAT_DESC(DB_ID NUMBER,
                                      FUNCPROC_ID NUMBER,
                                      CAVEAT_ID NUMBER,
                                      CAVEAT_DESC VARCHAR2(2000))

CREATE TABLE DATADICT_ARGUMENT_DESC(DB_ID NUMBER,
                                    FUNCPROC_ID NUMBER,
                                    ARGUMENT_ID NUMBER,
                                    ARGUMENT_NAME VARCHAR2(30),
                                    ARGUMENT_DESC VARCHAR2(2000))

CREATE TABLE DATADICT_ARGUMENT_DEFN(DB_ID NUMBER,
                                    FUNCPROC_ID NUMBER,
                                    ARGUMENT_ID NUMBER,
                                    ARGUMENT_NAME VARCHAR2(30),
                                    DIRECTION VARCHAR2(6),
                                    DATATYPE VARCHAR2(10))

CREATE TABLE DATADICT_CODEFRAGMENTS_DESC(DB_ID NUMBER,
                                         TABLE_ID NUMBER,
                                         FRAGMENT_ID NUMBER,
                                         FRAGMENT_LINE NUMBER,
                                         FRAGMENT_DESC VARCHAR2(2000),
                                         FRAGMENT_CODE VARCHAR2(2000))

Proactive Checker SQL Code
--Oracle Only
--Table mis-matches
SELECT CASE
        WHEN A.TABLE_NAME IS NOT NULL
             AND B.TABLE_NAME IS NULL THEN '*****NEW*****'
        WHEN A.TABLE_NAME IS NULL
             AND B.TABLE_NAME IS NOT NULL THEN '*****DEL*****'
        WHEN A.TABLE_NAME IS NOT NULL
             AND B.TABLE_NAME IS NOT NULL THEN '*****BOTH****'
       END AS ACTION,
       A.TABLE_NAME AS ORACLE_TABLE_NAME,
       B.TABLE_NAME AS DICT_TABLE_NAME
 FROM ALL_TABLES A FULL OUTER JOIN DATADICT_TABLE_NAME B
 ON A.TABLE_NAME=B.TABLE_NAME
 WHERE A.OWNER IS NULL
       OR A.OWNER='enter-schema-name-here'
 ORDER BY 1,2;

--Column mis-matches
SELECT CASE
        WHEN A.COLUMN_NAME IS NOT NULL
             AND B.COLUMN_NAME IS NULL THEN '*****NEW*****'
        WHEN A.COLUMN_NAME IS NULL
             AND B.COLUMN_NAME IS NOT NULL THEN '*****DEL*****'
        WHEN A.COLUMN_NAME IS NOT NULL
             AND B.COLUMN_NAME IS NOT NULL THEN '*****BOTH****'
       END AS ACTION,
       A.TABLE_NAME AS ORACLE_TABLE_NAME,
       A.COLUMN_NAME AS ORACLE_COLUMN_NAME,
       B.TABLE_NAME AS DICT_TABLE_NAME,
       B.COLUMN_NAME AS DICT_COLUMN_NAME
 FROM ALL_TAB_COLUMNS A FULL OUTER JOIN (
   SELECT Y.TABLE_NAME,X.COLUMN_NAME
    FROM DATADICT_COLUMN_DEFN X INNER JOIN DATADICT_TABLE_NAME Y
    ON X.DB_ID=Y.DB_ID
       AND X.TABLE_ID=Y.TABLE_ID) B
 ON A.TABLE_NAME=B.TABLE_NAME
    AND A.COLUMN_NAME=B.COLUMN_NAME
 WHERE A.OWNER IS NULL
       OR A.OWNER='enter-schema-name-here'
 ORDER BY 1,2;

--Data Type and Nullability mis-matches
SELECT CASE
        WHEN A.DATTYP=B.DATA_TYPE THEN '*****MATCH*****'
        ELSE '*****MIS-MATCH*****'
       END AS DATA_TYPE_ACTION,
       CASE
        WHEN A.NULLRES=B.NULLABILITY THEN '*****MATCH*****'
        ELSE '*****MIS-MATCH*****'
       END AS NULLABILITY_ACTION,
       A.TABLE_NAME AS ORACLE_TABLE_NAME,
       A.COLUMN_NAME AS ORACLE_COLUMN_NAME,
       A.DATTYP AS ORACLE_DATA_TYPE,
       A.NULLRES AS ORACLE_NULLABILITY,
       B.TABLE_NAME AS DICT_TABLE_NAME,
       B.COLUMN_NAME AS DICT_COLUMN_NAME,
       B.DATA_TYPE AS DICT_DATA_TYPE,
       B.NULLABILITY AS DICT_NULLABILITY
 FROM (
       SELECT TABLE_NAME,COLUMN_NAME,
       CASE
         WHEN DATA_TYPE='DATE' THEN 'DATE'
         WHEN DATA_TYPE='VARCHAR2'
              THEN 'VARCHAR2(' || TO_CHAR(DATA_LENGTH) || ')'
         WHEN DATA_TYPE='NUMBER' AND DATA_PRECISION IS NOT NULL
              THEN 'NUMBER(' || TO_CHAR(DATA_PRECISION)
                            || ',' || TO_CHAR(DATA_SCALE) || ')'
         WHEN DATA_TYPE='NUMBER' AND DATA_PRECISION IS NULL
              THEN 'NUMBER'
         WHEN DATA_TYPE='BLOB' THEN 'BLOB'
         WHEN DATA_TYPE='ROWID' THEN 'ROWID'
         WHEN DATA_TYPE='CHAR'
              THEN 'CHAR(' || TO_CHAR(DATA_LENGTH) || ')'
         ELSE 'UNKNOWN'
        END AS DATTYP,
        CASE
         WHEN NULLABLE='N' THEN 'NOT NULL'
         WHEN NULLABLE='Y' THEN 'NULL'
         ELSE 'NULL?'
        END AS NULLRES
        FROM ALL_TAB_COLUMNS
        WHERE OWNER='enter-schema-name-here'
       ) A
      FULL OUTER JOIN
      (
       SELECT Y.TABLE_NAME,X.COLUMN_NAME,
              X.DATA_TYPE,X.NULLABILITY
        FROM DATADICT_COLUMN_DEFN X
              INNER JOIN DATADICT_TABLE_NAME Y
        ON X.DB_ID=Y.DB_ID
           AND X.TABLE_ID=Y.TABLE_ID
      ) B
 ON A.TABLE_NAME=B.TABLE_NAME
    AND A.COLUMN_NAME=B.COLUMN_NAME
 ORDER BY 1,2;
