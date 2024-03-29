SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE,
			 NVL(DEPT_TITLE, '부서없음') "DEPT_TITLE", JOB_NAME, SALARY,
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING (JOB_CODE)
ORDER BY EMP_ID;


SELECT *
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE,
			 NVL(DEPT_TITLE, '부서없음') "DEPT_TITLE", JOB_NAME, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_TITLE = '인사관리부'
ORDER BY EMP_ID;

SELECT DEPT_CODE, SUM(SALARY) DEPT_SUM
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE,
			 NVL(DEPT_TITLE, '부서없음') "DEPT_TITLE", JOB_NAME, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING (JOB_CODE)
WHERE EMP_NO = '870927-1313564';



SELECT JOB_NAME, TRUNC(AVG(SALARY) ,1) AV
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
GROUP BY JOB_NAME;








