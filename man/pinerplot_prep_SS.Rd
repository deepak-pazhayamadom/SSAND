% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pinerplot_prep_SS.R
\name{pinerplot_prep_SS}
\alias{pinerplot_prep_SS}
\title{Prepare Stock Synthesis data for pinerplot()}
\usage{
pinerplot_prep_SS(
  profile_input,
  component = "Length_like",
  likelihood_type = "raw_times_lambda",
  parameter = "SR_LN(R0)"
)
}
\arguments{
\item{profile_input}{The likelihood profile object after running: r4ss::SS_profile(), r4ss::SSgetoutput(), then r4ss::SSsummarize(). See ?pinerplot for example.}

\item{component}{The component for which you want to display the likelihood profile. Use SSAND::pinerplot_component_options(profile_input) to see options.}

\item{likelihood_type}{Either "raw_times_lambda" or "raw".}

\item{parameter}{Parameter used in likelihood profile. Use unique(profile_input$pars$Label) for valid options.}
}
\value{
A dataframe with columns x_vector, fleet and likelihood
}
\description{
Prepare Stock Synthesis data for pinerplot()
}
\examples{
\dontrun{
r4ss::profile(dir = '.', # directory of 4 SS files
              oldctlfile = "control.ctl",
              newctlfile = "control.ctl",
              string = "steep",
              profilevec = c(0.4,0.5,0.6),
              exe = "C:/stocksynthesis/ss_3.30.22.exe")

profile_input <- r4ss::SSsummarize(
  r4ss::SSgetoutput(dirvec = ".",
                    keyvec = 1:3, # 1:length(profilevec)
                    getcovar = FALSE,
                    getcomp = FALSE))

pinerplot_component_options(profile_input)
data <- pinerplot_prep_SS(profile_input, component="Length_like")
pinerplot(data)
}
}
