# Path to data
myDataPath <- file.path(path.package('swirl'), 'Courses',
                        'Synapse', 'Provenance_in_Synapse',
                        'testdata.csv')
# Read in data
myData <- read.csv(myDataPath, strip.white=TRUE, na.strings="")
