SELECT * FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA LIMIT 100;


-------=======================================================================================================================================================

---// Hypothesis for EDA:
--1. Univariate Analysis
--2. Does patients length of stay (LOS) changes wrt HOSPITAL_TYPE_CODE?
--3. Does patients length of stay (LOS) changes wrt CITY_CODE_HOSPITAL?
--4. Does patients length of stay (LOS) changes wrt HOSPITAL_REGION_CODE?
--5. DEPARTMENT of admission and its impact on LOS
--6. DEPARTMENT X HOSPITAL_REGION_CODE and its impact on LOS
--7. Does more AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL impact a patients LOS
--8. TYPE_OF_ADMISSION and its impact on LOS
--9. SEVERITY_OF_ILLNESS and its impact on LOS
--10. AGE and its impact on LOS
--11. ADMISSION_DEPOSIT and its relation to LOS
--12. Does more visitors come with patients who have more severe illness?
--13. Is there any differences in the LOS for different WARD_TYPE & WARD_FACILITY_CODE in each DEPARTMENT
--14. Does BED_GRADE affects LOS of patients?
--15. Does more visitors come when younger patients got admitted than the older patients?
--16. What type of illness & admission does majority of patients who are less than 30 years of age have and which department most of them are getting admitted to?
--17. Are patients below 40 years pay more ADMISSION_DEPOSIT when they get admitted to the hospital?

-------=======================================================================================================================================================

-- // 1. Univariate Analysis //

-- Query 1: Unique number of hospital codes and their distribution
-- Count the occurrences of each hospital code and the number of unique cases for each code
SELECT HOSPITAL_CODE, COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 2: Unique number of hospital type code and their distribution
-- Count the occurrences of each hospital type code, the number of unique hospital codes, and the number of unique cases for each code
SELECT HOSPITAL_TYPE_CODE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE, COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 3: Unique number of city code hospital and their distribution
-- Count the occurrences of each city code hospital, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each code
SELECT CITY_CODE_HOSPITAL, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 4: Unique number of hospital region code and their distribution
-- Count the occurrences of each hospital region code, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each code
SELECT HOSPITAL_REGION_CODE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 5: Unique number of department and their distribution
-- Count the occurrences of each department, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each department
SELECT DEPARTMENT, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 6: Unique number of Bed grade and their distribution
-- Count the occurrences of each bed grade, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each grade
SELECT BED_GRADE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 7: Unique number of admission type and their distribution
-- Count the occurrences of each admission type, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each type
SELECT TYPE_OF_ADMISSION, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 8: Unique number of severity of illness and their distribution
-- Count the occurrences of each severity of illness, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each severity
SELECT SEVERITY_OF_ILLNESS, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Query 9: Unique number of Age groups and their distribution
-- Count the occurrences of each age group, the number of unique hospital codes, the number of unique hospital type codes, and the number of unique cases for each group
SELECT AGE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;



----========================================================================

-- // 2/3/4. Does patients length of stay (LOS) change with respect to HOSPITAL_TYPE_CODE/CITY_CODE_HOSPITAL/HOSPITAL_REGION_CODE? //

-- Query 1: Patients length of stay (LOS) analysis based on HOSPITAL_TYPE_CODE
-- Calculate the minimum, maximum, average, and median length of stay for each HOSPITAL_TYPE_CODE
SELECT HOSPITAL_TYPE_CODE, 
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

-- Query 2: Patients length of stay (LOS) analysis based on CITY_CODE_HOSPITAL
-- Calculate the minimum, maximum, average, and median length of stay for each CITY_CODE_HOSPITAL
SELECT CITY_CODE_HOSPITAL, 
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

-- Query 3: Patients length of stay (LOS) analysis based on HOSPITAL_REGION_CODE
-- Calculate the minimum, maximum, average, and median length of stay for each HOSPITAL_REGION_CODE
SELECT HOSPITAL_REGION_CODE, 
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;



----========================================================================

-- // 5. DEPARTMENT of admission and its impact on LOS //

-- Query 1: Impact of DEPARTMENT on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for each DEPARTMENT
SELECT DEPARTMENT, 
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 6. DEPARTMENT X HOSPITAL_REGION_CODE and its impact on LOS //

