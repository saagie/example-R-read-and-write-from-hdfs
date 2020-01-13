##### Parameters to set #####
# WebHDFS url
hdfsUri <- "https://nn1.pX.company.prod.saagie.io:50470/webhdfs/v1"
# Uri of the file you want to read
fileUri <- "/tmp/sample.csv"

# OPEN => read a file
readParameter <- "?op=OPEN"

# Optional parameter, with the format &name1=value1&name2=value2
optionnalParameters <- ""

# Concatenate all the parameters into one uri
uri <- paste0(hdfsUri, fileUri, readParameter, optionnalParameters)

##### Connection without Kerberos #####
# Read your file with the function you want as long as it supports reading from a connection
data <- read.csv(uri)

##### Connection with Kerberos #####
library(getPass)
# Method 1 (interactive) : Use in Rstudio. Interactive pop up to enter password
system('kinit user',input=getPass('Enter your password: '))

# Method 2 (scripts) : Use outside of Rstudio.
# Password is written in command line or stored in a environment variable
# Uncomment next line to use
# system('echo password | kinit user')

library(httr)
set_config(config(ssl_verifypeer = 0L))

auth <- authenticate(":","","gssnegotiate")

# Fetch file from specified url
response <- GET(uriSrc, auth)

# Data is contained in the content of the response, as text
data <- read.csv(content(response, 'text'))
