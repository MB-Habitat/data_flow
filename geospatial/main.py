#!/miniconda3/envs/base

import os
import pandas as pd
import requests

root_folder_path = 'C:\\Users\\Mustapha Bouhsen\\OneDrive - Habitat\\DataPool\\geospatial\\'

extensions = ["csv", "tif", "shp", "geojson", "gpkg", "asc"]


files_name_list = []
for file in os.listdir(root_folder_path):
    extension = file.split(".")[-1]
    if extension in extensions:
        files_name_list.append(file)

df_files = pd.DataFrame({"files_name" : files_name_list})

df_files.to_csv("daily_files_list.csv", index=False)