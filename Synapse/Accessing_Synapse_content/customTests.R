# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

checkSynLogin <- function(...) {
  ## Check to see if a user has logged into Synapse. This just looks to see that
  ## the current users profile is accessible
  
  e <- get("e", parent.frame())
  userprof <- tryCatch(synGetUserProfile(), error=function(e) NULL)
  ifelse(is.null(userprof), FALSE, TRUE)
}