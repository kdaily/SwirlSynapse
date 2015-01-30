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

AUTO_DETECT_NEWVAR <- FALSE

script_results_identical <- function(result_name) {
  # Get e
  e <- get('e', parent.frame())
  # Get user's result from global
  if(exists(result_name, globalenv())) {
    user_res <- get(result_name, globalenv())
  } else {
    return(FALSE)
  }
  # Source correct result in new env and get result
  tempenv <- new.env()
  # Capture output to avoid double printing
  temp <- capture.output(
    local(
      try(
        source(e$correct_script_temp_path, local = TRUE),
        silent = TRUE
      ),
      envir = tempenv
    )
  )
  correct_res <- get(result_name, tempenv)
  # Compare results
  identical(user_res, correct_res)
}

# Multiple expression version of expr_creates_var
multi_expr_creates_var <- function(correctName=NULL){
  e <- get("e", parent.frame())
  # TODO: Eventually make auto-detection of new variables an option.
  # Currently it can be set in customTests.R
  delta <- if(!customTests$AUTO_DETECT_NEWVAR){
    safeEval(e$expr, e)
  } else {
    e$delta
  }
  if(is.null(correctName)){
    passed <- length(delta) > 0
  } else {
    passed <- correctName %in% names(delta)
  }
  passed <- isTRUE(passed)
  if(passed){
    e$newVar <- e$val
    e$newVarName <- names(delta)[1]
    e$delta <- mergeLists(delta, e$delta)
  }
  return(passed)
}

# Check that the output/value produced by a script is correct
script_vals_identical <- function() {
  # Get e
  e <- get('e', parent.frame())
  # Get value produced from user's script
  user_val <- capture.output(
    local(
      try(
        # Must use eval-parse combo, not source, if we don't force user
        # to print result
        eval(e$expr),
        silent = TRUE
      )
    )
  )
  # Get value produced from correct script
  correct_val <- capture.output(
    local(
      try(
        # Must use eval-parse combo, not source, if we don't force user
        # to print result
        eval(parse(file = e$correct_script_temp_path)),
        silent = TRUE
      )
    )
  )
  # Compare values
  identical(user_val, correct_val)
}
