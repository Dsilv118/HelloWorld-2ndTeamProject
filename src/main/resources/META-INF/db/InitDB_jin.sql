SELECT * FROM MEMBER;
SELECT * FROM NOTICE;
SELECT * FROM ADMIN;
SELECT * FROM ATTRACTION;
SELECT * FROM ZONE;
SELECT * FROM AC_REVIEW;
--------------------------------------------------------------------------------
--------------------------------- ADMIN QUERY ----------------------------------
--------------------------------------------------------------------------------
-- (1) 관리자 계정 로그인
SELECT * FROM ADMIN WHERE ADID = 'dbswls0209' AND ADPW='111';

-- (2) 로그인 후 세션에 넣을 용도 : ADMIN ADID로 (MODEL, VO, DTO) 가져오기
SELECT * FROM ADMIN WHERE ADID = 'dbswls0209';

-- (3) 전체 회원 목록 출력 (startRow~endRow)
SELECT *
    FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT * FROM MEMBER ORDER BY MVISIT DESC)A)
    WHERE RN BETWEEN 1 AND 10;
    
-- (4) 회원 삭제 
SELECT * FROM MEMBER WHERE MID = 'ddd';

--------------------------------------------------------------------------------
---------------------------------- NOTICE QUERY --------------------------------
--------------------------------------------------------------------------------
-- (1) 공지사항 리스트 출력 - 최신 글 맨 위로 (startRow ~ end Row)
SELECT * FROM NOTICE ORDER BY NRDATE DESC;
SELECT *
    FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT * FROM NOTICE ORDER BY NRDATE DESC)A)
    WHERE RN BETWEEN 2 AND 4;
-- (2) 전체 글 갯수
SELECT COUNT(*) FROM NOTICE;
-- (3) 공지사항 글쓰기
INSERT INTO NOTICE(NNO, NTITLE, NTYPE, ADID)
    VALUES(NOTICE_SEQ.NEXTVAL, '개강 맞이 안녕 세상아!', '이벤트/뉴스', 'dbswls0209');
-- (4) 공지사항 상세보기
SELECT * FROM NOTICE WHERE NNO = 1;
-- (5) 공지사항 수정하기
UPDATE NOTICE 
    SET NTITLE = '반갑습니다 환상의 나라',
        NCONTENT = 'HelloWorld',
        NTYPE = '뉴스/공지'
    WHERE NNO = 1;
-- (6) 공지사항 삭제하기
DELETE FROM NOTICE WHERE NNO = 1; 
SELECT * FROM NOTICE;

--------------------------------------------------------------------------------
--------------------------------- AC_REVIEW QUERY ------------------------------
--------------------------------------------------------------------------------
-- (1) 리뷰 리스트 출력 (ATCODE별 리스트 작성일 역순)
    -- 1. 
SELECT * FROM AC_REVIEW WHERE ATCODE = 1 ORDER BY ARVRDATE DESC; 
SELECT * 
    FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT * FROM AC_REVIEW WHERE ATCODE = 1 ORDER BY ARVRDATE DESC)A)
    WHERE RN BETWEEN 2 AND 3;
    -- 2.  
-- (2) 리뷰 갯수 (ATCODE별 토탈 갯수)
SELECT COUNT(*) FROM AC_REVIEW WHERE ATCODE =1;

-- (3) 리뷰 조회수 증가
UPDATE AC_REVIEW SET arv_HIT = arv_HIT +1
    WHERE ATCODE = 1 AND ARVNUM=5;

-- (4) 리뷰 상세보기 
    -- 1. schitem 이 null 또는 '' 일 때
SELECT * FROM AC_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE DESC;
    -- 2. schitem 이 'all' 일 때
SELECT * FROM AC_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE, ARV_HIT, ARVRATING DESC;
    -- 3. schitem 이 'arv_HIT' 일 때
SELECT * FROM AC_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE, ARV_HIT DESC;
    -- 4. schitem 이 'arv_HIT' 일 때
SELECT * FROM AC_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE DESC, ARV_HIT ASC;
    -- 5. schitem 이 'arvRATING' (내림차순) 일 때 
SELECT * FROM AC_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE, ARVRATING DESC;
    -- 6. schitem 이 'arvRATING' (오름차순) 일 때
