\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mimosis}[2017/08/01 Minimal modern thesis class]

\PassOptionsToPackage{
  DIV  = 10,    % TODO: Make configurable
  BCOR = 10mm,  % TODO: Make configurable
}{typearea}

\LoadClass[a4paper,
           oneside,
           12pt,
           cleardoublepage=empty,
           numbers=noenddot,
           titlepage,
           autooneside=false,
           %DIV12,
           toc=bibliography,
           toc=index,]{scrbook}


\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}

\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifxetexorluatex
  \RequirePackage{fontspec}
\else
  \RequirePackage[utf8]{inputenc}
\fi

% Makes it possible to switch between different languages in the text
% while keeping hyphenation rules correct. Should you add another one
% in the list, please ensure that `english` is the last one. The last
% language is used to control standard hyphenation.
\usepackage[french,english,ngerman]{babel}

\RequirePackage{csquotes} % Context-sensitive quotation marks
\RequirePackage{makeidx}  % For creating indices
\RequirePackage{xspace}   % For automatically "eating" spaces

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multi-line comments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\comment}[1]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts & colours
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[usenames,dvipsnames]{xcolor}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\graphicspath{%
  {Figures/}
  {./}
}

% Suppress warnings about page groups in PDFs. This is not justified
% in most of the cases. I am pretty sure I am including my images in
% the right manner.
\begingroup\expandafter\expandafter\expandafter\endgroup
\expandafter\ifx\csname pdfsuppresswarningpagegroup\endcsname\relax
\else
  \pdfsuppresswarningpagegroup=1\relax
\fi

\RequirePackage{subcaption}

% Make sub-references using \subref being typeset with parentheses.
% Otherwise, only the counter will be printed.
\captionsetup{subrefformat=parens}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glossaries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[%
  acronym,
  automake,
  nogroupskip,
  nopostdot,
  nonumberlist,
  toc,
  ]{glossaries}

% New style that prevents line-breaks between the full description and
% the acronym. Furthermore, it ensures that the acronym is always
% printed in an upright font.
\newacronymstyle{long-short-mimosis}
{%
  \GlsUseAcrEntryDispStyle{long-short}%
}%
{%
  \GlsUseAcrStyleDefs{long-short}%
  \renewcommand*{\genacrfullformat}[2]{%
    \glsentrylong{##1}##2~\textup{(\firstacronymfont{\glsentryshort{##1}})}%
  }%
  \renewcommand*{\Genacrfullformat}[2]{%
    \Glsentrylong{##1}##2~\textup{(\firstacronymfont{\glsentryshort{##1}})}%
  }%
  \renewcommand*{\genplacrfullformat}[2]{%
    \glsentrylongpl{##1}##2~\textup{(\firstacronymfont{\glsentryshortpl{##1}})}%
  }%
  \renewcommand*{\Genplacrfullformat}[2]{%
    \Glsentrylongpl{##1}##2~\textup{(\firstacronymfont{\Glsentryshortpl{##1}})}%
  }%
}

% A new glossary style that based on the long style of the glossaries
% package. It ensures that descriptions and entries are aligned.
\newglossarystyle{long-mimosis}{%
  \setglossarystyle{long}

  \renewcommand{\glossentry}[2]{%
    \glsentryitem{##1}\glstarget{##1}{\glossentryname{##1}} &
    \glossentrydesc{##1}\glspostdescription\space ##2\tabularnewline
  }%
}

% Constrain the description width to enforce breaks.
\setlength{\glsdescwidth}{10cm}

\setacronymstyle{long-short-mimosis}
\setglossarystyle{long-mimosis}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paragraph lists & compact enumerations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[%
    olditem,  % Do not modify itemize environments by default
    oldenum   % Do not modify enumerate environments by default
  ]{paralist}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{setspace}
%\onehalfspacing
\linespread{1.5}
%\singlespacing=true
\baselineskip=12pt
\raggedbottom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{adjustbox}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Proper typesetting of units
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[binary-units=true]{siunitx}

\sisetup{%
  detect-all           = true,
  detect-family        = true,
  detect-mode          = true,
  detect-shape         = true,
  detect-weight        = true,
  detect-inline-weight = math,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mathematics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{dsfont}

% Fix the spacing of \left and \right. Use these with the proper bracket
% in order to ensure that they scale automatically.
\let\originalleft\left
\let\originalright\right
\renewcommand{\left}{\mathopen{}\mathclose\bgroup\originalleft}
\renewcommand{\right}{\aftergroup\egroup\originalright}

\DeclareMathOperator*{\argmin}          {arg\,min}
\DeclareMathOperator {\dist}            {dist}
\DeclareMathOperator {\im}              {im}

\newcommand{\domain}{\ensuremath{\mathds{D}}}
\newcommand{\real}  {\ensuremath{\mathds{R}}}

% Proper differential operators
\newcommand{\diff}[1]{\ensuremath{\operatorname{d}\!{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ordinals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand  {\st}{\textsuperscript{\textup{st}}\xspace}
\newcommand  {\rd}{\textsuperscript{\textup{rd}}\xspace}
\newcommand  {\nd}{\textsuperscript{\textup{nd}}\xspace}
\renewcommand{\th}{\textsuperscript{\textup{th}}\xspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Penalties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\clubpenalty         = 10000
\widowpenalty        = 10000
\displaywidowpenalty = 10000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Headers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typefaces for parts, chapters, and sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\partformat}{\huge\partname~\thepart\autodot}
\renewcommand{\raggedpart}{\flushleft}

\setkomafont{part}{\normalfont\huge\scshape}

\setkomafont{sectioning}{\normalfont\scshape}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

\setkomafont{caption}{\small}
\setkomafont{captionlabel}{\usekomafont{caption}}

% Large number for chapter
\renewcommand*{\chapterformat}{%
  \fontsize{30}{55}\selectfont\thechapter\autodot\enskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for better breakpoints in words
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{microtype}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for footnotemargin 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[hang]{footmisc}
\setlength{\footnotemargin}{2mm}

%\RequirePackage{chngcntr}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for pdf inclusion 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{pdfpages}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for code snippets or program files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{listings}
\RequirePackage{xcolor}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}


\lstdefinestyle{mystyle}{
    language=Python,
    %backgroundcolor=\color{backcolour},   
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    %numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2,
    frame=tb
}

\lstset{style=mystyle}
\renewcommand{\lstlistingname}{Quellcode}
\renewcommand\lstlistlistingname{Quellcodeverzeichnis}


