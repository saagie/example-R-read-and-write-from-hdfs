Read and write data on HDFS from R
==================================

## Dependencies
- R package `httr` -> Used to make curl requests.
- Linux package `libcurl4-openssl-dev` -> Dependency of the `httr` package. Can be installed with the following command `sudo apt-get install -y libcurl4-openssl-dev`.

The commands to install theses dependencies are also presents in the file write.R.


## Usage

- Fill the Webhdfs url in the variable `hdfsUri`
- Fill the path of the file you want to read or write in the variable `fileUri`
- Add optionnal parameters
- Source the file you want to execute.  
