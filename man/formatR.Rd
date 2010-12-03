\name{formatR}
\alias{formatR}
\title{GUI to format R code.}
\usage{formatR(guiToolkit="RGtk2")}
\description{GUI to format R code.
Create a GUI (via GTK+ by default) to format R code.}
\details{This function calls \code{\link{tidy.source}} to format R code.
Spaces and indent will be added to the code automatically.

We can either open an R source file or directly write R code in the text
widget. Click the ``convert'' button, and the code will become tidy. See
\code{\link{tidy.source}} for more details.}
\value{Invisible \code{NULL}.}
\note{Inline comments will be removed, as documented in
\code{\link{tidy.source}}.

For the time being, multi-byte characters cannot be handled correctly.

By default, the interface is based on GTK+ (R package \bold{RGtk2}), but
other options (\bold{tcltk}, \bold{rJava} and \bold{Qt}) are possible too. See the
examples below. Note the ``Font'' button is only for the GTK+ interface
and it can only set font styles for the selected texts.}
\author{Yihui Xie <\url{http://yihui.name}>}
\seealso{\code{\link{tidy.source}}}
\references{\url{http://yihui.name/en/2010/04/formatr-farewell-to-ugly-r-code/}}
\arguments{\item{guiToolkit}{the GUI toolkit to use}}
\examples{\dontrun{

## a GUI will show up on loading if one of the gWidgets
##   toolkit is present (e.g. via library(gWidgetsRGtk2))
library(formatR)

## manually call the GUI
formatR()

## tcl/tk interface: need gWidgetstcltk package
options(guiToolkit = "tcltk")
formatR()

## Java interface: need gWidgetsrJava package
options(guiToolkit = "rJava")
formatR()

}}
