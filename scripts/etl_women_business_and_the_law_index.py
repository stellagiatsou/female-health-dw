import pandas as pd

file_path = "../raw_data/Women_Business_and_the_Law_Index.csv"

# skip metadata lines (4 πρώτες γραμμές)
df = pd.read_csv(file_path)
df.columns = (
    df.columns
    .str.strip()
    .str.replace("\n", " ", regex=False)
    .str.replace("  ", " ", regex=False)
)


# rename columns 
df = df.rename(columns={
    "Economy": "country",
    "Economy Code": "country_code",
    "Report Year": "year",
    "Region": "region",
    "WBL Index": "legal_index",
    "Income Group": "income_group",
    "Can a woman choose where to live in the same way as a man?": "can_choose_residence",
    "Can a woman travel outside her home in the same way as a man?": "can_travel_domestic",
    "Can a woman apply for a passport in the same way as a man?": "can_apply_passport",
    "Can a woman travel outside the country in the same way as a man?": "can_travel_abroad",
    "Can a woman get a job in the same way as a man?": "get_job", #can work
    "Does the law prohibit discrimination in employment based on gender?": "no_gender_discrimination_employment",
    "Is there legislation on sexual harassment in employment?": "sexual_harassment_legislation",
    "Are there criminal penalties or civil remedies for sexual harassment in employment?": "sexual_harassment_penalties",
    "Does the law prohibit discrimination in access to credit based on gender?":"no_gender_discrimination_credit",
    "Can a woman sign a contract in the same way as a man?": "can_sign_contract",
    "Can a woman register a business in the same way as a man?": "can_register_business",
    "Can a woman open a bank account in the same way as a man?": "can_open_bank_account"
})

# UNPIVOT (wide → long transformation)
yes_no_columns = [
    "can_choose_residence",
    "can_travel_domestic",
    "can_apply_passport",
    "can_travel_abroad",
    "get_job",
    "no_gender_discrimination_employment",
    "sexual_harassment_legislation",
    "sexual_harassment_penalties",
    "no_gender_discrimination_credit",
    "can_sign_contract",
    "can_register_business",
    "can_open_bank_account"
]

for col in yes_no_columns:
    df[col] = (
        df[col]
        .astype(str)
        .str.strip()
        .str.lower()
        .map({
            "yes": 1,
            "no": 0
        })
    )

# clean year
df["year"] = pd.to_numeric(df["year"], errors="coerce")

# keep only useful years
df = df[
    (df["year"] >= 1990) &
    (df["year"] <= 2023)
]
print(df.columns.tolist())
print(df.head())
print(df.columns)
print(len(df))
for c in df.columns:
    print(repr(c))


cols_to_drop = [
    c for c in df.columns
    if c in [
        "ISO Code",
        "MOBILITY", "WORKPLACE", "PAY",
        "MARRIAGE", "PARENTHOOD",
        "ENTREPRENEURSHIP", "ASSETS", "PENSION",
        "Does the law mandate equal remuneration for work of equal value?",
        "Can a woman work at night in the same way as a man?",
        "Can a woman work in a job deemed dangerous in the same way as a man?",
        "Can a woman work in an industrial job in the same way as a man?",
        "Is the law free of legal provisions that require a married woman to obey her husband?",
        "Can a woman be head of household in the same way as a man?",
        "Is there legislation specifically addressing domestic violence?",	
        "Can a woman obtain a judgment of divorce in the same way as a man?",	
        "Does a woman have the same rights to remarry as a man?",	
        "Is paid leave of at least 14 weeks available to mothers?",
        "Length of paid maternity leave	Does the government administer 100 percent of maternity leave benefits?",	
        "Is there paid leave available to fathers?",	
        "Length of paid paternity leave	Is there paid parental leave?"	,
        "Shared days	Days for the mother	Days for the father	Is dismissal of pregnant workers prohibited?",
        "Do women and men have equal ownership rights to immovable property?",	
        "Do sons and daughters have equal rights to inherit assets from their parents?",	
        "Do male and female surviving spouses have equal rights to inherit assets?",
        "Does the law grant spouses equal administrative authority over assets during marriage?",
        "Does the law provide for the valuation of nonmonetary contributions?",
        "Is the age at which women and men can retire with full pension benefits the same?",
        "Is the age at which women and men can retire with partial pension benefits the same?",
        "Is the mandatory retirement age for women and men the same?",
        "Are periods of absence due to childcare accounted for in pension benefits?",
        "Length of paid maternity leave",
        "Does the government administer 100 percent of maternity leave benefits?",
        "Is there paid leave available to fathers?",
        "Length of paid paternity leave",
        "Is there paid parental leave?",
        "Shared days",
        "Days for the mother","Days for the father","Is dismissal of pregnant workers prohibited?"
    ]
]

df = df.drop(columns=cols_to_drop)


df.to_csv("../transformed_data/women_business_and_the_law_index_clean.csv", index=False)