-- Query 2: Impact of DEPARTMENT and HOSPITAL_REGION_CODE on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for each combination of DEPARTMENT and HOSPITAL_REGION_CODE
SELECT DEPARTMENT, HOSPITAL_REGION_CODE, 
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1, 2;

----========================================================================

-- // 7. Does more AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL impact a patient's LOS // (Insight)

-- Query 3: Impact of AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for different levels of AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL
-- Also, count the number of distinct cases for each level
SELECT AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;


----========================================================================

-- // 8. TYPE_OF_ADMISSION and its impact on LOS // (Insight)

-- Query 1: Impact of TYPE_OF_ADMISSION on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for each TYPE_OF_ADMISSION
-- Also, count the number of distinct cases for each TYPE_OF_ADMISSION
SELECT TYPE_OF_ADMISSION,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 9. SEVERITY_OF_ILLNESS and its impact on LOS // (Insight)

-- Query 2: Impact of SEVERITY_OF_ILLNESS on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for each SEVERITY_OF_ILLNESS
-- Also, count the number of distinct cases for each SEVERITY_OF_ILLNESS
SELECT SEVERITY_OF_ILLNESS,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 10. AGE and its impact on LOS // (Insight)

-- Query 3: Impact of AGE on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for each AGE group
-- Also, count the number of distinct cases for each AGE group
SELECT AGE,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;


----========================================================================

-- // 11. ADMISSION_DEPOSIT and its relation to LOS //

-- Query 1: Identify distinct values of ADMISSION_DEPOSIT
-- ADMISSION_DEPOSIT ranges from 1800 to 11000
SELECT DISTINCT ADMISSION_DEPOSIT FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA;

-- Common Table Expression (CTE): BASE
-- Assign a DEPOSIT_BUCKET based on the value of ADMISSION_DEPOSIT
-- Bucketing is done as follows: '1. Less than 3K', '2. Between 3K to 7K', '3. Greater than 7K'
WITH BASE AS (
    SELECT ADMISSION_DEPOSIT,
            CASE WHEN ADMISSION_DEPOSIT <= 3000 THEN '1. Less than 3K'
                 WHEN ADMISSION_DEPOSIT > 7000 THEN '3. Greater than 7K'   
                 ELSE '2. Between 3K to 7K' END AS DEPOSIT_BUCKET,
            ADMISSION_DATE,
            DISCHARGE_DATE,
            CASE_ID
    FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
)

-- Uncomment the line below to view the data in the BASE CTE
-- SELECT * FROM BASE;

-- Query 2: Impact of ADMISSION_DEPOSIT on Length of Stay (LOS)
-- Calculate the minimum, maximum, average, and median length of stay for each DEPOSIT_BUCKET
-- Also, count the number of distinct cases for each DEPOSIT_BUCKET
SELECT DEPOSIT_BUCKET,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM BASE
GROUP BY 1
ORDER BY 1;


----========================================================================

-- // 12. Does more visitors come with patients who have more severe illness? //

-- Query: Impact of SEVERITY_OF_ILLNESS on the number of visitors with patients
-- Calculate the count, minimum, maximum, average, and median number of visitors with patients for each SEVERITY_OF_ILLNESS
SELECT SEVERITY_OF_ILLNESS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(VISITORS_WITH_PATIENT) AS MIN_VISITORS,
        MAX(VISITORS_WITH_PATIENT) AS MAX_VISITORS,
        AVG(VISITORS_WITH_PATIENT) AS AVG_VISITORS,
        MEDIAN(VISITORS_WITH_PATIENT) AS MEDIAN_VISITORS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;




----========================================================================

-- // 13. Is there any differences in the LOS for different WARD_TYPE & WARD_FACILITY_CODE in each DEPARTMENT // (Insight)

-- Query 1: LOS analysis for different WARD_TYPE & WARD_FACILITY_CODE in each DEPARTMENT
-- Calculate the count, minimum, maximum, average, and median length of stay for each combination of DEPARTMENT, WARD_TYPE, and WARD_FACILITY_CODE
SELECT DEPARTMENT, WARD_TYPE, WARD_FACILITY_CODE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;

