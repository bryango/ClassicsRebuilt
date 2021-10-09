%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "pcms-l.cls",
%%%    version   = "1.2d",
%%%    date      = "1997/01/02",
%%%    time      = "16:00:58 EST",
%%%    checksum  = "31141 554 1081 16347",
%%%    author    = "Barbara Beeton",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the IAS/Park City
%%%                 Mathematics Series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{qft-l}

\newif\ifLecture \Lecturefalse
\newif\ifMonograph \Monographtrue

\DeclareOption{lecture}{\Monographfalse\Lecturetrue}
\DeclareOption{monograph}{\Monographtrue\Lecturefalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]


% part

\def\partname{PART}

\def\part{\cleardoublepage \pagestyle{empty}\thispagestyle{empty}%
  \null\vfil  \markboth{}{}\secdef\@part\@spart}

\def\@part[#1]#2{%
  \refstepcounter{part}
    \addcontentsline{toc}{part}{\partname\ \thepart\protect\newline #1}%
  \begingroup\bfseries
   \vspace*{8pc}%
   \ifodd\c@page\raggedleft\else\raggedright\fi
   \ifnum \c@secnumdepth >-2\relax
       {\Large \partname\ {\LARGE\thepart}} \vskip 8\p@ \fi
   \huge #1\endgraf
  \endgroup\vfill\newpage}

\def\@spart#1{\addcontentsline{toc}{part}{#1}%
  \begingroup\huge\bfseries
   \vspace*{8pc}%
   \ifodd\c@page\raggedleft\else\raggedright\fi
   #1\endgraf
  \endgroup}

\def\pauth#1{{\raggedleft\vspace*{2pc}%
	\LARGE\bfseries\noindent
	#1\endgraf\vfill\newpage}}

\def\abstract{%
  \global\let\abstract\relax
  \global\setbox\abstractbox=\vtop \bgroup
 \normalsize
  \trivlist \labelsep.5em\item[\hskip\labelsep
    {\bfseries\abstractname}.]\ignorespaces
}


%
%      CHAPTER TITLES
%

\def\LogoOn{\global\LogoOntrue}
\newif\ifLogoOn
\LogoOnfalse

\newcount\addressnum@
\newcount\addresscount@
%\newcounter{lecturenum}
\newcounter{lecture}

%    Permit the word `Lecture' to be replaced by, e.g., `Chapter'.
%    (The page style using \chapter is different and unacceptable for
%    a lecture series.)  [bnb, 1996/11/07]
\def\thelecturelabel{Lecture}
\def\thelecturename#1{}

