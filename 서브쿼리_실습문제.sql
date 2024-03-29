-- 1. 
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE 
										FROM EMPLOYEE 
										WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연'
;

-- 2.
SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME, HIRE_DATE
FROM EMPLOYEE
NATURAL JOIN JOB 
WHERE SALARY = (SELECT MAX(SALARY) 
								FROM EMPLOYEE
								WHERE EXTRACT(YEAR FROM HIRE_DATE) > '2000')
;


-- 3. 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
NATURAL JOIN JOB
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
									FROM EMPLOYEE
									WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철'
;

-- 4. 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
										FROM EMPLOYEE
										WHERE EXTRACT(YEAR FROM HIRE_DATE) = '2000')
;

-- 5. 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID 
																	FROM EMPLOYEE 
																	WHERE EMP_NO LIKE '77%'
																	AND SUBSTR(EMP_NO, 8, 1) = '2')
;

-- 6. 
SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE, '소속없음'), JOB_NAME, HIRE_DATE
FROM (SELECT MIN(HIRE_DATE) HIRE_DATE 
			FROM EMPLOYEE 
			WHERE ENT_YN != 'Y'
			GROUP BY DEPT_CODE)
LEFT JOIN EMPLOYEE USING(HIRE_DATE)
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
ORDER BY HIRE_DATE
;

SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE, '소속없음'), JOB_NAME, HIRE_DATE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE) 
										FROM EMPLOYEE 
										WHERE ENT_YN != 'Y' 
										GROUP BY DEPT_CODE)
ORDER BY HIRE_DATE
;
-- 부서별로 그룹을 묶을 때 퇴사한 직원을 서브쿼리에서 제외해야함.
-- 왜? 부서별로 가장빠른 입사자를 구했을 때 D8 부서는 이태림임(퇴사자)
-- > 문제점 : 부서별로 가장 빠른 입사자를 구해놓고, 메인쿼리에서 퇴사자를 제외하면
-- D8 부서는 퇴사자인 이태림이 가장빠른 입사자이게에
-- 전제 부서중 D8 부서가 제외됨
--> 부서별로 가장 빠른 입사자를 구할때(서브쿼리) 퇴사한 직원을 뺀 상태에서 그룹으로 묶으면
-- D8 부서의 가장빠른 입사자는 이태림 제외 후 전형돈이 됨


-- 7. 
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
				CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) / 12) 나이, 
				TO_CHAR(SALARY * 12 * (NVL(BONUS, 0) + 1), 'L999,999,999') "보너스 포함 연봉"
				FROM EMPLOYEE
				JOIN JOB USING(JOB_CODE))
ORDER BY 나이 DESC;


















