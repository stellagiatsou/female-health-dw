import pandas as pd
from sqlalchemy import create_engine
                                        #   //username:password@host:port/database_name
engine = create_engine("postgresql+psycopg2://dwuser:dwpass@localhost:5432/female_health_dw")
print("Connection OK")

df_gdp = pd.read_csv("../transformed_data/gdp_growth_clean.csv")
df_gdp.to_sql("stg_gdp_growth", engine, if_exists="replace", index=False)

df_gii = pd.read_csv("../transformed_data/gender_inequality_index_clean.csv")
df_gii.to_sql("stg_gender_inequality", engine, if_exists="replace", index=False)

df_labor = pd.read_csv("../transformed_data/labor_force_participation_rate_clean.csv")
df_labor.to_sql("stg_labor", engine, if_exists="replace", index=False)

df_life = pd.read_csv("../transformed_data/life_expectancy_clean.csv")
df_life.to_sql("stg_life_expectancy", engine, if_exists="replace", index=False)

df_edu_p = pd.read_csv("../transformed_data/school_completion_primary_female_clean.csv")
df_edu_p.to_sql("stg_education_primary", engine, if_exists="replace", index=False)

df_edu_s = pd.read_csv("../transformed_data/school_enrollment_secondary_female_clean.csv")
df_edu_s.to_sql("stg_education_secondary", engine, if_exists="replace", index=False)

df_wbl = pd.read_csv("../transformed_data/women_business_and_the_law_index_clean.csv")
df_wbl.to_sql("stg_wbl_index", engine, if_exists="replace", index=False)


print("ALL DATA LOADED")