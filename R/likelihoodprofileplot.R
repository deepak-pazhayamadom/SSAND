# Copyright 2024 Fisheries Queensland

# This file is part of SSAND.
# SSAND is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# SSAND is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with SSAND. If not, see <https://www.gnu.org/licenses/>.

#' Likelihood profile plot
#' View ?likelihoodprofileplot to view full examples for running likelihood profiles for Stock Synthesis or DDUST.
#'
#' @param data Output from likelihoodprofileplot_prep(). A dataframe with columns x_vector, component and likelihood
#' @param xlab Label for x-axis (character). # Default is `expression(log(italic(R)[0]))`.
#' @param ylab Label for y-axis (character). Default is "Change in -log-likelihood".
#' @param xlim A vector of lower and upper x-axis limits (e.g. c(1950, 2020)) (numeric).
#' @param ylim A vector of lower and upper y-axis limits (e.g. c(0,1)) (numeric).
#' @param colours A vector of colours used (character).
#' @param shapes A vector of shapes used (character).
#' @param component_names A vector of customised component names for legend (character).
#' @param legend_position Position of the legend ("none", "left", "right", "bottom", "top", or two-element numeric vector for x and y position). Default is "top".
#'
#' @return Likelihood profile plot
#' @export
#'
#' @examples
#' \dontrun{
#' DDUST:
#' # Run DDUST model:
#' data <- dd_mle[[1]]$data
#' parameters <- dd_mle[[1]]$parameters
#' map <- dd_mle[[1]]$map
#' dd_out <- DDUST::run_DDUST(data, parameters, map, MCMC = FALSE)
#'
#' # Set up parameter profile:
#' Rinit <- seq(11,12,by = 0.05)
#'
#' # Simulate model over every value of parameter
#' profile <- c()
#' for (i in 1:length(Rinit)){
#'   simulation_parameters <- parameters
#'   for (item in names(map)){
#'     simulation_parameters[item] <- NULL
#'   }
#'   simulation_parameters$Rinit <- Rinit[i]
#'   sim <- dd_out$dd_mle$model$simulate(unlist(simulation_parameters))
#'
#'   profile <- rbind(profile,
#'                    data.frame(x_vector = Rinit[i],
#'                               likelihood = sim$LL, component = 'Total'),
#'                    data.frame(x_vector = Rinit[i],
#'                               likelihood = sim$biomassLL, component = 'Biomass survey'),
#'                    data.frame(x_vector = Rinit[i],
#'                               likelihood = sim$cpueLL, component = 'Index'),
#'                    data.frame(x_vector = Rinit[i],
#'                               likelihood = sim$RecDevLL, component = 'Recruitment'),
#'                    data.frame(x_vector = Rinit[i],
#'                               likelihood = sim$penLL1, component = 'Catch penalty'),
#'                    data.frame(x_vector = Rinit[i],
#'                               likelihood = sim$penLL2, component = 'Recruits penalty'))
#' }
#' likelihoodprofileplot(profile)
#'
#' Stock Synthesis:
#' r4ss::profile(dir = '.', # directory of 4 SS files
#'               oldctlfile = "control.ctl",
#'               newctlfile = "control.ctl",
#'               string = "steep",
#'               profilevec = c(0.4,0.5,0.6),
#'               exe = "C:/stocksynthesis/ss_3.30.22.exe")
#'
#' profile_input <- r4ss::SSsummarize(
#'   r4ss::SSgetoutput(dirvec = ".",
#'                     keyvec = 1:3, # 1:length(profilevec)
#'                     getcovar = FALSE,
#'                     getcomp = FALSE))
#'
#' data <- likelihoodprofileplot_prep_SS(profile_input, parameter="SR_BH_steep")
#' likelihoodprofileplot(data)
#' }
likelihoodprofileplot <- function(data,
                                  xlab = NULL,
                                  ylab = "Change in -log-likelihood",
                                  xlim = NULL,
                                  ylim = NULL,
                                  colours = c(SSAND::fq_palette("alisecolours"),SSAND::fq_palette("cols")),
                                  shapes = c(16,17,18,15,1,2,5,0,19,20,3,4,7,8,9,10,11,12,13,14),
                                  component_names = NULL,
                                  legend_position = "top"
                                  ) {

  if (!"x_vector" %in% names(data)) {warning("Input data is missing x_vector column")}
  if (!"component" %in% names(data)) {warning("Input data is missing component column")}
  if (!"likelihood" %in% names(data)) {warning("Input data is missing likelihood column")}

  if (missing(xlab)) {
    xlab = expression(log(italic(R)[0]))
  }

  if (missing(xlim)) {
    xlim <- c(
      dplyr::first(sort(unique(data$x_vector))),
      dplyr::last(sort(unique(data$x_vector)))
    )
  }

  if (missing(ylim)) {
    ylim <- c(0,max(data$likelihood))
  }

  p <- ggplot2::ggplot(data) +
    ggplot2::geom_line(ggplot2::aes(x=x_vector,
                                    y=likelihood,
                                    colour=component)) +
    ggplot2::geom_point(ggplot2::aes(x=x_vector,
                                     y=likelihood,
                                     colour=component,
                                     shape=component)) +
    ggplot2::theme_bw() +
    ggplot2::scale_x_continuous(breaks=sort(unique(data$x_vector)),
                                name=xlab,
                                limits=xlim) +
    ggplot2::scale_y_continuous(name=ylab,
                                limits=ylim) +
    ggplot2::scale_colour_manual(name="",
                                 values=colours) +
    ggplot2::scale_shape_manual(name="",
                                values=shapes) +
    ggplot2::theme(legend.position = legend_position)

  return(p)
}
