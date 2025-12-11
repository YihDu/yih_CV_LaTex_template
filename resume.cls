
%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\ProvidesClass{resume}[2022/12/17 v3.0 Resume class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{article} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\usepackage[parfill]{parskip} % Remove paragraph indentation

\usepackage{array} % Required for bold tabular columns

\usepackage{ifthen} % Required for ifthenelse statements

\usepackage{graphicx} % Required for including images

\pagestyle{empty} % Suppress headers and footers on all pages

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\usepackage{geometry} % Required for adjusting page dimensions and margins

\geometry{
	top=0.5in, % Top margin
	bottom=0.6in, % Bottom margin
	left=0.4in, % Left margin
	right=0.4in, % Right margin
	%showframe, % Uncomment to show how the type block is set on the page
}

%----------------------------------------------------------------------------------------
%	NAME AND ADDRESS COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\name}[1]{\renewcommand{\name}{#1}}

\newcommand{\addressSep}{$|$} % Set default address separator to a diamond symbol

% One, two or three address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% The \address command is used to set the first, second and third address lines (the last 2 are optional)
\newcommand{\address}[1]{
	\@ifundefined{@addressone}{ % If the first address line has not been set yet, set it
		\def \@addressone {#1}
	}{
		\@ifundefined{@addresstwo}{ % If the second address line has not been set yet, set it
			\def \@addresstwo {#1}
		}{ % Otherwise, set the third address line
			\def \@addressthree {#1}
		}%
	}
}

% \printaddress is used to style an address line (provided in the single parameter to the command)
\newcommand{\printaddress}[1]{
	\begingroup
		\def \\ {\addressSep\ } % Redefine newlines (\\) to the address separator symbol so multiple lines of each address are output as a single line
		\centerline{#1} % Output the centered address line
	\endgroup
	\par % End the paragraph to ensure correct spacing between lines
	\smallskip % Vertical whitespace between address lines
}


\newcommand{\printname}{
	\begingroup
		\hfil{\huge\bfseries\name}\hfil % Style and output the user's name
		\bigskip\break % Vertical whitespace below name
	\endgroup
}



\let\ori@document=\document % Store the original \document command
\renewcommand{\document}{
	\ori@document  % Output the original \document command but add to it below
	\printname % Output the user's name
	\@ifundefined{@addressone}{}{\printaddress{\@addressone}} % Output the first address if specified
	\@ifundefined{@addresstwo}{}{\printaddress{\@addresstwo}} % Output the second address if specified
	\@ifundefined{@addressthree}{}{\printaddress{\@addressthree}} % Output the third address if specified
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the major sections within the CV
\newenvironment{rSection}[1]{ % The single parameter is for the section title
	% \medskip % Vertical whitespace
        \vspace{0.3em}
        {\Large \textbf{\capitalisewords{#1}}}
	% \medskip % Vertical whitespace
        \vspace{0.2em}
	% \hrule % Horizontal rule
	\begin{list}{}{ % List to indent the entire content of the section
		\setlength{\leftmargin}{0em} % Indent to the left of the list
	}
	\item[] % Empty list item to enable indentation
}{
	\end{list}
    \vspace{0.2em}
}

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newenvironment{rSubsection}[4]{ % 4 parameters: company name, year(s) employed, job title and location
	\textbf{#1} \hfill {#2} % Bold company name and date to the right
	\ifthenelse{\equal{#3}{}}{}{ % If the third parameter is empty, don't output the job title and location line
		\\ % Job title and location on a new line
		{#3} \hfill \textit{#4} % Output job title and location
	}%
	% \smallskip % Vertical whitespace
        \vspace{-0.1em}
	\begin{list}{$\cdot$}{\leftmargin=1em} % \cdot used for bullets, no indentation
		\setlength{\itemsep}{-0.5em} \vspace{-0.5em} % Reduce vertical spacing between items in the list for a tighter look
}{
	\end{list}
	\vspace{0.5em} % Vertical whitespace after the end of the list
}
