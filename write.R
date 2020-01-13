library(httr)

##### Parameters to set #####
# WebHDFS url
hdfsUri <- "https://nn1.pX.company.prod.saagie.io:50470/webhdfs/v1"
# Url where you want to append the file
fileUri <- "/tmp/myfile.csv"

# CREATE => creation of a file
writeParameter <- "?op=CREATE"

# Optional parameter, with the format &name1=value1&name2=value2
optionnalParameters <- "&overwrite=true"

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
write.csv(data, row.names = F, file = "tmp.csv")


##### Upload to hdfs without Kerberos #####

# Upload the file with a PUT request
responseWrite <- PUT(uriWrite, body = upload_file("tmp.csv"))


##### Upload to hdfs with Kerberos #####

library(getPass)
# Method 1 (interactive) : Use in Rstudio. Interactive pop up to enter password
system('kinit user',input=getPass('Enter your password: '))

# Method 2 (scripts) : Use outside of Rstudio.
# Password is written in command line or stored in a environment variable
# Uncomment next line to use
# system('echo password | kinit user')

# Authentification with Kerberos
auth <- authenticate(":","","gssnegotiate")

# Ask the namenode on which datanode to write the file
response <- PUT(uriDest, auth)
response

# Get the url of the datanode returned by hdfs
uriWrite <- response$url

# Upload the file with a PUT request
responseWrite <- PUT(uriWrite, auth, body = upload_file("tmp.csv"))
