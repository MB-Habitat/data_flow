#!/bin/bash


# Define your paths
localFolder="C:/Users/Mustapha Bouhsen/OneDrive - Habitat/DataPool/geospatial/"
blobContainer="https://habitatblob.blob.core.windows.net/database/raw/geospatial/?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-08-31T03:09:17Z&st=2024-08-15T19:09:17Z&spr=https&sig=IIL1q3Se%2BZfKA1l96S%2B8%2FEmL7SncX7UmFI5anR2Axcg%3D"
blobFilesList="https://habitatblob.blob.core.windows.net/database/files_list_to_process/geospatial/?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-08-31T03:09:17Z&st=2024-08-15T19:09:17Z&spr=https&sig=IIL1q3Se%2BZfKA1l96S%2B8%2FEmL7SncX7UmFI5anR2Axcg%3D"
filesList="daily_files_list.csv"

logFile="C:/Users/Mustapha Bouhsen/Desktop/data_flow/logfile.log"

# Run Python script
C:/ProgramData/miniconda3/python.exe ./main.py >> "$logFile" 2>&1


# Move all files to Blob Storage
./azcopy copy "$localFolder/*" "$blobContainer" --recursive  >> "$logFile" 2>&1

cd ~/Desktop/data_flow/geospatial/

csv_file="daily_files_list.csv"

raw_count=$(wc -l < "$csv_file")

if [ "$raw_count" -gt 1 ]; then
    ./azcopy copy "$filesList" "$blobFilesList" --recursive >> "$logFile" 2>&1
fi

# cd "$localFolder"
# rm -f * >> "$logFile" 2>&1