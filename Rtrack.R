setwd("~/R")
install.packages("Rtrack")
library(Rtrack)
require(Rtrack)

getAnywhere(calculate_oft_metrics) #to get the script code details

# Define the arena of OFT
arena = Rtrack::read_arena("Arena_OFT.txt")




############## 	Read path coordinates from raw data formats. (For each individual) #############

#identify_track_format
track.format = Rtrack::identify_track_format("animal_data/30144.csv") #raw.csv

path <- Rtrack::read_path("animal_data/30144.csv", arena, id = "test",
                          track.format = "raw.csv")


path <- Rtrack::read_path("animal_data/30144.csv", arena, id = "test",
                          track.format = "raw.csv", interpolate = TRUE)


#Extracting path metrics


metrics = Rtrack::calculate_metrics(path, arena)
#plot path
Rtrack::plot_path(metrics)

##plot density
Rtrack::plot_density(metrics)
Rtrack::plot_density(metrics, col = colorRampPalette(c(rgb(1, 1, 0.2), "orange",
                                                       "#703E3E"))(8))

 


########### Read experiment data for multiple individuals in one experiment###########

experiment = Rtrack::read_experiment("Experiment.xlsx", data.dir = "~/R", interpolate = TRUE )



experiment = Rtrack::read_experiment("Experiment.xlsx", data.dir = "~/R",
                                     threads = 0, interpolate = TRUE )

##Analysis of selected metrics
Rtrack::plot_variable("centre.zone.crossings", experiment = experiment, factor = "Maze")
title(main = "latency to the centre zone")


experiment_result <- export_results(experiment)
write.csv2(experiment_result, "experiment_results_interpolate = TRUE.csv", row.names = FALSE)


#Path plots of all individuals in the Experiment list

pdf(file = "Path plots.pdf")
for (i in 1:length(experiment$metrics)) {
  Rtrack::plot_path(experiment$metrics[[i]], title = experiment$metrics[[i]]$id)
}
dev.off()