SELECT * FROM AC_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE DESC, ARVRATING ASC;
-- (5) 리뷰 등록
SELECT * FROM AC_REVIEW;
INSERT INTO AC_REVIEW (ARVNUM, ARVCONTENT, ARVRATING, ATCODE, MID)
    VALUES(AC_REVIEW_SEQ.NEXTVAL, '재밌게 놀다가 갑니다', 4, 1, 'bbb');

-- (6) 리뷰 수정
UPDATE AC_REVIEW
    SET ARVCONTENT = '지나가다가 귀여운 인형탈 아저씨가 아이에게 솜사탕을 주셨어요 감사합니다',
        ARVRATING = 5,
        ATCODE = 1,
        MID = 'bbb'
    WHERE ARVNUM = 11;
-- (7) 리뷰 삭제
DELETE FROM AC_REVIEW WHERE MID='bbb' AND ATCODE=4;


--------------------------------------------------------------------------------
------------------------------ ATTRACTION QUERY --------------------------------
--------------------------------------------------------------------------------
SELECT * FROM ATTRACTION;
-- (1) id = attractionList 기구 리스트 출력 (startRow, endRow) 
    -- 1. schitem이 'null' 이거나 '' 일 때
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME ORDER BY ATCODE DESC )A)
    WHERE RN BETWEEN 2 AND 4;
    -- 2. schitem이 'all' 일 떄 
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME  AND Z.ZNAME = '익스트림존' AND ATOLD >=10 AND ATHEIGHT>=150 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 3. schitem이 'ZNAME'
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME 
        FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME  AND Z.ZNAME = '익스트림존' ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 4. schitem이 'ATOLD'
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND ATOLD >=10 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 5. schitem이 'ATHEIGHT'
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND ATHEIGHT>=150 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 6. schitem 이 'ZNAME' 이거나 'ATOLD' 일 떄
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATOLD >=10 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 7. schitem 이 'ZNAME' 이거나 'ATHEIGHT' 일 때
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATHEIGHT>=150 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 8. schitem 'ATOLD' 이거나 'ATHEIGHT' 일 때
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND  ATOLD >=10 AND ATHEIGHT>=0 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    
-- (2) id = totCntAttraction 등록된 기구 갯수
    -- 1. schitem이 'null' 이거나 '' 일 때
SELECT COUNT(*) FROM ATTRACTION;
    -- 2. schitem이 'all' 일 떄 
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATOLD >=10 AND ATHEIGHT>=150;
    -- 3. schitem이 'ZNAME'
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' ;
    -- 4. schitem이 'ATOLD'
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATOLD >=10;
    -- 5. schitem이 'ATHEIGHT'
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATHEIGHT>=150;
    -- 6. schitem 이 'ZNAME' 이거나 'ATOLD' 일 떄
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATOLD >=10;
    -- 7. schitem 이 'ZNAME' 이거나 'ATHEIGHT' 일 때
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATHEIGHT>=150;
    -- 8. schitem 'ATOLD' 이거나 'ATHEIGHT' 일 때
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATOLD >=10 AND ATHEIGHT>=150;

-- (3) id = getDetailAttraction (기구 번호로 dto 가져오기)
SELECT * FROM ATTRACTION WHERE ATCODE = 1;

-- (4) id = registerAttraction (기구 등록)
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atHEIGHT, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '볼 하우스', '볼에서 즐겨요', '경기 용인시 처인구 포곡읍 에버랜드로 199', 10, 150,  37.293099327122114, 127.20219040246639, 'dbswls0209', '익스트림존');

-- (5) id = modifyAttraction (기구 수정)
UPDATE ATTRACTION SET
    atNAME = '레이싱 코스터',
    atCONTENT = '빠르게 달려봐요',
    atADDR = '경기 용인시 처인구 포곡읍 에버랜드로 199',
    atOLD = '6',
    atHEIGHT = '0',
    atLAT = '37.293099327122114',
    atLNG = '127.20219040246639',
    adID = 'dbswls0209',
    zNAME = '쿼리어려워존'
    WHERE atCODE = '7';
 
-- (6) id = deleteAttraction (기구 삭제)
DELETE FROM ATTRACTION WHERE ATCODE = 8;