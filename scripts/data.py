import pandas as pd
with open("../data/Life_expectancy_at_birth_female.csv", "r", encoding="utf-8") as f:
    for i in range(10):
        print(f.readline())