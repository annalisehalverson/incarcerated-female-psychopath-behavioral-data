# DEFINING FUNCTIONS #


# below is a fun lil conditional function with a while loop.
# in this scenario, two locals in Hawaii are deciding how they want to get to school. they prefer to travel by ocean.
# if there are no waves, they will paddle.
# if there are waves under 10 feet, they will surf.
# if there are waves greater or equal to 10 feet, it will be too dangerous so they will take the bus instead.
hello_world <- function(waves) { # are there waves? T/F 
  if (waves == TRUE) { # if there are waves
    route <- "ho brah, we go surf" # surf to school
user_input <- as.numeric(readline("How big are the waves? Enter a number in feet: ")) # question prompted to user to determine if waves are safe
  while (isTRUE(user_input >= 10)) # print bus if waves are greater or equal to 10 ft
  return("shred is too gnarly, we take bus instead")
  } else { # if there are no waves
    route <- "shoots, we paddle den" # paddle to school
}
  paste0(route)
}

hello_world()
