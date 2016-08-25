# Choose a cran mirror to use (48 = Paris / France)
chooseCRANmirror(ind = 48)

# Install dependencies if necessary
if (!require(httr)) {
    # System dependency for the curl package
    system("sudo apt-get install -y libcurl4-openssl-dev")
    install.packages("httr")
    library(httr)
}

### Parameters to set
# WebHDFS url
hdfsUri <- "http://namenodedns:port/webhdfs/v1"
# Url where you want to append the file
fileUri <- "/user/username/myfile.csv"
# Optional parameter, with the format &name1=value1&name2=value2
optionnalParameters <- "&overwrite=true"

# CREATE => creation of a file
writeParameter <- "?op=CREATE"

# Concatenate all the parameters into one uri
uri <- paste0(hdfsUri, fileUri, writeParameter, optionnalParameters)

# Ask the namenode on which datanode to write the file
response <- PUT(uri)

# Get the url of the datanode returned by hdfs
uriWrite <- response$url

# The data you want to upload
# If your data is a file on your disk, leave it that way
data <- mtcars

# Write a temporary file on the disk
if(!file.exists("tmp.csv")) {
    write.csv(data, row.names = F, file = "tmp.csv")

    # Upload the file with a PUT request
    responseWrite <- PUT(uriWrite, body = upload_file("tmp.csv"))

    # removes the temporary file
    file.remove('tmp.csv')
} else {
    stop("A file named 'tmp.csv' already exists in the current directory")
}
