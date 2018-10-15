# ---
# title:  'namedarray : an options/parameters storage system'
# author: BFC
# date: "02/10/2018"
# ---


#
# Libraries (not loaded, but to be added to the imports)
# =========
# library(rlang)
# library(lobstr)
# options(lobstr.fancy.tree = TRUE)
# library(purrr)



# name of the array: nametable (rem: not directly accessible to the user)

# Helper function (not exported): Prepare a list of strings for use as
# formal arguments of a function

argnames_to_formals <- function(argnames) {
        namesdum <- 1:length(argnames)
        names(namesdum) <- argnames
        purrr::map(unlist(namesdum), ~ rlang::missing_arg())
}

# test this function
# argnames_to_formals(c("a", "b"))


# system setup function



#' Set up an options/parameters system
#'
#' This function initializes an aray of options/parameters (of any
#' type), accessible through a combination of selector names.
#' It returns a named list of set/get function, which respectively
#' set/get the values stored in an internal array of values
#'
#' @param argnames a character vector of selector names
#' @param argranges a list of character vectors of valid selector valuess. Each selector is the name of a dimension of the (internal) array
#' @return a named list of 2 functions : set and get
#' @author Bruno Fischer Colonimos
#' @details The `setup_nametable` function returns a list of
#' 2 functions:
#' \itemize{
#' \item \code{get} returns the values of the selected  array fields, and `
#' \item \code{set} assigns the given \code{value} to the selected fields of the aray.
#' }
#' Both functions return the selected array values
#' @export
#' @examples
#' # setup
#' tst2 <- setup_nametable(argranges = list(bla = c("a", "b"),
#'                                          ble = c("u", "v", "w"),
#'                                          bli = c("x", "y", "z", "t")))
#'
#' # setting and retrieving value
#' tst2$set( value = LETTERS[1:24])
#' tst2$get( bla = "a", ble = "u", bli = "z")
#' tst2$get( bla = "a", ble = "u")
#' tst2$set( bla = "a", ble = "u", value = "ZZ")
#' tst2$get()



setup_nametable <- function(argranges, initvals) { # here the argument is a named list of vectors of legal values
        # preparation: parameters
        argnames <- names(argranges)
        arglen <- length(argranges)
        dimensions <- sapply(argranges, length)
        size <- Reduce(`*`, dimensions) # (if initialization)
        # preparation: expressions
        namesyms <- rlang::syms(argnames)
        args <- argnames_to_formals(argnames)
        args_set <- argnames_to_formals(c(argnames, "value"))

        # final expressions
        # array name = arr
        makearray_expr <- rlang::expr(arr <- array(
                # data = 1:24, # initial values, optional
                dim =c(!!!dimensions),
                dimnames = !!argranges ) )
        getfun_expr <- rlang::expr(getfun <- !!rlang::new_function(args, rlang::expr({arr[!!!namesyms]})) )
        setfun_expr <- rlang::expr(
                setfun <- !!rlang::new_function(args_set,
                                                rlang::expr({arr[!!!namesyms] <- value
                                                arr <<- arr
                                                return(arr[!!!namesyms])
                                                })) )
        # evaluation and return
        eval(makearray_expr)
        eval(setfun_expr)
        eval(getfun_expr)
        if (!missing(initvals)) {setfun(value = initvals)}
        return(list(set = setfun, get = getfun))
}

