











-- ** 인덱스를 이용한 검색 방법
--> WHERE 절에 인덱스가 지저된 컬럼을 언급하면



SELECT * FROM EMPLOYEE
WHERE EMP_ID = 215; -- 인덱스 사용 O

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '대북혼'; -- 인덱스 사용 X




-- 인덱스 확인용 테이블 생성
CREATE TABLE TB_IDX_TEST(
	TEST_NO NUMBER PRIMARY KEY, -- 자동으로 인덱스가 생성됨
	TEST_ID VARCHAR2(20) NOT NULL
);


-- TB-IDX_TEST 테이블에 샘플데이터 100만개 삽입 (PL/SQL 사용)
BEGIN
	FOR I IN 1..1000000
	LOOP
		INSERT INTO TB_IDX_TEST VALUES(I, 'TEST' || I);		
	END LOOP;
	
	COMMIT;
END;


-- 샘플데이터 100만개 확인
SELECT COUNT(*) FROM TB_IDX_TEST;


-- 'TEST500000' 찾기
SELECT * FROM TB_IDX_TEST WHERE TEST_ID = 'TEST50000'; -- 인덱스 X
-- 0.008s


SELECT * FROM TB_IDX_TEST
WHERE TEST_NO = 500000; -- 인덱스 0
-- 0.001s






















