
#' # setup
tst2 <- setup_nametable(argranges = list(bla = c("a", "b"),
                                         ble = c("u", "v", "w"),
                                         bli = c("x", "y", "z", "t")))

#' # setting and retrieving value
tst2$set( value = LETTERS[1:24])
tst2$get( bla = "a", ble = "u", bli = "z")
tst2$get( bla = "a", ble = "u")
tst2$set( bla = "a", ble = "u", value = "ZZ")
tst2$get()


tst3 <- setup_nametable(argranges = list(bla = c("a", "b"),
                                         ble = c("u", "v", "w"),
                                         bli = c("x", "y", "z", "t")),
                        initvals = c("hhhh", "aaaa", "dede"))
tst3$get( bla = "a", ble = "u", bli = "z")
tst3$get( bla = "a", ble = "u")
tst3$set( bla = "a", ble = "u", value = "ZZ")
tst3$get()



##########################################################
# essais

beta <- function(...){
        for (arg in c("a", "b")) {
                if missing(arg) {
                        print(paste0(arg, " is missing"))
                } else {
                        print(paste0(arg, "=", arg))
                }
        } 
}

gamma <- function(...){
        args <-  list(...)
        # args
        for (arg in names(args)) print(paste0(arg, "=", args[arg]))
}

gamma(a = 1)
gamma(a = 1, b = 2, c = 3)


# --------------------------------------------------
delta <- function(a,b){ 
        args = c("a", "b")
        res = logical(2)
        for (i in 1:2) res[i] <- !missing(as.name(args[1]))
        res
}

delta(a = 1)
