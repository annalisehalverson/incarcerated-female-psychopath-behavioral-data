# tests in class
# functions
shop <- function(eggs) { # do they have eggs? T/F
    if (eggs == TRUE) {# if there are eggs
      n.milk <- 6 # Get 6 cartons of milk
    } else { # If there are not eggs
        n.milk <- 1 # Get 1 carton of milk
    }
  n.milk <- n.milk
  paste0("Here's the milk. I bought ", n.milk, ".")
}
shop(TRUE) # Run the function by setting the one and only argument (eggs) to either TRUE or FALSE

