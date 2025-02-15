% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/investigate_upset.R
\name{upsetplot}
\alias{upsetplot}
\title{Upset plot to display co-caught species}
\usage{
upsetplot(
  data,
  source = "BRS",
  species_of_interest = NULL,
  min_records = 1,
  show_fishing_method = FALSE,
  colours = c("#ff595e", "#ffca3a", "#8ac926", "#1982c4", "#6a4c93"),
  xlab_upset = "",
  ylab_upset = "",
  xlab_method = "",
  ylab_method = "",
  ncol = 2,
  scales = "free",
  extract_data = FALSE
)
}
\arguments{
\item{data}{A raw data file of catch, either from the Boat Ramp Survey or CFISH logbooks.}

\item{source}{Either "BRS" if using boat ramp survey data or "CFISH" if using logbook data.
If using "BRS" the code looks for columns called SpeciesName, SiteID, FishingMethodCode
If using "CFISH" the code looks for operator, date, species, method. Use \code{format_logbooks()} to format data.
If using a different source, ensure columns called species, SiteID, method are included.}

\item{species_of_interest}{Species name to display. Should appear in SpeciesName column if source=="BRS" or CAABSpeciesCommonName if source=="CFISH"}

\item{min_records}{Cut off value for tail end of plot. Do not plot species combinations who frequency is below this value.}

\item{show_fishing_method}{Set to TRUE to display sub-plot of to show fishing methods used, when more than one method was used.}

\item{colours}{A vector of colours used (character).}

\item{xlab_upset}{Label for x-axis of upset plot (character). Default is "".}

\item{ylab_upset}{Label for y-axis of upset plot (character). Default is "".}

\item{xlab_method}{Label for x-axis of fishing method plot (character). Default is "".}

\item{ylab_method}{Label for y-axis of fishing method plot (character). Default is "".}

\item{ncol}{Number of columns for facet wrap. Default is 2.}

\item{scales}{Scales for facet wrap. Default is 'free'}

\item{extract_data}{Set to TRUE to return data instead of plot. Default is FALSE.}
}
\value{
An upset plot to display co-caught species
}
\description{
Groups data by TripID or interview and plots frequency of co-caught species.
The plot shows the frequency of different combinations of species caught on the same interview (BRS) or ACN-day, ranked by the most common combination.
}
\examples{
upsetplot(format_logbooks(logbooks),
          source = 'CFISH',
          species_of_interest = 'Glitterfin snapper',
          min_records=1)
}
