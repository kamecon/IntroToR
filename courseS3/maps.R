pacman::p_load(maps)

usa <- map_data("state")

USArrests$region <- tolower(rownames(USArrests))

usa2 <- right_join(x = usa, y = USArrests, by = "region")

ggplot(USArrests, aes(map_id = region)) + # the variable name to link our map and dataframe
  geom_map(aes(fill = Assault), # variable we want to represent with an aesthetic
           map = usa) + # data frame that contains coordinates
  expand_limits(x = usa$long, y = usa$lat) +
  coord_map() 

ggplot() +
  geom_polygon(data = usa,
               mapping = aes(x = long, y = lat, group=group),
               color="black",
               fill="lightblue")

ggplot() +
  geom_polygon(data = usa2,
               mapping = aes(x = long, y = lat, group=group, fill = Assault),
               color="black")





