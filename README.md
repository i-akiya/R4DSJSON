# R4DSJSON

## Description
The main purpose of R4DSJSON is to read CDISC Dataset-JSON files into R dataframe and to write it from R dataframe.  
Initial version of R4DSJSON has been developed and released during CDISC Dataset-JSON hackathon. It is very helpful and inspired that suggestions and comments from all attendees of the hackathon for developing this R package.


## License
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg) 
Please confirm details on "LICENSE" file.


## Installation
```
library(devtools)  
install_github("i-akiya/R4DSJSON")
```

## How to use it
```
library(R4DSJSON)  

# Read dm.json file as tibbl
dm_json_file <- system.file("testdata","dm.json", package="R4DSJSON")
dm_tibble <- R4DSJSON::read.dataset.json(file = dm_json_file)

# Write Dataset-Json file from R dataframe
write.dataset.json(file="dm.json", dataframe=dm_tibble, studyOID="cdisc.com/CDISCPILOT01",
                  metaDataVersionOID="MDV.MSGv2.0.SDTMIG.3.3.SDTM.1.7",
                  dataset.name="DM", dataset.label="Demographics")
```

## Examples
Few examples in examples directory.

1. dataset_json_in_R.Rmd: A data viewer in RMarkdown with DT htmlwidgets.
...to be continued.


## Data type conversion
Data type conversion between ODM and R is listed below.

| ODM | R |
|--------|--------|
| string | string |
| integer | integer |
| float | double |

## Contribution

Contribution is very welcome. When you contribute to this repository you are doing so under the above licenses.

1. Fork this repository.
2. Edit the code files, test code files, documents, and others.
3. Create pull request. Please see [this guide](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) how to make pull request from fork.
  
## References
* https://github.com/cdisc-org/DataExchange-DatasetJson
* https://wiki.cdisc.org/display/DSJSONHACK/Introduction




