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
WHERE JOB_CODE = (SELECT JOB_CODE
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
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE EMP_ID = (SELECT EMP_ID
				FROM EMPLOYEE
				GROUP BY DEPT_ID
				HAVING MIN(HIRE_DATE))
;


-- 7. 
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
				CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) / 12) 나이 
				FROM EMPLOYEE
				NATURAL JOIN JOB)
ORDER BY 나이 DESC;


















