import pandas as pd
from sqlalchemy import create_engine
import urllib.parse

# Read the CSV file
df = pd.read_csv(r"dataset.csv")

# Ensure order_id is an integer and remove rows where conversion is not possible
df['order_id'] = pd.to_numeric(df['order_id'], errors='coerce')
df = df.dropna(subset=['order_id'])
df['order_id'] = df['order_id'].astype(int)

# Remove rows where product_id is 0
df = df[df['product_id'] != 0]

# Cap amount at 1500 Rs (treat any item with amount greater than 1500 Rs as 1500 Rs)
df['amount'] = df['amount'].apply(lambda x: min(x, 1500))

# Remove rows where status is null or None
df = df[df['status'].notnull()]

# Remove duplicate rows
df = df.drop_duplicates()

# Database connection string
DATABASE_TYPE = 'postgresql'
DBAPI = 'psycopg2'
HOST = 'localhost'
USER = 'postgres'
PASSWORD = 'Jun@idP0st'
DATABASE = 'bwt'
PORT = '5432'

# URL-encode the password
encoded_password = urllib.parse.quote_plus(PASSWORD)

# Create the database engine
engine = create_engine(f'{DATABASE_TYPE}+{DBAPI}://{USER}:{encoded_password}@{HOST}:{PORT}/{DATABASE}')

# Save the cleaned data to the PostgreSQL table
df.to_sql('clean_dataset', engine, if_exists='replace', index=False)

print("Data cleaning and transformation completed. The cleaned data is saved in the PostgreSQL database.")
