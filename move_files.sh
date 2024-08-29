#!/bin/bash

# Define your paths
localFolder="files/*"
blobContainer="https://habitatblob.blob.core.windows.net/database/raw_test/?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-08-31T03:09:17Z&st=2024-08-15T19:09:17Z&spr=https&sig=IIL1q3Se%2BZfKA1l96S%2B8%2FEmL7SncX7UmFI5anR2Axcg%3D"
blobFilesList="https://habitatblob.blob.core.windows.net/database/files_list_to_process/?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-08-31T03:09:17Z&st=2024-08-15T19:09:17Z&spr=https&sig=IIL1q3Se%2BZfKA1l96S%2B8%2FEmL7SncX7UmFI5anR2Axcg%3D"
filesList="files_list.csv"


python ./source.py


# # Move all files to Blob Storage
./azcopy copy "$localFolder" "$blobContainer" --recursive 

# # Verify files have been moved
# $blobFiles = azcopy list "blobContainer"
# $localFiles = Get-ChildItem -Path localFolder


rm -f $localFolder

csv_file="files_list.csv"

raw_count=$(wc -l < "$csv_file")


if [ "$raw_count" -gt 1 ]; then
    ./azcopy copy "$filesList" "$blobFilesList" --recursive
fi


# Check if the number of files in the blob matches the local folder
# if ($blobFiles.Count -eq localFiles.Count) {
#     # Delete all files in the local folder
#     Remove-Item "$localFolder*" -Force

#     # Move another file to Blob Storage
#     azcopy copy "$anotherFile" "$blobContainer"
# } else {
#     Write-Host "Mismatch in file count. Files not deleted."
# }




# ./azcopy copy "files/*" "https://habitatblob.blob.core.windows.net/database/raw_test/?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-08-31T03:09:17Z&st=2024-08-15T19:09:17Z&spr=https&sig=IIL1q3Se%2BZfKA1l96S%2B8%2FEmL7SncX7UmFI5anR2Axcg%3D"  --recursive


