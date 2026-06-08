import pandas as pd

file_path = "../raw_data/School_enrollment_secondary_female.csv"

# skip metadata lines (4 πρώτες γραμμές)
df = pd.read_csv(file_path, skiprows=4)

# rename columns 
df = df.rename(columns={
    "Country Name": "country",
    "Country Code": "country_code",
   
})

# UNPIVOT (wide → long transformation)
df_long = df.melt(
    id_vars=["country", "country_code"],
    var_name="year",
    value_name="school_enrollment_secondary_female_rate"
)

# clean year
df_long["year"] = pd.to_numeric(df_long["year"], errors="coerce")

# keep only useful years
df_long = df_long[
    (df_long["year"] >= 1990) &
    (df_long["year"] <= 2023)
]

# drop nulls
df_long = df_long.dropna(subset=["school_enrollment_secondary_female_rate"])

print(df_long.head())
print(df_long.columns)
print(len(df_long))

df_long.to_csv("../transformed_data/school_enrollment_secondary_female_clean.csv", index=False)