--------------------------------------------------------------------------------
---------------------------------- DROP & CREATE -------------------------------
--------------------------------------------------------------------------------
DROP TABLE MEMBER;
DROP TABLE NOTICE;
DROP TABLE ADMIN; --CASCADE CONSTRAINTS;
DROP TABLE ATTRACTION;
DROP TABLE AT_REVIEW;
DROP TABLE ZONE;
DROP TABLE MEMBER_GRADE;
DROP SEQUENCE NOTICE_SEQ;
DROP SEQUENCE ATTRACTION_SEQ;
DROP SEQUENCE AC_REVIEW_SEQ;
DROP SEQUENCE AT_RPLY_SEQ;
CREATE SEQUENCE NOTICE_SEQ MAXVALUE 99999 NOCACHE NOCYCLE;
CREATE SEQUENCE ATTRACTION_SEQ MAXVALUE 999 NOCACHE NOCYCLE;
CREATE SEQUENCE AC_REVIEW_SEQ MAXVALUE 9999999 NOCACHE NOCYCLE;
CREATE SEQUENCE AT_RPLY_SEQ  MAXVALUE 9999999 NOCACHE NOCYCLE;
--------------------------------------------------------------------------------
------------------------------------ MEMBER  -----------------------------------
--------------------------------------------------------------------------------
CREATE TABLE MEMBER_GRADE (
    GRADE VARCHAR2(10) PRIMARY KEY,
    LOWVI NUMBER(6) NOT NULL,
    HIGHVI NUMBER(6) NOT NULL,
    DISC NUMBER(3) NOT NULL
);
INSERT INTO MEMBER_GRADE (GRADE, LOWVI, HIGHVI, DISC) 
    VALUES ('VIP', 30, 999999, 20);
INSERT INTO MEMBER_GRADE (GRADE, LOWVI, HIGHVI, DISC) 
    VALUES ('GOLD', 15, 29, 20);
INSERT INTO MEMBER_GRADE (GRADE, LOWVI, HIGHVI, DISC) 
    VALUES ('SILVER', 5, 14, 20);
INSERT INTO MEMBER_GRADE (GRADE, LOWVI, HIGHVI, DISC) 
    VALUES ('BRONZE', 0, 4, 20);

CREATE TABLE MEMBER (
    mID VARCHAR2(40) PRIMARY KEY,
    mMAIL VARCHAR2(50) NOT NULL UNIQUE,
    mPW VARCHAR2(20) NOT NULL,
    mNAME VARCHAR2(20) NOT NULL,
    mTEL VARCHAR2(15) NOT NULL UNIQUE,
    mVISIT NUMBER(3) DEFAULT 0 NOT NULL 
);

INSERT INTO MEMBER (MID, MMAIL, MPW, MNAME, MTEL)
    VALUES ('fff', 'hong@hong.com', '11', '홍길동', '010-9999-9999');
INSERT INTO MEMBER (MID, MMAIL, MPW, MNAME, MTEL)
    VALUES ('sss', 'song@song.com', '11', '송길동', '010-9999-8888');
INSERT INTO MEMBER (MID, MMAIL, MPW, MNAME, MTEL)
    VALUES ('bbb', 'back@back.com', '11', '백길동', '010-0100-0100');
INSERT INTO MEMBER (mID, mMAIL, mPW, mNAME, MTEL)
    VALUES ('aaa', 'aaa@naver.com', '111', '에이길동', '010-1111-1111');
INSERT INTO MEMBER (MID, MMAIL, MPW, MNAME, MTEL, MVISIT)
     VALUES ('zzz', 'aaa@gmail.com', '111', '제트길동', '010-3333-3333', 11);
INSERT INTO MEMBER (MID, MMAIL, MPW, MNAME, MTEL)
    VALUES ('ccc', 'ccc@naver.com', '111', '시길동', '010-2222-2222');

--------------------------------------------------------------------------------
-------------------------------------- ADMIN -----------------------------------
--------------------------------------------------------------------------------
CREATE TABLE ADMIN (
    adID    VARCHAR2(50) PRIMARY KEY,
    adPW    VARCHAR2(50) NOT NULL,
    adNAME  VARCHAR2(50) NOT NULL,
    adNUM   VARCHAR2(50) NOT NULL,
    adEMAIL VARCHAR2(100) NOT NULL
);
INSERT INTO ADMIN (ADID, ADPW, ADNAME, ADNUM, ADEMAIL)
    VALUES ('dbswls0209', '111', '장길동', '010-7777-7777', 'dbswls0209@naver.com');
