% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_create.R
\name{api_create_phenotype}
\alias{api_create_phenotype}
\title{api_create_phenotype}
\usage{
api_create_phenotype(data, api_client)
}
\arguments{
\item{data}{Formatted phenotype data.}

\item{api_client}{The HttpClient returned by the \code{\link{connect_to_API}} function}
}
\value{
TRUE if successful, FALSE otherwise
}
\description{
Creates phenotype using formatted data from uploaded yaml file.
}
