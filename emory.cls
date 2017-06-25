%%%%%%%%%%%%%%%%%%%%%% Emory Dissertation Class %%%%%%%%%%%%%%%%%%%%%
% This class provides style settings suitable for the dissertation  %
% of the Laney Graduate School of Emory University, specially for   %
% STEM fields of study                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------------------------ Class declaration ----------------------
\ProvidesClass{emory}[2016/12/01 LaTeX class for Emory dissertation]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{ifthen}

% ----- Declare options can be passed on to report.cls -----
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\DeclareOption{final}{\PassOptionsToClass{final}{report}}
\DeclareOption*{\OptionNotUsed \ClassWarning{emory}{'\CurrentOption' not allowed.}}

% ----- Process options & load class -----%
\ProcessOptions
\LoadClass[12pt]{report}
% ----------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------ Page Style Control ------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----- Declare boolean switches
\newboolean{If@option@dissertation}
\setboolean{If@option@dissertation}{true}
\newboolean{If@option@twoside}
\setboolean{If@option@twoside}{false}
\newboolean{If@preset@chapter}
\setboolean{If@preset@chapter}{true}
\newboolean{If@preset@fig}
\setboolean{If@preset@fig}{true}
\newboolean{If@preset@list}
\setboolean{If@preset@list}{true}
\newboolean{If@preset@table}
\setboolean{If@preset@table}{true}
\newboolean{If@preset@toc}
\setboolean{If@preset@toc}{true}