\def\lecturelabel#1{\gdef\thelecturelabel{#1}}
\def\lecturename#1{\gdef\thelecturename{#1\unskip}}
\def\lecture{\global\Lecturetrue\global\Monographfalse
  \global\let\sectionmark\@gobble % \lecturemark will be used instead
  \addtocounter{lecture}1\relax
  \refstepcounter{chapter}%
%  \addtocounter{chapter}1\relax % this is done for section numbering
  {\Large\bfseries
   \raggedleft
   \@xp\uppercase\@xp{\thelecturelabel} {\LARGE\thelecturenum}\\
   \vspace*{3pt}%
   \thelecturename
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\lecturemark\@xp{\thelecturename}%
  \addcontentsline{toc}{chapter}{%
    \thelecturelabel\ \thelecturenum.\ \thelecturename}%
  \vspace{34\p@}\noindent}

\def\chapter{\cleardoublepage \pagestyle{headings}%
  \setcounter{section}0\relax
  \ifMonograph
	\gdef\chaptername{Chapter}%
  \else
	\gdef\chaptername{Lecture}%
	\gdef\thelecturenum{\@arabic\c@lecture}%
  \fi
  \def\@address{}%
  \def\@curraddr{}%
  \def\@email{}%
  \addresscount@=\z@
  \ifLogoOn
%    For the first page of a lecture series, the copyright block will be
%    set with \setaddress as part of the first-page footnote.
%    [bnb, [1996/10/22]
	\thispagestyle{firstpage}%
  \else
	\thispagestyle{plain}%
  	\def\@textbottom{\global\let\@textbottom\@empty}%
  \fi
  \global\@topnum\z@
  \@afterindentfalse \secdef\@chapter\@schapter}
%
\def\@chapter[#1]#2{\refstepcounter{chapter}%
  \ifnum \c@secnumdepth <\z@ \let\thechapter\@empty\fi
  \typeout{\chaptername\space\thechapter}%
  \addcontentsline{toc}{chapter}{%
    \protect\numberline{%
      \ifx\thechapter\@empty\else\chaptername\ \thechapter.\fi}#1}%
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}\@afterheading}


\def\@schapter#1{\typeout{#1}%
 \ifLogoOn
 \else
   \@ifnotempty{#1}{\addcontentsline{toc}{chapter}{#1}}%
 \fi
% \ifMonograph
  \chaptermark{#1}%
% \fi
  \@ifnotempty{#1}{\gdef\thelectureseries{#1}}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makeschapterhead{#1}\@afterheading}


%
\def\@makechapterhead#1{%
  \begingroup \topskip 64pt\relax
    \ifodd\c@page\raggedleft\else\raggedright\fi
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode
      {\Large\bfseries
              \uppercase\@xp{\chaptername}\enspace
       {\LARGE\bfseries\thechapter\par}}%
      \skip@34\p@
      \advance\skip@-\normalbaselineskip
      \vskip\skip@ {\huge\bfseries #1\par}%
    \fi
  \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
%


\def\@makeschapterhead#1{%
 \ifLogoOn
	\global\LogoOnfalse
 \fi
	\vtop to 8pc{\vfill
 \ifodd\c@page
    \ifx#1\contentsname
          \raggedright
    \else
          \raggedleft\fi
  \else\raggedright\fi
  {\huge\bfseries #1\par}%
}%\endgroup
\skip@34\p@\advance\skip@-\normalbaselineskip
  \vskip\skip@ }

%      Sectioning commands


\def\auth#1{\vspace{-1pc}{\raggedleft
	\Large\bf\noindent
	#1\endgraf
	\vspace*{2pc}
        }
        \def\@author{#1}%
}


\def\specialsection{\@startsection{specialsection}{0}%
  \z@{-1.5\linespacing\@plus-1\linespacing}{.5\linespacing}%
  {\Large\bfseries}}

\let\specialsectionmark\@gobble
\let\specialsectionname\@empty
\def\l@specialsection{\@tocline{1}{0pt}{1pc}{}{\bfseries}}
\let\tocspecialsection\tocsection

\def\section{\@startsection{section}{1}%
  \z@{-1\linespacing\@plus-.75\linespacing}{.5\linespacing}%
  {\large\bfseries}}


\def\subsection{\@startsection{subsection}{2}%
  \z@{-.75\linespacing\@plus-.5\linespacing}{.5\linespacing}%
  {\normalfont\bfseries}}

\def\subsubsection{\@startsection{subsubsection}{3}%
   \z@{.5\linespacing\@plus.5\linespacing}{-5\p@}%
   {\normalfont\itshape}}

\def\th@plain{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \itshape
}
\def\th@remark{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}%
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape
}
\def\th@definition{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}%
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape
}

\renewenvironment{proof}[1][\proofname]{\par \normalfont
  \topsep6\p@\@plus6\p@ \trivlist \itemindent\z@
  \item[\hskip\labelsep\bfseries
    #1\@addpunct{.}]\ignorespaces
}{%
  \qed\endtrivlist
}

\def\xcb{%
  \settowidth{\leftmargini}{0.\hskip\labelsep}%
  \settowidth{\leftmarginii}{(d.)\hskip\labelsep}%
\@startsection{section}% counter name; ignored because of the
                                % * below
{1}% sectioning level
{\z@}% indent to the left of the section title
{18\p@\@plus2\p@}% vertical space above *** added 12 more points space!!
{1sp}% Space below of 13pt base-to-base, so none needs to be added
    % here; but \z@ would cause the following text to be run-in, so we
    % use 1sp instead.
{\large\bfseries}% The font of the subsection title
*% always unnumbered
}%

%    correct the form of these commands from \...@ to \@... [bnb, 1997/01/02]
\def\@captionheadfont{\bfseries}
\def\@captionfont{\footnotesize\mdseries}

% run head & foot are bold.
\def\ps@plain{\ps@empty
  \def\@oddfoot{\normalfont\footnotesize\bfseries \hfil\thepage\hfil}%
  \let\@evenfoot\@oddfoot}

\def\ps@headings{\ps@empty
  \def\@evenhead{\normalfont\footnotesize\bfseries \let\\=\space
      \rlap{\thepage}\hfil \leftmark{}{}\hfil}%
  \def\@oddhead{\normalfont\footnotesize\bfseries \let\\=\space \hfil
      \rightmark{}{}\hfil \llap{\thepage}}%
  \let\@mkboth\markboth
  \def\partmark{\@secmark\markboth\partrunhead\partname}%
  \def\chaptermark{%
    \@secmark\markboth\chapterrunhead{}}%
  \def\sectionmark{%
    \@secmark\markright\sectionrunhead\sectionname}%
%    managing the marks for Lecture is a bit complicated
%  \let\lecturemark\sectionmark
  \def\lecturemark{%\let\@secnumber\@empty
%    \@secmark\markright\sectionrunhead\sectionname}%
    \@secmark\markright\lecturerunhead\chaptername}%
}

%    The following is for lecture opening pages.
\def\ps@firstpage{\ps@empty
  \def\@oddfoot{\normalfont\scriptsize \hfil\thepage\hfil
     \global\topskip\normaltopskip}%
  \let\@evenfoot\@oddfoot
  \def\@oddhead{\@serieslogo\hss}%
  \let\@evenhead\@oddhead}% in case an article starts on a left-hand page

%    Delay of these definitions is necessary to get around a similar delay
%    in amsproc, whereby if \cn{publname} is not yet defined, the logo will
%    be omitted, but if \cn{publname} is defined, the logo is defined then.
%    [bnb, 1996/11/06]
\AtBeginDocument{%
  \def\publname{IAS/Park City Mathematics Series}%
  \def\@serieslogo{\vtop to\z@{%
    \parindent\z@ \fontsize{8}{9\p@}\bfseries
        \publname\newline
        Volume \currentvolume, \currentyear\endgraf}%
  }%
}

\def\currentvolume{00}
\def\currentyear{0000}

%    Lectures require a copyright block at the bottom of the first page
%    of the first lecture.  This is not the usual monograph style, so
%    this code has been excerpted from amsproc.cls.  [bnb, 1996/10/22]
\def\copyrightyear{0000}
\newinsert\copyins
\skip\copyins=1.5pc
\count\copyins=1000 % magnification factor, 1000 = 100%
\dimen\copyins=.5\textheight % maximum allowed per page
\def\@setcopyright{%
  \insert\copyins{\hsize\textwidth
    \parfillskip\z@ \leftskip\z@\@plus.9\textwidth
    \fontsize{6}{7\p@}\normalfont\upshape
    \everypar{}%
    \vskip-\skip\copyins \nointerlineskip
    \noindent\vrule\@width\z@\@height\skip\copyins
    \copyright\copyrightyear\ American Mathematical Society\par
    \kern\z@}%
}
\def\@combinefloats{%
  \ifx \@toplist\@empty \else \@cflt \fi
  \ifx \@botlist\@empty \else \@cflb \fi
  \ifvoid\copyins \else \@cflci \fi
}
\def\@cflci{%
  \if\if@twocolumn \if@firstcolumn F\else T\fi\else T\fi T%
      \setbox\@outputbox\vbox{%
        \unvbox\@outputbox
        \vskip\skip\copyins
        \hbox to\columnwidth{%
          \hss\vbox to\z@{\vss\unvbox\copyins}}}%
  \fi
}

\addresscount@=\z@
\def\setaddress{%
  {\let\@makefnmark\relax  \let\@thefnmark\relax
        \nobreak
        \addressnum@=\z@
        \loop\ifnum\addressnum@<\addresscount@\advance\addressnum@\@ne
           \footnote{$^{\hbox{\tiny\number\addressnum@}}$%
           \csname @address\number\addressnum@\endcsname
           \csname @curraddr\number\addressnum@\endcsname
           \csname @email\number\addressnum@\endcsname}\repeat
    }%
%  \@setcopyright
}

\def\partrunhead#1#2#3{%
  \@ifnotempty{#2}{{#1 #2}\@ifnotempty{#3}{. }}%
  #3}
\let\sectionrunhead\partrunhead

\ifLecture
  \def\chapterrunhead#1#2#3{%
    \let\@tempa\@author
    \uppercasenonmath{\@tempa}%
    \uppercasenonmath{\thelectureseries}%
    \@tempa. \thelectureseries
    }
  \def\lecturerunhead#1#2#3{%
    \let\@tempa\chaptername
    \uppercasenonmath{\@tempa}%
    \def\@tempb{#3\unskip}%
    \uppercasenonmath{\@tempb}%
    \@tempa\ #2. \@tempb
    }
\else
  \let\chapterrunhead\partrunhead
\fi

%% altered \include to set Lecture false
%%  let's not -- there are better ways to do this!

%\def\include#1{\relax
%  \ifnum\@auxout=\@partaux
%    \@latex@error{\string\include\space cannot be nested}\@eha
%  \else \@include#1 \fi}
%\def\@include#1 {\clearpage\global\Lecturefalse\global\Monographtrue
%\if@filesw \immediate\write\@mainaux{\string\@input{#1.aux}}\fi
%\@tempswatrue \if@partsw\@tempswafalse\edef\@tempb{#1}\@for
%\@tempa:=\@partlist\do{\ifx\@tempa\@tempb\@tempswatrue\fi}\fi
%\if@tempswa \let\@auxout\@partaux \if@filesw
%\immediate\openout\@partaux #1.aux
%\immediate\write\@partaux{\relax}\fi\@input@{#1.tex}\clearpage
%\@writeckpt{#1}\if@filesw \immediate\closeout\@partaux \fi
%\else\@nameuse{cp@#1}\fi\let\@auxout\@mainaux}


%% alter backmatter to announce its presence, to permit a separate
%% bibliography in a lecture series to set up proper running heads

\newif\if@backmatter \@backmatterfalse
\def\backmatter{\cleardoublepage \@backmattertrue}


%
%
% this allows for user to have biblio print as either a chapter or
% as a section

\def\thebibliography#1{%
  \ifLecture
    \section*\refname
    \if@backmatter
      \markboth{\refname}{\refname}%
    \fi
  \else
    \chapter*\bibname
    \markboth{\bibname}{\bibname}%
  \fi
  \normalsize\labelsep .5em\relax
  \list{\@arabic\c@enumi.}{\settowidth\labelwidth{\@biblabel{#1}}%
  \leftmargin\labelwidth
  \advance\leftmargin\labelsep
	\bibsetup\relax
	\usecounter{enumi}}\sloppy
  \clubpenalty9999 \widowpenalty\clubpenalty  \sfcode`\.\@m}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%      INDEX
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\theindex{\cleardoublepage
\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@ \columnsep 35pt
\def\indexchap{\@startsection
		{chapter}{1}{\z@}{8pc}{34pt}%
		{\raggedright
		\huge\bfseries}}%
 \twocolumn[\indexchap*{\indexname}]
 \@mkboth{{\indexname}}{{\indexname}}%
	\thispagestyle{plain}\let\item\@idxitem\parindent\z@
	 \footnotesize\parskip\z@ plus .3pt\relax\let\item\@idxitem}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%      TOPMATTER
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\address#1{\global\advance\addresscount@\@ne
    \expandafter\gdef\csname @address\number\addresscount@\endcsname{%
	\noindent #1.}}

\def\curraddr#1{%
	\expandafter\gdef\csname @curraddr\number\addresscount@\endcsname{%
	\endgraf\noindent{\bf Current address}:\enspace #1.}}

\def\email#1{%
	\expandafter\gdef\csname @email\number\addresscount@\endcsname{%
	\endgraf\noindent{\bf E-mail address}:\enspace {\tt #1}.}}



\addresscount@=\z@
\def\@setaddresses{%
{  \let\@makefnmark\relax  \let\@thefnmark\relax
	\nobreak
	\addressnum@=\z@
	\loop\ifnum\addressnum@<\addresscount@\advance\addressnum@\@ne
	   \footnote{$^{\hbox{\tiny\number\addressnum@}}$%
	   \csname @address\number\addressnum@\endcsname
           \csname @curraddr\number\addressnum@\endcsname
           \csname @email\number\addressnum@\endcsname}\repeat
}}

\def\maketitle{\par
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \begingroup
  \@maketitle
  \endgroup
  \c@footnote\z@
  \def\do##1{\let##1\relax}%
  \do\maketitle \do\@maketitle \do\title \do\@xtitle \do\@title
  \do\author \do\@xauthor
  \do\dedicatory \do\@dedicatory
  \do\keywords \do\@keywords \do\subjclass \do\@subjclass
%    if this is a lecture, keep the original definitions for addresses,
%    so that they will be set in footnotes
  \ifLogoOn
  \else
     \do\address \do\@xaddress
     \do\email \do\@xemail \do\curraddr \do\@xcurraddr
     \do\thanks \do\thankses
  \fi
}

\def\@maketitle{\cleardoublepage \thispagestyle{empty}%
  \begingroup \topskip\z@skip
  \null\vfil
  \begingroup
  \begin{flushright}
  \huge\bfseries
  \openup\medskipamount
  \@title\endgraf
  \end{flushright}
  \vspace{24pt}%
  \def\and{\par\bigskip}%
  \begin{flushright}
  \LARGE\bfseries\authors
  \end{flushright}
  \endgroup
  \vfil
  \newpage\thispagestyle{empty}
  \ifx\@empty\addresses\else
  \@setaddresses\fi
    \ifx\@empty\@subjclass\else\@setsubjclass\fi
    \ifx\@empty\@translators\else\vfil\@settranslators\fi
    \ifx\@empty\thankses\else\vfil\@setthanks\fi
  \vfil
  \@setabstract
  \endgroup}


% Filename: pcmslmod.tex v.1.3

% Contains modifications to pcms-l.cls (version 1.2d, 1997/01/02)

% Written by David R. Morrison, 1997/04/20; revised 1997/11/23; 1998/2/9;
% 1998/3/13; 1998/3/31
%\typeout{pcmslmod.tex v.1.3, 1998/3/31}


% Summary of changes
%
% 1. A new command \lectureseries, which specifies the title of the lecture
% series and does the page setup for the first page of the series
% (eliminating the need for a \chapter*{} command).  An optional argument
% allows the specification of a shortened title for running heads.
%
% 2. A modification of the \auth command, allowing the specification of a
% shortened author name for running heads.
%
% 3. A modification of the \lecture command, giving it an argument for the
% specification of the lecture name (rather than a separate \lecturename
% command), and incorporating the \chapter*{} command so that the latter
% does not need to be invoked by the user.  From the user's perspective,
% \lecture should function in a very similar fashion to \chapter.
%
% 3A. In v.1.1 of this file, an alternate "starred" form \lecture* is
% introduced, which allows for the inclusion of unnumbered lectures (such
% as a preface, or a list of problems).  The title of this unnumbered
% lecture is flush left if the lecture is the first one (i.e., the
% preface or introduction), otherwise it is set flush right.
%
% 4. Two style corrections in running heads: the body of the running heads
% should be set in medium weight rather than bold, and the author and title
% should be separated by a comma rather than a period.
%
% 5. Modifications of bibliography and index commands, so that their
% headings and running heads have the same style as lectures.  A new
% user-specifiable option \ifBibliographyIsASection (with default value
% \BibliographyIsASectionfalse) is introduced: it should be set to true if
% a user wants separate bibliography sections at the end of each lecture
% rather than a single bibliography at the end.
%
% 6. A minor style change: since the footnote giving the author address is
% typically several lines long, with subsequent lines giving information
% such as e-mail or current addresses which has equal logical weight to the
% address itself, having the first line of the footnote indented presents a
% strange appearance.  As an easy fix, indentation from footnotes was
% removed. 
%
% 6A. In v.1.1 of this file, the commands \thanks, \subjclass, \keywords,
% and \date were all implemented; as in most AMS styles, they produce 
% additional footnotes on the first page.
%
% 7. The sample files have also been rewritten in a way compatible with these
% changes. 
%

\makeatletter

% First, we define a new command \lectureseries, replacing the 
% \chapter*{title} command at the head of the file.  An optional argument
% allows a shortened form to be specified for use in running heads.  (The
% thing used in running heads is \thelectureseries -- this is unchanged.)
%
% NB: \part* and \pauth commands could still be used to generate a separate
% title page for an individual lecture series, if that is desired.
%
% We also introduce \iffirstlecture, which is set to true by the
% \lectureseries command so that the top-of-page formatting is not repeated
% by the \lecture command in this case.

\newif\iffirstlecture\firstlecturefalse

\newcommand{\lectureseries}{\firstlecturetrue
              \secdef\@lectureseries\@slectureseries} 

\newcommand{\@lectureseries}[2][default]{\chapter*{#2}%
              \gdef\thelectureseries{#1}} 

\newcommand{\@slectureseries}[1]{\chapter*{#1}}

% Next, we redefine \auth to allow for the specification of a shortened
% author name in running heads, as an optional argument.  (TeX-nical note:
% it might have been better to write this command and the previous one
% using \@dblarg rather than \secdef.)

\renewcommand{\auth}{\secdef\@auth\@sauth}

\newcommand{\@auth}[2][default]{\vspace{-1pc}{\raggedleft
        \Large\bf\noindent
        #2\endgraf
        \vspace*{2pc}
        }
        \def\@author{#1}%
}

\newcommand{\@sauth}[1]{\vspace{-1pc}{\raggedleft
        \Large\bf\noindent
        #1\endgraf
        \vspace*{2pc}
        }
        \def\@author{#1}%
}

% Next, we redefine \lecture so that \chapter*{} is not needed.  To make
% this work, we only want to insert \chapter*{} starting with the second
% \lecture command, which was why we introduced \iffirstlecture.
%
% Also, \lecture now takes an argument specifying the title, in place of
% the old \lecturename command.

\def\lecture#1{\global\Lecturetrue\global\Monographfalse
\iffirstlecture\else\chapter*{}\fi\firstlecturefalse
  \global\let\sectionmark\@gobble % \lecturemark will be used instead
  \addtocounter{lecture}1\relax
  \refstepcounter{chapter}%
%  \addtocounter{chapter}1\relax % this is done for section numbering
\gdef\thelecturename{#1\unskip}
  {\Large\bfseries
   \raggedleft
   \@xp\uppercase\@xp{\thelecturelabel} {\LARGE\thelecturenum}\\
   \vspace*{3pt}%
   \thelecturename
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\lecturemark\@xp{\thelecturename}%
  \addcontentsline{toc}{chapter}{%
    \thelecturelabel\ \thelecturenum.\ \thelecturename}%
  \vspace{34\p@}\noindent}
  
% In v.1.1, \lecture is redefined again, to implement the inclusion of a
% "starred" form \lecture*.

\def\lecture{\global\Lecturetrue\global\Monographfalse
\iffirstlecture\else\chapter*{}\fi%
  \global\let\sectionmark\@gobble % \lecturemark will be used instead
\secdef\@lecture\@slecture}

\def\@lecture[#1]#2{%
  \addtocounter{lecture}1\relax
  \refstepcounter{chapter}%
%  \addtocounter{chapter}1\relax % this is done for section numbering
\gdef\thelecturename{#1\unskip}\firstlecturefalse
  {\Large\bfseries
   \raggedleft
   \@xp\uppercase\@xp{\thelecturelabel} {\LARGE\thelecturenum}\\
   \vspace*{3pt}%
%   \thelecturename
    #2\unskip
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\lecturemark\@xp{\thelecturename}%
  \addcontentsline{toc}{chapter}{%
%    \thelecturelabel\ \thelecturenum.\ \thelecturename}%
    \thelecturelabel\ \thelecturenum.\ #2}%
  \vspace{34\p@}\noindent}
  
\def\slecturerunhead#1#2#3{%
    \let\@tempa\chaptername
    \uppercasenonmath{\@tempa}%
    \def\@tempb{#3\unskip}%
    \uppercasenonmath{\@tempb}%
    {\normalfont\@tempb}
    }
\def\slecturemark{%\let\@secnumber\@empty
%    \@secmark\markright\sectionrunhead\sectionname}%
    \@secmark\markright\slecturerunhead\chaptername}%


\def\@slecture#1{%
\iffirstlecture
%  \addtocounter{lecture}1\relax
%  \refstepcounter{chapter}%
%%  \addtocounter{chapter}1\relax % this is done for section numbering
\gdef\thelecturename{#1\unskip}\firstlecturefalse
  {\Large\bfseries
%   \raggedleft
%   \@xp\uppercase\@xp{\thelecturelabel} {\LARGE\thelecturenum}\\
%   \vspace*{3pt}%
%\noindent\@xp\uppercase\@xp{\thelecturename} 
\noindent\thelecturename
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\slecturemark\@xp{\thelecturename}%
%\markright\thelecturename
  \addcontentsline{toc}{chapter}{%
    \thelecturename}%
 \vspace{-6\p@}\noindent
%\noindent
\else
%  \addtocounter{lecture}1\relax
%  \refstepcounter{chapter}%
%%  \addtocounter{chapter}1\relax % this is done for section numbering
\gdef\thelecturename{#1\unskip}\firstlecturefalse
  {\Large\bfseries
   \raggedleft
%   \@xp\uppercase\@xp{\thelecturelabel} {\LARGE\thelecturenum}\\
%   \vspace*{3pt}%
   \@xp\uppercase\@xp{\thelecturename}
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\slecturemark\@xp{\thelecturename}%
%\markright\thelecturename
  \addcontentsline{toc}{chapter}{%
    \thelecturename}%
  \vspace{34\p@}\noindent
\fi}

% We make the following changes to definitions of running heads: 
% (1) add \textmd so that the header is not boldface
% (2) use a comma, not a period, to separate author and lectureseries

\ifLecture
  \def\chapterrunhead#1#2#3{%
    \let\@tempa\@author
    \uppercasenonmath{\@tempa}%
    \uppercasenonmath{\thelectureseries}%
    \textmd{\@tempa, \thelectureseries}
    }
  \def\lecturerunhead#1#2#3{%
    \let\@tempa\chaptername
    \uppercasenonmath{\@tempa}%
    \def\@tempb{#3\unskip}%
    \uppercasenonmath{\@tempb}%
    \textmd{\@tempa\ #2. \@tempb}
    }
\else
  \let\chapterrunhead\partrunhead
\fi

% For the bibliography, we do two things
% (1) we introduce \ifBibliographyIsASection (default is false) to decide
% if a section or a chapter.  When its a chapter, but we are in lecture
% mode, we use the lecture style of headings.  If its a section, it should
% NOT be in backmatter.
% (2) we fix the running heads to be consistent with everything else.

\newif\ifBibliographyIsASection\BibliographyIsASectionfalse

  \def\bibliomark{%\let\@secnumber\@empty
%    \@secmark\markright\sectionrunhead\sectionname}%
    \@secmark\markright\bibliorunhead\chaptername}%

  \def\bibliorunhead#1#2#3{%
    \let\@tempa\chaptername
    \uppercasenonmath{\@tempa}%
    \def\@tempb{#3\unskip}%
    \uppercasenonmath{\@tempb}%
    \textmd{\@tempb}
    }

\def\thebibliography#1{%
  \ifBibliographyIsASection
    \section*\refname
    \if@backmatter
      \markboth{\refname}{\refname}%
    \fi
  \else
\chapter*{}
  {\Large\bfseries
   \raggedleft
   \@xp\uppercase\@xp{\bibname} \\
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\bibliomark\@xp{\bibname}%
  \addcontentsline{toc}{chapter}{%
    \bibname}%
  \vspace{34\p@}\noindent
  \fi
  \normalsize\labelsep .5em\relax
  \list{\@arabic\c@enumi.}{\settowidth\labelwidth{\@biblabel{#1}}%
  \leftmargin\labelwidth
  \advance\leftmargin\labelsep
%	\bibsetup\relax
	\usecounter{enumi}}\sloppy
  \clubpenalty9999 \widowpenalty\clubpenalty  \sfcode`\.\@m}

% We also want to change the headings and running heads for the index.  We
% only do this in the case of a lecture (so the previous definition will still
% be invoked in the case of a monograph.)

  \def\indexmark{%\let\@secnumber\@empty
%    \@secmark\markright\sectionrunhead\sectionname}%
    \@secmark\markright\indexrunhead\chaptername}%

  \def\indexrunhead#1#2#3{%
    \let\@tempa\chaptername
    \uppercasenonmath{\@tempa}%
    \def\@tempb{#3\unskip}%
    \uppercasenonmath{\@tempb}%
    \textmd{\@tempb}
    }

\ifLecture
\def\theindex{\cleardoublepage
\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@ \columnsep 35pt
\def\indexchap{\@startsection
		{chapter}{1}{\z@}{8pc}{34pt}%
		{\raggedleft
		\Large\bfseries}}%
 \twocolumn[\indexchap[{\indexname}]{\@xp\uppercase\@xp{\indexname}}]
%		\Large\bfseries}}%
% \twocolumn[\indexchap*{\@xp\uppercase\@xp{\indexname}}]
% \@mkboth{{\indexname}}{{\indexname}}%
  \@xp\indexmark\@xp{\indexname}%
	\thispagestyle{plain}\let\item\@idxitem\parindent\z@
	 \footnotesize\parskip\z@ plus .3pt\relax\let\item\@idxitem}
\fi

% Finally, a small stylistic change: for the footnote giving the author
% address, indenting the footnote doesn't look good (in my opinion) due to
% the email line NOT being indented. So we change:
%
% \def\@makefntext{\indent\@makefnmark}
%
% to

\def\@makefntext{\noindent\@makefnmark}

% In v.1.1, we also implement \thanks and other commands which make
% first-page footnotes:

\def\setaddress{%
  {\let\@makefnmark\relax  \let\@thefnmark\relax
        \nobreak
        \addressnum@=\z@
        \loop\ifnum\addressnum@<\addresscount@\advance\addressnum@\@ne
           \footnote{$^{\hbox{\tiny\number\addressnum@}}$%
           \csname @address\number\addressnum@\endcsname
           \csname @curraddr\number\addressnum@\endcsname
           \csname @email\number\addressnum@\endcsname}\repeat
  \ifx\@empty\@date\else \@footnotetext{\@setdate}\fi
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}\fi
    }%
%  \@setcopyright
}

% fix blank pages (Dan Freed -- November 25, 1997)

\def\@tmpevenhead{\relax}

\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \let\@tmpevenhead\@evenhead \let\@evenhead\relax\hbox{}\eject 
    \let\@evenhead\@tmpevenhead\if@twocolumn\hbox{}\newpage\fi\fi\fi}

% define \copyrightyear to be \currentyear (Dan Freed -- March 13, 1998)

\def\@setcopyright{%
  \let\copyrightyear\currentyear             % DF
  \insert\copyins{\hsize\textwidth
    \parfillskip\z@ \leftskip\z@\@plus.9\textwidth
    \fontsize{6}{7\p@}\normalfont\upshape
    \everypar{}%
    \vskip-\skip\copyins \nointerlineskip
    \noindent\vrule\@width\z@\@height\skip\copyins
    \copyright\copyrightyear\ American Mathematical Society\par
    \kern\z@}%
}

% macro to put in blank page at beginning for 2-up viewing

\def\BlankPage{\pagestyle{empty}\thispagestyle{empty}\null\vfil\eject} 

\def\Notetaker#1{{\let\@makefnmark\relax  \let\@thefnmark\relax
		 \footnote{\bf Notes by #1}  \addtocounter{footnote}{-1}}}

\def\Head#1{\section{#1}}
\def\Headnn#1{\section*{#1}}

\numberwithin{section}{chapter}
\numberwithin{equation}{chapter}

\def\Notes{\begingroup\small\Headnn{References and cross
references}\parindent12pt} 

\def\endNotes{\endgroup}

\newenvironment{reflist}{\begin{list}{}{\medskip\setlength{\leftmargin}{39pt}
\setlength{\rightmargin}{0pt}\setlength{\itemindent}{-9pt}}}{\end{list}\medskip}


%	XREF CODES 

\newcount\commacount@
\def\first@#1#2\end{#1}
\def\true@{TT}
\def\false@{TF}
\def\empty@{}
\begingroup  \catcode`\-=3
\long\gdef\notempty#1{%
  \expandafter\ifx\first@#1-\end-\empty@ \false@\else \true@\fi}
\endgroup
\def\tcomma#1{\commacount@=0 \testcomma#1\end } 
\def\testcomma#1{\ifx#1\end \let\next=\relax 
  \else\if#1,\commacount@=1\fi\let\next=\testcomma\fi\next}
\def\tperiod#1{\commacount@=0 \testperiod#1\end } 
\def\testperiod#1{\ifx#1\end \let\next=\relax 
  \else\if#1.\commacount@=1\fi\let\next=\testperiod\fi\next}

\def\CODE#1#2#3#4{\if\notempty{#2}\tcomma{#2}\ifnum\commacount@=1[#4-{\bf %
   #1}, \S\S#2]\else \tperiod{#2}\ifnum\commacount@=1[#4-{\bf #1},~\S#2]\else%
   #3#2 of [#4-{\bf #1}]\fi\fi\else[#4-{\bf #1}]\fi}

\def\ASH#1{\CODE{Home\-work}{#1}{Problem~ASH}{I}}
\def\CFT#1{\CODE{CFT}{#1}{Lecture~}{II}}
\def\CF#1{\CODE{Clas\-sical Fields}{#1}{Chapter~}{I}}
\def\DQFT#1{\CODE{Dynam\-ics of QFT}{#1}{Lecture~}{II}}
\def\DQFTP#1{\CODE{Dynam\-ics of QFT, Exercises}{#1}{Problem~}{II}}
\def\DQ#1{\CODE{Quan\-ti\-za\-tion}{#1}{\S }{I}}
\def\DR#1{\CODE{Dim'l Regu\-lar\-iza\-tion}{#1}{\S }{I}}
\def\DS#1{\CODE{Spin\-ors}{#1}{Chapter~}{I}}
\def\FE#1{\CODE{Home\-work}{#1}{Problem~FE}{I}}
\def\FP#1{\CODE{Home\-work}{#1}{Problem~FP}{I}}
\def\HLS#1{\CODE{Symme\-tries}{#1}{\S }{I}}
\def\IQFT#1{\CODE{Axiom\-atics}{#1}{Lecture~}{I}}
\def\IT#1{\CODE{Dirac Index}{#1}{Lecture~}{I}}
\def\KK#1{\CODE{Compact\-ifi\-ca\-tions}{#1}{Lecture~}{II}}
%\def\KQGT#1{\CODE{Kazhdan obsolete}{#1}{Lecture~}{I}}
\def\LSS#1{\CODE{Super\-sym\-metry}{#1}{Chapter~}{I}}
\def\NCFT#1{\CODE{Chiral Alge\-bras}{#1}{\S }{II}}
\def\PQFT#1{\CODE{Pertur\-ba\-tive QFT}{#1}{Lecture~}{I}}
\def\PST#1{\CODE{Strings}{#1}{Lecture~}{II}}
\def\QGT#1{\CODE{Faddeev}{#1}{Lecture~}{I}}
\def\RG#1{\CODE{Renorm Groups}{#1}{Lecture~}{I}}
\def\SCFT#1{\CODE{N=2 SUSY}{#1}{Lecture~}{II}}
\def\SH#1{\CODE{Home\-work}{#1}{Problem~SH}{I}}
\def\SM#1{\CODE{Signs}{#1}{\S }{I}}
\def\SQCD#1{\CODE{N=1 Dy\-nam\-ics}{#1}{Lecture~}{II}}
\def\SS#1{\CODE{Super\-solu\-tions}{#1}{Chapter~}{I}}

\makeatletter

%fix font size of author:

\renewcommand{\@auth}[2][default]{{\raggedleft
        \begingroup
  \fontsize{\@xivpt}{18}\bfseries%\centering
  #2\par \endgroup
        \vspace*{2pc}
        }
        \def\@author{#1}%
}

\renewcommand{\@sauth}[1]{{\raggedleft
        \begingroup
  \fontsize{\@xivpt}{18}\bfseries%\centering
  #1\par \endgroup
        \vspace*{2pc}
        }
        \def\@author{#1}%
}

%setup Notes at 8pt:

\newenvironment{Ntes}{\bigskip\noindent{\bfseries References
    and cross references}\unskip\par\penalty10000\vskip6pt
    \parskip0pt\parindent12pt\fontsize{8pt}{10}\selectfont\noindent}{} 

\def\Notes{\begin{Ntes}}
\def\endNotes{\end{Ntes}}

%add \S to \section

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
 \ifnum #2>\c@secnumdepth
   \let\@svsec\@empty
 \else
    \refstepcounter{#1}%
    \edef\@svsec{\ifnum#2<\@m
       \@ifundefined{#1name}{}{%
         \ignorespaces\csname #1name\endcsname\space}\fi
       \@nx\S\@nx\textup{%
         \csname the#1\endcsname.}\enspace
    }%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
    \begingroup #6\relax
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
    \endgroup
  \csname #1mark\endcsname{#7}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  \else
  \def\@svsechd{#6\hskip #3\@svsec
    \@ifnotempty{#8}{\ignorespaces#8\unskip
       \@addpunct.}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  }%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}}

%fix spacing after lecture

\def\@lecture[#1]#2{%
  \addtocounter{lecture}1\relax
  \refstepcounter{chapter}%
\gdef\thelecturename{#1\unskip}\firstlecturefalse
  {\Large\bfseries
   \raggedleft
   \@xp\uppercase\@xp{\thelecturelabel} {\LARGE\thelecturenum}\\
   \vspace*{3pt}%
    #2\unskip
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\lecturemark\@xp{\thelecturename}%
  \addcontentsline{toc}{chapter}{%
    \thelecturelabel\ \thelecturenum.\ #2}%
  \vspace{10\p@}\noindent}
  
\def\@slecture#1{%
\iffirstlecture
\gdef\thelecturename{#1\unskip}\firstlecturefalse
  {\Large\bfseries
\noindent\thelecturename
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\slecturemark\@xp{\thelecturename}%
  \addcontentsline{toc}{chapter}{%
    \thelecturename}%
 \vspace{-6\p@}\noindent
\else
\gdef\thelecturename{#1\unskip}\firstlecturefalse
  {\Large\bfseries
   \raggedleft
   \@xp\uppercase\@xp{\thelecturename}
   \endgraf}%
  \let\@secnumber=\thelecturenum
  \@xp\slecturemark\@xp{\thelecturename}%
  \addcontentsline{toc}{chapter}{%
    \thelecturename}%
  \vspace{10\p@}\noindent
\fi}

\makeatother

\makeatother
\endinput

