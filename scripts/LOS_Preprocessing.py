import pandas as pd
import numpy as np

## Complete Preprocessing Steps
def preprocess_data(df):
    """
    Preprocess the input DataFrame by performing the following steps:
    1. Drop specified columns: 'HOSPITAL_CODE', 'PATIENTID', 'ADMISSION_DATE', 'DISCHARGE_DATE'.
    2. Set the 'CASE_ID' column as the index.
    3. Fix data types for numeric and categorical columns.
    4. Perform one-hot encoding for categorical columns.

    Parameters:
    - df (DataFrame): Input DataFrame to be preprocessed.

    Returns:
    - df_final (DataFrame): Preprocessed DataFrame after the specified steps.
    """
    # Step 1: Columns to drop
    cols_to_drop = ['HOSPITAL_CODE', 'PATIENTID', 'ADMISSION_DATE', 'DISCHARGE_DATE']
    df = df.drop(cols_to_drop, axis=1)
    
    # Step 2: Setting the index
    df.set_index('CASE_ID', inplace=True)

    # Step 3: Fixing the data types issue
    num_columns = ['AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL', 'VISITORS_WITH_PATIENT', 'ADMISSION_DEPOSIT', 'LOS']
    cat_columns = [col for col in df.columns.tolist() if col not in num_columns]
    
    for col in cat_columns:
        df[col] = df[col].astype(object)    
    
    for col in num_columns:
        df[col] = df[col].astype(int)
    
    # Step 4: One-Hot Encoding
    df_final = pd.get_dummies(df)    
    
    return df_final