% ----- Define key value pairs -----
\RequirePackage{xkeyval}
\define@boolkey[emory]{option}{dissertation}[true]{%
  \setboolean{If@option@dissertation}{#1}
}
\define@boolkey[emory]{option}{twoside}[false]{%
  \setboolean{If@option@twoside}{#1}
}
\define@boolkey[emory]{preset}{chapter}[true]{%
  \setboolean{If@preset@chapter}{#1}
}
\define@boolkey[emory]{preset}{fig}[false]{%
  \setboolean{If@preset@fig}{#1}
}
\define@boolkey[emory]{preset}{list}[false]{%
  \setboolean{If@preset@list}{#1}
}
\define@boolkey[emory]{preset}{table}[false]{%
  \setboolean{If@preset@table}{#1}
}
\define@boolkey[emory]{preset}{toc}[true]{%
  \setboolean{If@preset@toc}{#1}
}

% ----- set double space for 12pt font -----
\renewcommand*{\baselinestretch}{1.655}

% ------ define custome environments -------
\newenvironment{schematic}{%
\begin{figure}[htp!]
\renewcommand{\figurename}{Schematic}
}{\end{figure}}

% ------ Load packages -------
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{color}
\RequirePackage[version=3]{mhchem}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{titletoc}

% ----- configure preset styles -----
\def\set@preset@chapter{%
\ifthenelse{\boolean{If@preset@chapter}}{%
  \titleformat{\chapter}[block]{\bfseries\LARGE}{\chaptername\ \thechapter}{2ex}{}
  \titlespacing{\chapter}{0pt}{0pt}{6ex}
  \titleformat{\section}[block]{\bfseries\Large}{\thesection}{2ex}{}
  \titlespacing{\section}{0pt}{4ex}{2ex}
  \titleformat{\subsection}[block]{\bfseries\large}{\thesubsection}{2ex}{}
  \titlespacing{\subsection}{0pt}{3ex}{1ex}
  \titleformat{\subsubsection}[block]{\bfseries\normalsize}{}{2ex}{}
  \titlespacing{\subsubsection}{0pt}{2ex}{0ex}
}{}
}

\def\set@preset@fig{%
\ifthenelse{\boolean{If@preset@fig}}{%
  \setlength{\abovecaptionskip}{0pt plus 2pt minus 0pt}
}{}
}

% --- chapter with arabic numbering, without "Chapter"
%  \titleformat{\chapter}[block]{\bfseries\LARGE}{\thechapter}{2ex}{}
%  \titlespacing{\chapter}{0pt}{3pt}{4ex}
% --- chapter with roman numbering and "Chapter"
%  \titleformat{\chapter}[block]{\bfseries\LARGE}{\chaptername\ \@Roman{\thechapter}}{2ex}{}
%  \titlespacing{\chapter}{0pt}{3ex}{4ex}
% --- chapter with arabic numbering, without "Chapter"
%  \titleformat{\chapter}[block]{\bfseries\LARGE}{\@Roman{\thechapter}}{2ex}{}
%  \titlespacing{\chapter}{0pt}{3ex}{4ex}

\def\set@preset@list{%
\ifthenelse{\boolean{If@preset@list}}{%
  \renewcommand{\labelitemi}{$\bullet$}
  \renewcommand{\labelitemii}{--}
  \renewcommand{\labelitemiii}{$\ast$}
  \renewcommand{\labelitemiv}{$\circ$}
  \renewcommand{\theenumii}{\arabic{enumii}}
  \renewcommand{\theenumiii}{\roman{enumiii}}
  \renewcommand{\theenumiv}{\alph{enumiv}}
  \renewcommand{\labelenumi}{\theenumi.}
  \renewcommand{\labelenumii}{(\theenumii).}
  \renewcommand{\labelenumiii}{(\theenumiii).}
  \renewcommand{\labelenumiv}{(\theenumiv).}
}{}
}

\def\set@preset@table{%
\ifthenelse{\boolean{If@preset@table}}{%
  \renewcommand*{\arraystretch}{1}
  \setlength{\arrayrulewidth}{0.5pt}
  \setlength{\belowcaptionskip}{1ex plus 2pt minus 2pt}
}{}
}

\def\set@preset@toc{%
\ifthenelse{\boolean{If@preset@toc}}{%
  \contentsmargin{0.4in}
  \dottedcontents{chapter}[1.5em]{\bfseries\large\addvspace{1ex}}{1em}{0.75pc}
  \dottedcontents{section}[3.5em]{\normalsize}{2em}{0.75pc}
  \dottedcontents{subsection}[6.5em]{\normalsize}{3em}{0.75pc}
}{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------ Biblatex Style Handling ------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\presetbib}[1]{%
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[%
    backend=biber,
    texencoding=utf8,
    bibstyle=nature,
    citestyle=numeric-comp,
    autocite=inline,
    autopunct=true,
    sorting=none,
    date=short,
    doi=true,
    url=false,
    eprint=false,
  ]{biblatex}
  \addbibresource{#1}
  \AtEndDocument{%
    \printbibliography[heading=bibintoc]
  }
}

%% Internal counters
\newcommand*{\th@PassCmd}[2]{\gdef#1{#2}}
\newcount\th@advisor@count
\newcount\th@committee@count
\newcount\th@prevdeg@count
\newcount\@tmp
\newcount\@half

%% Define preamble commands
\renewcommand*{\title}[1]{\th@PassCmd{\th@title}{#1}}
\renewcommand*{\author}[1]{\th@PassCmd{\th@author}{#1}}
\newcommand*{\degree}[1]{\th@PassCmd{\th@degree}{#1}}
\newcommand*{\field}[1]{\th@PassCmd{\th@field}{#1}}
\newcommand*{\yr}[1]{\th@PassCmd{\th@year}{#1}}
\newcommand*{\dean}[1]{\th@PassCmd{\th@Dean}{#1}}
\newcommand*{\prevdegree}[1]{%
  \global\advance\th@prevdeg@count\@ne\relax
  \expandafter\gdef\csname th@prevdegree\romannumeral\th@prevdeg@count \endcsname{#1}\relax
}
\newcommand*{\advisor}[2]{%
  \global\advance\th@advisor@count\@ne\relax
  \expandafter\gdef\csname th@advisor\romannumeral\th@advisor@count \endcsname{#1, #2}\relax
}
\newcommand*{\committee}[2]{%
  \global\advance\th@committee@count\@ne\relax
  \expandafter\gdef\csname th@committee\romannumeral\th@committee@count \endcsname{#1, #2}\relax
}

%% ----- Define special pages ------

% Distribution Agreement
\def\th@DistributionAgreement{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \subsection*{Distribution Agreement}

  \noindent\normalsize
  In presenting this thesis or dissertation as a partial fulfillment of the
  requirements for an advanced degree from Emory University, I hereby grant to
  Emory University and its agents the non-exclusive license to archive, make
  accessible, and display my thesis or dissertation in whole or in part in all
  forms of media, now or hereafter known, including display on the world wide
  web.  I understand that I may select some access restrictions as part of the
  online submission of this thesis or dissertation.  I retain all ownership
  rights to the copyright of the thesis or dissertation.  I also retain the
  right to use in future works (such as articles or books) all or part of this
  thesis or dissertation.


  \vspace{1in}
  \noindent Signature:
  \vspace{1em}

  \noindent
  \begin{tabular}{c c c}
  \underline{\hspace{2.5in}} & \hspace{0.25in} & \underline{\hspace{1.5in}}\\
  \th@author & \hspace{0.25in} & Date\\
  \end{tabular}
  \vspace*{\fill}

  \clearpage
}

% Approval Sheet
\def\th@ApprovalSheet{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \noindent
  \begin{center}
    \large \th@title \normalsize
    \vspace{3ex}

    By
    \vspace{3ex}

    \th@author

    \th@degree
    \vspace{1ex}

    \th@field
    \vspace{5ex}

    \@tmp\z@\relax

    \loop
      \advance\@tmp\@ne\relax
      \underline{\hspace{4in}}

      \@nameuse{th@advisor\romannumeral\@tmp}

      Advisor
      \vspace{3ex}

      \ifnum\@tmp<\th@advisor@count\relax
    \repeat

    \vspace{1ex}

    \@tmp\z@\relax
    \ifnum\th@committee@count<4
      % less than 3 committee, one column layout
      \loop
        \advance\@tmp\@ne\relax
        \underline{\hspace{4in}}

        \@nameuse{th@committee\romannumeral\@tmp}

        Committee Member
        \vspace{3ex}

        \ifnum\@tmp<\th@committee@count\relax
      \repeat
    \else
      % more than 3 committee, two column layout
      \@half=\th@committee@count
      \ifodd\th@committee@count
        \divide\@half by\tw@
        \advance\@half\@ne
      \else
        \divide\@half by\tw@
      \fi

      \parbox[t][][c]{2.5in}{%
        \centering
        \loop
          \advance\@tmp\@ne\relax
          \underline{\hspace{2.4in}}

          \@nameuse{th@committee\romannumeral\@tmp}

          Committee Member
          \vspace{3ex}

          \ifnum\@tmp<\@half\relax
        \repeat
      }
      \parbox[t][][c]{2.5in}{%
        \@tmp=\@half
        \centering
        \loop
          \advance\@tmp\@ne\relax
          \underline{\hspace{2.4in}}

          \@nameuse{th@committee\romannumeral\@tmp}

          Committee Member
          \vspace{3ex}

          \ifnum\@tmp<\th@committee@count\relax
        \repeat
      }
    \fi

    \vspace*{\fill}

    Accepted:
    \vspace{2ex}

    \underline{\hspace{4in}}

    \th@Dean

    Dean of the James T.\ Laney School of Graduate Studies

    \vspace{5ex}
    \underline{\hspace{2in}}

    Date
  \end{center}
  \vspace*{\fill}
  \clearpage
}

\def\th@AbstractCoverPage{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{center}
    \large \th@title \normalsize
    \vspace{1in}

    By
    \vspace{1in}

    \th@author

    \@tmp\z@\relax
    \ifnum\th@prevdeg@count=\@ne
      \@nameuse{th@prevdegree\romannumeral\@ne}
    \else
      \@tmp\z@
      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@prevdegree\romannumeral\@tmp}

        \ifnum\@tmp<\th@prevdeg@count
      \repeat
    \fi

    \vspace{1in}

    \@tmp\z@\relax
    \ifnum\th@advisor@count=\@ne
      Advisor: \@nameuse{th@advisor\romannumeral\@ne}
    \else
      Advisor:

      \@tmp\z@
      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@advisor\romannumeral\@tmp}

        \ifnum\@tmp<\th@advisor@count
      \repeat
    \fi

    \vfill
    An abstract of \\
    A \ifthenelse{\boolean{If@option@dissertation}}{dissertation}{thesis} submitted to the Faculty of the \\
    James T.\ Laney School of Graduate Studies of Emory University \\
    in partial fulfillment of the requirements for the degree of \\
    \th@degree \\
    in \th@field \\
    \th@year
  \end{center}
  \vspace{1.5in}

  \clearpage
}

\def\th@CoverPage{%
  \thispagestyle{empty}
  \vspace*{\fill}

  \begin{center}
    \large \th@title \normalsize
    \vspace{1in}

    By
    \vspace{1in}

    \th@author

    \@tmp\z@\relax
    \ifnum\th@prevdeg@count=\@ne
      \@nameuse{th@prevdegree\romannumeral\@ne}
    \else
      \@tmp\z@
      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@prevdegree\romannumeral\@tmp}

        \ifnum\@tmp<\th@prevdeg@count
      \repeat
    \fi

    \vspace{1in}

    \@tmp\z@\relax
    \ifnum\th@advisor@count=\@ne
      Advisor: \@nameuse{th@advisor\romannumeral\@ne}
    \else
      Advisor:

      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@advisor\romannumeral\@tmp}

        \ifnum\@tmp<\th@advisor@count
      \repeat
    \fi

    \vfill
    A \ifthenelse{\boolean{If@option@dissertation}}{dissertation}{thesis} submitted to the Faculty of the \\
    James T.\ Laney School of Graduate Studies of Emory University \\
    in partial fulfillment of the requirements for the degree of \\
    \th@degree \\
    in \th@field \\
    \th@year
  \end{center}
  \vspace{1.5in}
  \clearpage
}

\renewenvironment{abstract}[1][4.5in]{%
  \typeout{>>> Make Abstract Cover Page >>>}
  \thispagestyle{empty}

  \begin{center}
    \large
    \textbf{Abstract}
    \vspace{3ex}

    \th@title\normalsize

    \vspace{2ex}
    By \th@author
  \vspace{0.5in}

  \ifdim #1>6in%
    \begin{minipage}[t]{6in}
  \else
    \begin{minipage}[t]{#1}
  \fi
}{%
  \end{minipage}
  \end{center}
  \clearpage
  \typeout{>>> Make Cover Page >>>}
  \th@CoverPage
}

\newenvironment{acknowledgement}{%
  \typeout{>>> Make Acknowledgement Page >>>}

  \thispagestyle{empty}

  \begin{center}
    \large
    \textbf{Acknowledgement}
  \end{center}
}{%
  \clearpage
}


%% ------ set up page geometry and header ------

\def\set@geometry{%
  \ifthenelse{\boolean{If@option@twoside}}{%
    \RequirePackage[onecolumn,
                    twoside,
                    paper=letterpaper,
                    total={6in,9in},
                    left=1.5in,right=1in,
                    vmargin=1in,
                    vcentering=true,
                    headheight=0.25in,
                    landscape=false]{geometry}
  }{%
    \RequirePackage[onecolumn,
                    paper=letterpaper,
                    total={6.5in,9in},
                    hmargin={1.5in,1in},
                    vmargin=1in,
                    vcentering=true,
                    headheight=0.25in,
                    landscape=false]{geometry}
  }
}

\def\set@header{%
  \RequirePackage{fancyhdr}
  % set page numbering on the right top
  \pagestyle{fancy}
  \fancyhead[R]{\thepage}
  \fancyhead[L]{}
  \fancyhead[C]{}
  \fancyfoot[F]{}
  \renewcommand{\headrulewidth}{0pt}
  \addtolength{\headheight}{6pt}
  % redefine chapter style
  \fancypagestyle{plain}{%
    \fancyhead[R]{\thepage}
    \fancyhead[L]{}
    \fancyhead[C]{}
    \fancyfoot[F]{}
    \renewcommand{\headrulewidth}{0pt}
    \addtolength{\headheight}{6pt}
  }
}


%% Make special pages
\AtBeginDocument{%
  \set@geometry
  \newgeometry{twoside=false,left=1.5in,right=1in,vmargin=1in}
  \pagenumbering{gobble}     % suppress page numbering
  \set@header
  \th@special@page@before@abstract
  % special pages after abstract are set in the abstract & acknowledge environments
  % because abstract has to go after \begin{document}
}


\AtBeginDocument{%
  \set@preset@chapter
  \set@preset@fig
  \set@preset@list
  \set@preset@table
  \set@preset@toc
}

\def\th@special@page@before@abstract{%
  \renewcommand{\baselinestretch}{1}
  \typeout{>>> Make Distribution Agreement >>>}
  \th@DistributionAgreement
  \typeout{>>> Make Approval Sheet >>>}
  \th@ApprovalSheet
  \typeout{>>> Make Abstract Cover Page >>>}
  \th@AbstractCoverPage
}

\newcommand*{\maketoc}{\th@t@c}
\def\th@t@c{%
  \begingroup
  \typeout{>>> Make Table of Contents >>>}
  \renewcommand{\contentsname}{Table of Contents}
  \tableofcontents
  \clearpage
  \listoffigures
  \clearpage
  \listoftables
  \clearpage
  \endgroup
  \typeout{}
  \typeout{--------------------------------------}
  \typeout{}
  \typeout{>>> Make Body >>>}
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \restoregeometry
}


\newcommand*{\BibTeX}{\rm B\kern-.05em{\sc i\kern-.025em b}\kern-.08em\TeX}
