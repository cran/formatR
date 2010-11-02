\name{tidy.source}
\alias{tidy.source}
\title{`Tidy up' R code and partially preserve comments.}
\usage{tidy.source(source="clipboard", keep.comment, keep.blank.line, begin.comment, end.comment, output=TRUE,
    width.cutoff=0.75 * getOption("width"), ...)}
\description{`Tidy up' R code and partially preserve comments.
Actually this function has nothing to do with code optimization; it just
returns parsed source code, but some comments can be preserved, which is
different with \code{\link[base]{parse}}. See `Details'.}
\details{This function helps the users to tidy up their source code in a sense that
necessary indents and spaces will be added, etc. See
\code{\link[base]{parse}}. But comments which are in single lines will be
preserved if \code{keep.comment = TRUE} (inline comments will be removed).

The method to preserve comments is to protect them as strings in disguised
assignments: combine \code{end.comment} to the end of a comment line and
'assign' the whole line to \code{begin.comment}, so the comment line will
not be removed when parsed. At last, we remove the identifiers
\code{begin.comment} and \code{end.comment}.}
\value{A list with components \item{text.tidy}{The parsed code as a
character vector.} \item{text.mask}{The code containing comments, which
are masked in assignments.} \item{begin.comment, end.comment}{
identifiers used to mark the comments }}
\note{For Mac users, this function will automatically set \code{source} to
be \code{pipe("pbpaste")} so that we still don't need to specify this
argument if we want to read the code form the clipboard.

There are hidden options which can control the behaviour of this function:
the argument \code{keep.comment} gets value from \code{options('keep.comment')}
by default; and \code{keep.blank.line} from \code{options('keep.blank.line')}.}
\author{Yihui Xie <\url{http://yihui.name}> with substantial contribution
from Yixuan Qiu <\url{http://yixuan.cos.name}>}
\seealso{\code{\link[base]{parse}}, \code{\link[base]{deparse}},
\code{\link[base]{cat}}}
\references{\url{http://yihui.name/en/2010/04/formatr-farewell-to-ugly-r-code/}}
\keyword{IO}
\arguments{\item{source}{a string: location of the source code (default to be the
clipboard; this means we can copy the code to clipboard and use
\code{tidy.souce()} without specifying the argument \code{source})}
\item{keep.comment}{logical value: whether to keep comments or not?
(\code{TRUE} by default)}
\item{keep.blank.line}{logical value: whether to keep blank lines or not?
(\code{FALSE} by default)}
\item{begin.comment,end.comment}{identifiers to mark the comments}
\item{output}{output to the console or a file using
\code{\link[base]{cat}}?}
\item{width.cutoff}{passed to \code{\link[base]{deparse}}: integer in [20,
500] determining the cutoff at which line-breaking is tried (default to be
\code{0.75 * getOption("width")})}
\item{\dots}{other arguments passed to \code{\link[base]{cat}}, e.g.
\code{file}}}
\examples{## tidy up the source code of image demo
x = file.path(system.file(package = "graphics"), "demo", "image.R")
# to console
tidy.source(x)
# to a file
f = tempfile()
tidy.source(x, keep.blank.line = TRUE, file = f)
## check the original code here and see the difference
file.show(x)
file.show(f)
## use global options
options(keep.comment = TRUE, keep.blank.line = FALSE)
tidy.source(x)
## if you've copied R code into the clipboard
\dontrun{
tidy.source("clipboard")
## write into clipboard again
tidy.source("clipboard", file = "clipboard")
}}