-- Query 2: LOS analysis for different SEVERITY_OF_ILLNESS in each DEPARTMENT
-- Calculate the count, minimum, maximum, average, and median length of stay for each combination of DEPARTMENT and SEVERITY_OF_ILLNESS
SELECT DEPARTMENT, SEVERITY_OF_ILLNESS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1, 2
ORDER BY 1, 2;


----========================================================================

-- // 14. Does BED_GRADE affect LOS of patients? // (Insight)

-- Query 1: Impact of BED_GRADE on Length of Stay (LOS)
-- Calculate the count, minimum, maximum, average, and median length of stay for each BED_GRADE
SELECT BED_GRADE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

-- Query 2: Impact of SEVERITY_OF_ILLNESS and BED_GRADE on Length of Stay (LOS)
-- Calculate the count, minimum, maximum, average, and median length of stay for each combination of SEVERITY_OF_ILLNESS and BED_GRADE
SELECT SEVERITY_OF_ILLNESS, BED_GRADE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day, ADMISSION_DATE, DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1, 2
ORDER BY 1, 2;

----========================================================================

-- // 15. Does more visitors come when younger patients got admitted than the older patients? // (Insight)

-- Query: Impact of AGE on the number of visitors with patients
-- Calculate the count, minimum, maximum, average, and median number of visitors with patients for each AGE group
SELECT AGE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(VISITORS_WITH_PATIENT) AS MIN_VISITORS,
        MAX(VISITORS_WITH_PATIENT) AS MAX_VISITORS,
        AVG(VISITORS_WITH_PATIENT) AS AVG_VISITORS,
        MEDIAN(VISITORS_WITH_PATIENT) AS MEDIAN_VISITORS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1
ORDER BY 1;


----========================================================================

-- // 16. What type of illness & admission does the majority of patients who are less than 30 years of age have, and which department most of them are getting admitted to? //

-- Common Table Expression (CTE): BASE
-- Filter data for patients aged 0-10, 20-29 years
WITH BASE AS (
    SELECT * 
    FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
    WHERE AGE IN ('0-10', '20-Nov', '21-30')
)

-- Common Table Expression (CTE): ILLNESS_N_ADMISSION
-- Count the number of cases for each combination of TYPE_OF_ADMISSION and SEVERITY_OF_ILLNESS
, ILLNESS_N_ADMISSION AS (
    SELECT TYPE_OF_ADMISSION, SEVERITY_OF_ILLNESS,
            COUNT(DISTINCT CASE_ID) AS CNT_CASES
    FROM BASE 
    GROUP BY 1, 2
    ORDER BY 1, 2
)

-- Common Table Expression (CTE): DEPARTMENT
-- Count the number of cases for each DEPARTMENT
, DEPARTMENT AS (
    SELECT DEPARTMENT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
    FROM BASE 
    GROUP BY 1
)

-- Uncomment the lines below to view the data in the BASE, ILLNESS_N_ADMISSION, and DEPARTMENT CTEs
-- SELECT * FROM BASE; -- 43,417 cases
-- SELECT * FROM ILLNESS_N_ADMISSION;
-- SELECT * FROM DEPARTMENT;


----========================================================================

-- // 17. Are patients below 40 years pay more ADMISSION_DEPOSIT when they get admitted to the hospital? // (Insight)

-- Common Table Expression (CTE): BASE
-- Assign a binary indicator (BELOW_40_IND) for patients below 40 years
WITH BASE AS (
    SELECT *,
            CASE WHEN AGE IN ('0-10', '20-Nov', '21-30', '31-40') THEN 1 ELSE 0 END AS BELOW_40_IND            
    FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
)

-- Query: Impact of BELOW_40_IND on ADMISSION_DEPOSIT
-- Calculate the minimum, maximum, and average ADMISSION_DEPOSIT for patients below and above 40 years
SELECT BELOW_40_IND,
        MIN(ADMISSION_DEPOSIT) AS MIN_DEP,
        MAX(ADMISSION_DEPOSIT) AS MAX_DEP,
        AVG(ADMISSION_DEPOSIT) AS AVG_DEP
FROM BASE 
GROUP BY 1;


----========================================================================
----========================================================================

