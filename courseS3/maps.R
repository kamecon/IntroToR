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


pacman::p_load(eurostat, sf, ggplot2, giscoR, dplyr)

#Proxy
Sys.setenv("no_proxy"=".jrc.org,.jrc.cec.eu.int,.jrc.ec.europa.eu,.jrc.it,.jrc.es,localhost,127.0.0.1")

eur21 <- get_eurostat_geospatial(resolution = 10,
                                 nuts_level = 2,
                                 year = 2021)
eu_countries
eur21_2 <- inner_join(x = eu_countries,
                      y = eur21,
                      by = c("code" = "CNTR_CODE")) %>% 
  st_as_sf()

ggplot(data = eur21_2 %>% dplyr::filter(name == "Italy")) +
  geom_sf()

unemp <- get_eurostat(id = "tgs00010", select_time = "Y")

unemp %>% filter(TIME_PERIOD == "2021-01-01" & sex == "T" & isced11 == "TOTAL")

eur21_3 <- inner_join(x = eur21_2,
                      y = unemp %>% filter(TIME_PERIOD == "2021-01-01" & sex == "T" & isced11 == "TOTAL"),
                      by = c("NUTS_ID" = "geo")) %>% 
  st_as_sf()


eur21_2 %>% 
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf()

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank())

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank())

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_continuous(type = "viridis")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_continuous(type = "viridis", name = "Unemployment (%)")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient(low = "yellow", high = "red", name = "Unemployment (%)")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow", high = "red",mid = "orange", name = "Unemployment (%)")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 12,
                       name = "Unemployment (%)")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  select(values) %>% 
  summarise(max(values))

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)") +
  geom_sf_text(aes(label = values))


eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)") +
  geom_sf_text(aes(label = NAME_LATN))

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)") +
  geom_sf_text(aes(label = NAME_LATN), size =2)


# eur21_2 %>%
#   dplyr::filter(name == "Italy") %>% 
#   ggplot(aes(fill = values)) +
#   geom_sf() +
#   theme(axis.text = element_blank()) +
#   theme(axis.ticks = element_blank()) +
#   scale_fill_gradient2(low = "yellow",
#                        high = "red",
#                        mid = "orange",
#                        midpoint = 10,
#                        name = "Unemployment (%)") +
#   geom_sf_text(aes(label = NAME_LATN), size =2)

pacman::p_load(ggrepel)

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values, label= NAME_LATN)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)") +
  geom_text_repel(aes(geometry = geometry),
                  stat = "sf_coordinates")

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values, label= NAME_LATN)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)") +
  geom_text_repel(aes(geometry = geometry),
                  stat = "sf_coordinates",
                  max.overlaps = Inf,
                  box.padding = 0.5)

eur21_2 %>%
  dplyr::filter(CNTR_CODE == "IT") %>% 
  ggplot(aes(fill = values, label= NAME_LATN)) +
  geom_sf() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_fill_gradient2(low = "yellow",
                       high = "red",
                       mid = "orange",
                       midpoint = 10,
                       name = "Unemployment (%)") +
  geom_text_repel(aes(geometry = geometry),
                  stat = "sf_coordinates",
                  max.overlaps = Inf,
                  box.padding = 0.5, size =4)


eur21_2 %>% 
  select(NUTS_ID, values)

Sys.setenv("no_proxy"=".ec.europa.eu,.jrc.org,.jrc.cec.eu.int,.jrc.ec.europa.eu,.jrc.it,.jrc.es,localhost,127.0.0.1")


