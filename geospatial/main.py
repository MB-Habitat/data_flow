#!/miniconda3/envs/base

import os
import pandas as pd

root_folder_path = 'C:\\Users\\Mustapha Bouhsen\\OneDrive - Habitat\\DataPool\\geospatial\\theme_coutry_region_subject_year_version\\'

extensions = ["csv", "tif", "shp", "geojson"]


files_name_list = []
for file in os.listdir(root_folder_path):
    extension = file.split(".")[-1]
    if extension in extensions:
        files_name_list.append(file)

df_files = pd.DataFrame({"files_name" : files_name_list})

df_files.to_csv("files_list.csv", index=False)