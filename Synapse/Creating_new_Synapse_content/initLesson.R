# Path to data
myDataPath <- file.path(path.package('swirl'), 'Courses',
                      'Synapse', 'Creating_new_Synapse_content',
                      'testdata.csv')
# Read in data
myData <- read.csv(myDataPath, strip.white=TRUE, na.strings="")
