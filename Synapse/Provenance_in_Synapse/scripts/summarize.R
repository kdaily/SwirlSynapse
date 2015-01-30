# First, store myData to Synapse
# You might have already done this in a previous lesson!
myDataFile <- File(myDataPath, parentId=myFolder$properties$id)
myDataFile <- synStore(myDataFile)

# Summarize myData by calculating the mean width and height
summarizedData <- myData %>% 
  summarize(mean.width=mean(width),
            mean.height=mean(height))

# Write this to a file
write.csv(summarizedData, file="./summarizedData.csv")

# Save in Synapse in myFolder
summarizedFile <- File("./summarizedData.csv", parentId=myFolder$properties$id)
summarizedFile <- synStore(summarizedFile)
