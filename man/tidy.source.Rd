\name{tidy.source}
\alias{tidy.source}
\title{`Tidy up' R code and try to preserve comments.}
\usage{tidy.source(source = "clipboard", keep.comment, keep.blank.line, 
    keep.space, output = TRUE, text, width.cutoff = 0.75 * getOption("width"), 
    ...)

}
\description{`Tidy up' R code and try to preserve comments.
This function has nothing to do with code optimization; it just
returns parsed source code, but also tries to preserve comments,
which is different with \code{\link[base]{parse}}. See `Details'.}
\details{This function helps the users to tidy up their source code in a
sense that necessary indents and spaces will be added, etc. See
\code{\link[base]{parse}}. But comments will be preserved if
\code{keep.comment = TRUE}.

The method to preserve comments is to protect them as strings in
disguised assignments. For example, there is a single line of
comments in the source code:
\preformatted{  # asdf}

It will be first masked as
\preformatted{.SOME_IDENTIFIER = "  # asdf.ANOTHER_IDENTIFIER"}

which is a legal R expression, so \code{\link[base]{parse}} can
deal with it and will no longer remove the disguised comments.
In the end the identifiers will be removed to restore the original
comments, i.e. the strings \code{'.SOME_IDENTIFIER = "'} and
\code{'.ANOTHER_IDENTIFIER"'} are replaced with empty strings.

``Inline'' comments are identified as ``two or more spaces'' plus
the hash symbol \code{#} without any following double quotes in
the line, e.g.
\preformatted{1+1  #  comments}

or
\preformatted{1+1    # comments}

This might be dangerous to your source code, for instance,
\preformatted{a = 'I am a string   #yes'}

does not contain comments (\code{#} is inside a string), but this
function will treat it as if it does! If you need to use the hash
symbol in a string, you must put it in double quotes, e.g.
\preformatted{a = "I am a string   #yes"}

Inline comments are first disguised as a weird operation with its
preceding R code, which is essentially meaningless but
syntactically correct!  For example,
\preformatted{1+1 \%InLiNe_IdEnTiFiEr\% "   # comments"}

then \code{\link[base]{parse}} will deal with this expression;
again, the disguised comments will not be removed. In the end,
inline comments will be freed as well (remove the operator
\code{\%InLiNe_IdEnTiFiEr\%} and surrounding double quotes).

All these special treatments to comments are due to the fact that
\code{\link[base]{parse}} and \code{\link[base]{deparse}} can tidy
the R code at the price of dropping all the comments.}
\value{A list with components \item{text.tidy}{The reformatted
code as a character vector.} \item{text.mask}{The code containing
comments, which are masked in assignments or with the weird
operator.}  \item{begin.comment,end.comment}{ identifiers used to
mark the comments }}
\note{When \code{keep.comment == TRUE}, \emph{you must not use
double quotes in your inline comments -- only single quotes are
allowed!!} For example, the code below will make the function
discard the comments:
\preformatted{1 + 1  # here is the "comment"}

Instead, you have to write like this to protect the comments:
\preformatted{1 + 1  # here is the 'comment'}

There are hidden options which can control the behaviour of this
function: the argument \code{keep.comment} gets its value from
\code{options('keep.comment')} by default;  \code{keep.blank.line}
from \code{options('keep.blank.line')}, and \code{keep.space} from
\code{options('keep.space')}. If these options are \code{NULL},
the default values will be \code{TRUE}, \code{FALSE} and
\code{FALSE} respectively.

\subsection{Warning}{ The best strategy to avoid failure is to put
comments in whole lines or after \emph{complete} R
expressions. Here are some examples which could make
\code{\link{tidy.source}} fail:
\preformatted{if (TRUE) {  ## comments right after a curly brace } }

\preformatted{1 + 2 +   ## comments after an incomplete line

3 + 4}

}}
\author{Yihui Xie <\url{http://yihui.name}> with substantial
contribution from Yixuan Qiu <\url{http://yixuan.cos.name}>}
\seealso{\code{\link[base]{parse}}, \code{\link[base]{deparse}},
\code{\link[base]{cat}}}
\references{\url{http://yihui.name/en/2010/04/formatr-farewell-to-ugly-r-code/}}
\keyword{IO}
\arguments{\item{source}{a string: location of the source code (default to be
the clipboard; this means we can copy the code to clipboard and
use \code{tidy.souce()} without specifying the argument
\code{source})}
\item{keep.comment}{logical value: whether to keep comments or
not? (\code{TRUE} by default)}
\item{keep.blank.line}{logical value: whether to keep blank lines
or not? (\code{FALSE} by default)}
\item{keep.space}{logical: whether to preserve the leading spaces
in the single lines of comments (default \code{FALSE})}
\item{output}{output to the console or a file using
\code{\link[base]{cat}}?}
\item{text}{an alternative way to specify the input: if it is
\code{NULL}, the function will read the source code from the
\code{source} argument; alternatively, if \code{text} is a
character vector containing the source code, it will be used as
the input and the \code{source} argument will be ignored}
\item{width.cutoff}{passed to \code{\link[base]{deparse}}: integer
in [20, 500] determining the cutoff at which line-breaking is
tried (default to be \code{0.75 * getOption("width")})}
\item{...}{other arguments passed to \code{\link[base]{cat}},
e.g. \code{file} (this can be useful for batch-processing R
scripts, e.g. \code{tidy.source(source = 'input.R', file =
'output.R')})}
}
\examples{library(formatR)

## use the 'text' argument
src = c("    # a single line of comments is preserved", 
    "1+1", "  ", "if(TRUE){", "x=1  # comments begin with at least 2 spaces!", 
    "}else{", "x=2;print('Oh no... ask the right bracket to go away!')}", 
    "1*3 # this comment will be dropped!", "2+2+2    # 'short comments'", 
    "lm(y~x1+x2)  ### only 'single quotes' are allowed in comments", 
    "1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1  ## comments after a long line")

## source code
cat(src, sep = "\n")

## the formatted version
tidy.source(text = src)

## other options: preserve leading spaces
tidy.source(text = src, keep.space = TRUE)

## preserve blank lines
tidy.source(text = src, keep.blank.line = TRUE)

## discard comments!
tidy.source(text = src, keep.comment = FALSE)

## wanna see the gory truth??
tidy.source(text = src, output = FALSE)$text.mask


## tidy up the source code of image demo
x = file.path(system.file(package = "graphics"), "demo", 
    "image.R")

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
if (interactive()) {
    tidy.source("clipboard")
    ## write into clipboard again
    tidy.source("clipboard", file = "clipboard")
}}






















































