#!/usr/bin/env python3
# %% [markdown]
# ### Import libraries

# %%
import wget
import json
import os
import pandas as pd


# %% [markdown]
# ### Download Google Sheet as CSV
# 

# %%
url = "https://docs.google.com/spreadsheets/d/1JfsnrF0RbLuTF7bfIBx2lVT4ReJtJtEfTNrc_FesDdY/gviz/tq?tqx=out:csv"
filename = wget.download(url)


# %% [markdown]
# ### Read CSV into Pandas DataFrame
# 

# %%

df = pd.read_csv('data.csv')


# %% [markdown]
# ### Convert DataFrame to Dictionary 

# %%
def check_valid_value(value):
    if str(value) == 'nan':
        return None
    return value


json_data = []
for index, row in df.iterrows():
    data_dict = {
        'name': check_valid_value(row['name']),

        'article': check_valid_value(row['article']),

    }
    if check_valid_value(row['date']):
        data_dict.update(
            {
                'date': check_valid_value(row['date'])
            }
        )
    else:
        data_dict.update(
            {
                'start': check_valid_value(row['start']),
                'end': check_valid_value(row['end']),
            }
        )
    if check_valid_value(row['asset']):
        data_dict.update(
            {
                'asset': {
                    'source': check_valid_value(row['asset']),
                    'height': check_valid_value(row['height']),
                    'width': check_valid_value(row['width'])
                }
            }
        )
    json_data.append(data_dict)


# %% [markdown]
# ### Create JSON file from Dictionary

# %%
with open('data.json', 'w') as outfile:
    json.dump(json_data, outfile, indent=3, sort_keys=True, ensure_ascii=False)

print('New JSON File Create Done!')


# %% [markdown]
# ### Delete the csv file

# %%
os.remove('data.csv')



