
library(dplyr)

iris %>% select(starts_with("Petal") & !ends_with("Width"))
