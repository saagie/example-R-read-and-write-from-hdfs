### Parameters to set
# WebHDFS url
hdfsUri <- "http://namenodedns:port/webhdfs/v1"
# Uri of the file you want to read
fileUri <- "/user/username/myfile.csv"
# Optional parameter, with the format &name1=value1&name2=value2
optionnalParameters <- ""

# OPEN => read a file
readParameter <- "?op=OPEN"

# Concatenate all the parameters into one uri
uri <- paste0(hdfsUri, fileUri, readParameter, optionnalParameters)

# Read your file with the function you want as long as it supports reading from a connection
data <- read.csv(uri)
