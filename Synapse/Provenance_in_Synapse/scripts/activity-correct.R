## FROM THE PREVIOUS EXAMPLE, WE HAVE THE FOLLOWING SYNAPSE OBJECTS IN MEMORY:
##   myData (stored into myDataFile in Synapse)
##   summarizedData (stored into summarizedFile in Synapse)

## CODE WHICH WAS USED TO GENERATE THE SUMMARY FILE
codeFile <- synGet('syn3158498')

## Create the activity that describes how the summarized file was created.
## This is what is meant by 'provenance'.
## We used the myDataFile as input and executed the codeFile.
## Note that some of the items in the 'used' list have a parameter 'wasExecuted'
## set to TRUE and some are set to FALSE. In this case, the 'codeFile' was
## executed, and myData was used to create the summarizedData

myActivity <- Activity(name="Mean summary of width and height",
                       used=list(
                         list(entity=codeFile, wasExecuted=T),
                         list(entity=myDataFile, wasExecuted=F)))

## Now store this in synapse and add the activity to summarizedFile
myActivity <- synStore(myActivity)
generatedBy(summarizedFile) <- myActivity

## Finally, storing summarizedFile again updates it with the provenance we just added
summarizedFile <- synStore(summarizedFile)