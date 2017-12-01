# The MIT License
# 
# Copyright (c) 2017 Piero Dalle Pezze
# 
# Permission is hereby granted, free of charge, 
# to any person obtaining a copy of this software and 
# associated documentation files (the "Software"), to 
# deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, 
# merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom 
# the Software is furnished to do so, 
# subject to the following conditions:
# 
# The above copyright notice and this permission notice 
# shall be included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
# ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



# generate time course data for Copasi


# retrieve this script path 
args <- commandArgs(trailingOnly=FALSE)
SCRIPT_PATH <- dirname(sub("^--file=", "", args[grep("^--file=", args)]))
if(length(SCRIPT_PATH) > 0) {
  # we use this when Rscript is used from a different directory
  SCRIPT_PATH <- normalizePath(SCRIPT_PATH)
  source(file.path(SCRIPT_PATH, '../utilities/plots.R'))
} else {
  # we use this when Rscript is used from this directory
  source('../utilities/plots.R')
}



###########
# LOAD DATA 
###########

args <- commandArgs(trailingOnly=TRUE)
if(length(args) == 0) {
  location.data <- file.path('..','..', 'data')
  location.results <- file.path('..','..','..', 'Models')
  filenames <- c('atg13_int_mean_ctrl_sync', 'atg13_int_mean_wrtm_sync')
  filenames.out <- c('ds__atg13', 'ds__atg13_wrtm')
  observable <- 'ATG13_obs'
  treatment <- c(FALSE, TRUE)
  for(i in 1:length(filenames)) {
    generate_copasi_datasets(location.data, filenames[i], location.results, filenames.out[i], observable, treatment[i])
  }
} else {
  location.data <- dirname(normalizePath(args[1]))
  location.results <- normalizePath(args[2])
  filename <- sub("^([^.]*).*", "\\1", basename(args[1]))
  filename.out <- args[3]
  observable <- args[4]
  treatment <- args[5]
  if(treatment == 'TRUE') { treatment <- TRUE }
  else { treatment <- FALSE }
  generate_copasi_datasets(location.data, filename, location.results, filename.out, observable, treatment)
}
