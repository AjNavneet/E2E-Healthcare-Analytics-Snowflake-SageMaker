# End-to-End Healthcare Analytics using Snowflake and AWS SageMaker

## Business Overview

Healthcare analytics involves utilizing data and analytical methods to enhance healthcare service delivery and patient outcomes. This project focuses on analyzing Patient Length of Stay (LOS), a critical metric affecting patient outcomes, healthcare costs, and hospital capacity.

By leveraging Snowflake and AWS, this project aims to improve patient outcomes, reduce costs, and enhance overall healthcare delivery through comprehensive analytics.

---

## Aim:

1. Data Analysis in Snowflake
2. Build a Machine Learning model to predict the length of stay for patients
3. Schedule the AWS Sagemaker Notebook
4. Perform live data scoring and insert predictions into Snowflake
5. Send status mail

---

## Data

Training data for approximately 230k patients is stored in Snowflake across various regions and hospitals, with 19 features. Additionally, simulation data for 71k patients is available for prediction purposes.

---

## Approach

1. **Introduction to Snowflake and Snowflake Worksheet**
2. **Exploratory Data Analysis (EDA) in Snowflake**
3. **Feature Engineering in Snowflake**
4. **AWS Sagemaker Setup**
5. **Data Retrieval from Snowflake using snowflake-connector-python and snowflake-sqlalchemy**
6. **Data Preprocessing**
7. **Feature Selection**
8. **Model Building**
   - Linear Regression
   - Random Forest Regression
   - XGBoost Regression
9. **Model Predictions**
10. **Inserting Model Predictions in Snowflake**
11. **Scoring Function Deployment and Scheduling**
12. **Sending Status Mail**

---

## Prerequisites

- Snowflake Account
- AWS Account
- Understanding of basic SQL 

---

## Tech Stack

- **Tools:** `AWS Sagemaker`, `Snowflake`
- **Language:** `Python`
- **Libraries:** `snowflake-connector-python`, `snowflake-sqlalchemy`, `xgboost`, `pandas`, `numpy`, `scikit-learn`

---

## Code Overview

The code files are available in the `code.zip` file, organized into the following folders:

1. **Data:** Contains `health_data.csv` and `simulation_data.csv` files. Note: Assumes data is present in the Snowflake table.
2. **Python files:** Contains all files from the Jupyter environment created in AWS Sagemaker.
3. **SQLQueries:** Contains all SQL queries used in the Snowflake worksheet.

---
