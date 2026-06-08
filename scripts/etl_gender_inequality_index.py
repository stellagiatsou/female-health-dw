import pandas as pd

file_path = "../raw_data/Gender_inequality_index_from_the_human_development_report.csv"

df = pd.read_csv(file_path)

# rename columns 
df = df.rename(columns={
    "Entity": "country",
    "Code": "country_code",
    "Year": "year",
    "Gender Inequality Index": "gender_inequality_index"
})

df["year"] = pd.to_numeric(df["year"], errors="coerce")

df = df[(df["year"] >= 1990) & (df["year"] <= 2023)]

# drop nulls
df = df.dropna(subset=["gender_inequality_index"])

print(df.head())
print(len(df))

df.to_csv("../transformed_data/gender_inequality_index_clean.csv", index=False)