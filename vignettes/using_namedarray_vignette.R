## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  # collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(namedarray)
fstr <- setup_nametable(argnames = c("language", 
                                     "effect", 
                                     "position"),
                        argranges = list(c("html", "latex"),
                                         c("emphasis", 
                                           "strong", 
                                           "center"),
                                         c("prefix", "suffix")))

## ------------------------------------------------------------------------
# setting the empty string as the default string
fstr$set( , value = "")  # no selector argument specified , ie all values are part or the selection

# setting the prefix and suffix for the centering effect
fstr$set(language = "html", effect = "center", position = "prefix", 
         value = "<center> ")
fstr$set(language = "html", effect = "center", position = "suffix", 
         value = "</center> ")
fstr$set(language = "latex", effect = "center", position = "prefix", 
         value = "\\begin{centering}")
fstr$set(language = "latex", effect = "center", position = "suffix", 
         value = "\\end{centering}")

# Similar code should be set up for the other effects


## ------------------------------------------------------------------------
# get one value
fstr$get(language = "latex", effect = "center", position = "suffix")

# get an array of values
fstr$get(language = "latex") 