--------------------------------------------------------------------------------
-------------------------------------- NOTICE  ---------------------------------
--------------------------------------------------------------------------------
CREATE TABLE NOTICE(
    nNO      NUMBER(5) PRIMARY KEY,
    nTITLE   VARCHAR2(50) NOT NULL,
    nCONTENT VARCHAR2(100) DEFAULT 'noImg.png' NOT NULL,
    nRDATE   DATE DEFAULT SYSDATE NOT NULL,
    nTYPE    VARCHAR2(50) NOT NULL,
    adID     VARCHAR2(50) REFERENCES ADMIN(adID) NOT NULL
);

INSERT INTO NOTICE (NNO, NTITLE, NTYPE, ADID)
    VALUES (NOTICE_SEQ.NEXTVAL, '새로운 이벤트 개최', '이벤트', 'dbswls0209');
INSERT INTO NOTICE (NNO, NTITLE, NTYPE, ADID)
    VALUES (NOTICE_SEQ.NEXTVAL, '새로운 내용', '뉴스/공지', 'dbswls0209');
INSERT INTO NOTICE (NNO, NTITLE, NTYPE, ADID)
    VALUES (NOTICE_SEQ.NEXTVAL, '새로운 뉴스', '이벤트', 'dbswls0209');
INSERT INTO NOTICE (NNO, NTITLE, NTYPE, ADID)
    VALUES (NOTICE_SEQ.NEXTVAL, '놀라운 이벤트', '이벤트', 'dbswls0209');
INSERT INTO NOTICE (NNO, NTITLE, NTYPE, ADID)
    VALUES (NOTICE_SEQ.NEXTVAL, '최고의', '이벤트', 'dbswls0209');
--------------------------------------------------------------------------------
------------------------------------- ZONE -------------------------------------
--------------------------------------------------------------------------------
CREATE TABLE ZONE (
    zNAME VARCHAR2(50) PRIMARY KEY,
    zPLACE VARCHAR2 (100),
    zLAT NUMBER(10,6), 
    zLNG NUMBER(10,6)
);
INSERT INTO ZONE (ZNAME, ZPLACE, ZLAT, ZLNG) 
    VALUES('익스트림존', '포곡읍 유운리 551-11', '37.29155203166443', '127.20072918697159');
INSERT INTO ZONE (ZNAME, ZPLACE, ZLAT, ZLNG) 
    VALUES('쿼리어려워존', '포곡읍 가실리 167-3', '37.28899758228319', '127.19806096107786');
INSERT INTO ZONE (ZNAME, ZPLACE, ZLAT, ZLNG) 
    VALUES('JAVA배워존', '포곡읍 전대리 506', '37.291065391982734', '127.20498180313548');
--------------------------------------------------------------------------------
----------------------------------- ATTRACTION ---------------------------------
--------------------------------------------------------------------------------
CREATE TABLE TEXT1(
    TEXTNUM NUMBER(3) DEFAULT 0 NOT NULL,
    TEXTSTRING VARCHAR2(50) NOT NULL
);
INSERT INTO TEXT1 (TEXTSTRING)
    VALUES('집가자');
DROP TABLE TEXT1;
DELETE FROM TEXT1;
SELECT * FROM TEXT1;
CREATE TABLE ATTRACTION (
    atCODE   NUMBER(3) PRIMARY KEY,
    atNAME VARCHAR2(50) NOT NULL,
    atCONTENT VARCHAR2(4000) NOT NULL,
    atADDR VARCHAR2 (100) NOT NULL,
    atIMAGE VARCHAR2 (100) DEFAULT 'noImg.png' NOT NULL,
    atRDATE DATE DEFAULT SYSDATE NOT NULL,
    atOLD NUMBER(3) DEFAULT 0 NOT NULL,
    atHEIGHT NUMBER(3) DEFAULT 0 NOT NULL,
    atLAT NUMBER(10,6) NOT NULL, 
    atLNG NUMBER(10,6) NOT NULL,
    adID     VARCHAR2(50) REFERENCES ADMIN(adID) NOT NULL,
    zNAME   VARCHAR2(50) REFERENCES ZONE(zNAME) NOT NULL
);

INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atHEIGHT, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, 'C익스프레스', '짜릿한 속도를 체감 할 수 있을겁니다', '경기 용인시 처인구 포곡읍 에버랜드로 199', 10, 150,  37.293099327122114, 127.20219040246639, 'dbswls0209', '익스트림존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atHEIGHT, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, 'J후룸라이드', '여름엔 역시...!', '경기 용인시 처인구 포곡읍 에버랜드로 199', 10, 150,  37.293099327122114, 127.20219040246639, 'dbswls0209', 'JAVA배워존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '귀신의 집 어려워', '으스스한 유령을 피해요', '경기 용인시 처인구 포곡읍 에버랜드로 199', 37.293099327122114, 127.20219040246639, 'dbswls0209', '쿼리어려워존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atHEIGHT, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '자이로드롭 어려워', '올라갈땐 1초 내려올땐 3분', '경기 용인시 처인구 포곡읍 에버랜드로 199', 10, 150,  37.293099327122114, 127.20219040246639, 'dbswls0209', '쿼리어려워존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, 'J미니트레일러', '잔잔한 롤러코스터 초급자 코스', '경기 용인시 처인구 포곡읍 에버랜드로 199', 7, 37.293099327122114, 127.20219040246639, 'dbswls0209', 'JAVA배워존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '범퍼카', '스트레스 풀고 갈 수 있는 절호의 기회', '경기 용인시 처인구 포곡읍 에버랜드로 199', 10,  37.293099327122114, 127.20219040246639, 'dbswls0209', '익스트림존');
--------------------------------------------------------------------------------
----------------------------------- AC_REVIEW --------------------------------
--------------------------------------------------------------------------------
CREATE TABLE AC_REVIEW (
    arvNUM NUMBER(7) PRIMARY KEY,
    arvRDATE DATE DEFAULT SYSDATE NOT NULL,
    arvCONTENT VARCHAR2(4000) NOT NULL,
    arvRATING NUMBER(2,1) NOT NULL,
    arv_HIT NUMBER(6) DEFAULT 0, 
    atCODE NUMBER(3) REFERENCES ATTRACTION(atCODE) NOT NULL,
    mID VARCHAR2(40) REFERENCES MEMBER(mID)
);
INSERT INTO AC_REVIEW(ARVNUM, ARVCONTENT, ARVRATING, ATCODE, MID)
    VALUES(AC_REVIEW_SEQ.NEXTVAL, '재밌었어요!', 5, 1, 'fff');
INSERT INTO AC_REVIEW(ARVNUM, ARVCONTENT, ARVRATING, ATCODE, MID)
    VALUES(AC_REVIEW_SEQ.NEXTVAL, '다음에 또 타고 싶어요!', 4, 2, 'sss');
INSERT INTO AC_REVIEW(ARVNUM, ARVCONTENT, ARVRATING, ATCODE, MID)
    VALUES(AC_REVIEW_SEQ.NEXTVAL, '아이가 너무 무서워 하네요... 저도 좀 무섭긴 했지만 재밌었어요!', 5, 3, 'bbb');
INSERT INTO AC_REVIEW(ARVNUM, ARVCONTENT, ARVRATING, ATCODE, MID)
    VALUES(AC_REVIEW_SEQ.NEXTVAL, '즐거웠습니다!', 5, 1, 'sss');
DROP TABLE AC_REVIEW CASCADE CONSTRAINTS;

--------------------------------------------------------------------------------
------------------------------------- AT_RPLY ----------------------------------
--------------------------------------------------------------------------------
CREATE TABLE AT_RPLY(
    apyNum NUMBER(7) PRIMARY KEY,
    adID VARCHAR2(50) REFERENCES ADMIN(adID),
    mID VARCHAR2(50) REFERENCES MEMBER(mID),
    atCODE NUMBER(3) REFERENCES ATTRACTION(atCODE) NOT NULL,
    apyTITLE VARCHAR2(50) NOT NULL,
    apyCONTENT VARCHAR2(4000) NOT NULL,
    apyRDATE DATE DEFAULT SYSDATE NOT NULL,
    apyGROUP NUMBER(7),
    apySTEP NUMBER(7),
    apyINDENT NUMBER(7),
    apyIP VARCHAR2(30) 
);
-- 글쓰기 
SELECT * FROM AT_RPLY;
INSERT INTO AT_RPLY (APYNUM, MID, ATCODE, APYTITLE, APYCONTENT, APYGROUP, APYSTEP, APYINDENT, APYIP)
    VALUES (AT_RPLY_SEQ.NEXTVAL, 'aaa', '1', '탑승관련', '어린 아이는 몇 살부터 탑승 가능 할까요?', AT_RPLY_SEQ.CURRVAL, 0, 0, '194.161.13.11');
INSERT INTO AT_RPLY (APYNUM, MID, ATCODE, APYTITLE, APYCONTENT, APYGROUP, APYSTEP, APYINDENT, APYIP)
    VALUES (AT_RPLY_SEQ.NEXTVAL, 'fff', '1', '탑승관련', '어린 아이는 몇 살부터 탑승 가능 할까요?', AT_RPLY_SEQ.CURRVAL, 0, 0, '194.161.13.11');
-- 답변글
UPDATE AT_RPLY ()
INSERT INTO AT_RPLY (APYNUM, ADID, ATCODE, APYCONTENT, APYGROUP, APYSTEP, APYINDENT)
    VALUES(AT_RPLY_SEQ.NEXTVAL, 'dbswls0209', '1', '만6세 이 후 부터 이용 가능합니다 감사합니다', )