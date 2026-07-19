%----------------------------------------------------
% Document Class (Simplified - English Only)
%----------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{masterproject-uc2-en}[2025/06/01 v2.0]
\LoadClass[a4paper,oneside,12pt,natbib,oldfontcommands]{memoir}

%----------------------------------------------------
% Constants
%----------------------------------------------------
\def\countryEn{People's Democratic Republic of Algeria} 
\def\ministryEn{Ministry of Higher Education and Scientific Research} 
\def\universityLongEn{University of Abdelhamid Mehri -- Constantine 2} 
\def\facultyLongEn{Faculty of New Technologies of Information and Communication (NTIC)} 
\def\memoirEn{Master's Thesis}
\def\obtainEn{\textit{to obtain the diploma of Master degree in Computer Science}}
\def\studentsEn{Realized by:}
\def\supervisorsEn{Under the supervision of:}

%-----------------------------------------------------
% Variables
%-----------------------------------------------------
\def\department#1{\gdef\department{#1}}
\def\specialty#1{\gdef\specialty{#1}}
\def\title#1{\gdef\title{#1}}
\def\studentFullnameA#1{\gdef\studentFullnameA{#1}}
\def\studentFullnameB#1{\gdef\studentFullnameB{#1}}
\def\supervisorFullnameA#1{\gdef\supervisorFullnameA{#1}}
\def\supervisorFullnameB#1{\gdef\supervisorFullnameB{#1}}
\def\session#1{\gdef\session{#1}}

%----------------------------------------------------
% Dependencies
%----------------------------------------------------
\RequirePackage{fontspec}

\RequirePackage{graphicx} 
\RequirePackage{amssymb,amsmath,amsfonts}
\RequirePackage{color}
\RequirePackage[table]{xcolor}
\RequirePackage{tabularx}
\RequirePackage{xifthen}
\RequirePackage{acronym}



% Margins
\RequirePackage{geometry}
\geometry{left=2.5cm,right=2cm,top=2.7cm,bottom=2.3cm}

% line spacing
\renewcommand{\baselinestretch}{1.3}
\setlength{\parindent}{1.5em}

%-----------------------------------------------------
% Font
%-----------------------------------------------------
\setmainfont{TeX Gyre Pagella}  % XeLaTeX equivalent of newpxtext

%-----------------------------------------------------
% Links
%-----------------------------------------------------
\RequirePackage{hyperref} 
\hypersetup{
	colorlinks=true,
	linkcolor=black,
	filecolor=black,      
	urlcolor=black,
	citecolor=black,
}
\RequirePackage{url} 

%-----------------------------------------------------
% Sections
%-----------------------------------------------------
\setsecnumdepth{subsubsection}

%-----------------------------------------------------
% Itemize and enumerate 
%-----------------------------------------------------
\RequirePackage{enumitem}
\setlist[itemize,1]{itemsep=2pt,parsep=0pt,topsep=3pt,label={\color{primary}\small\raisebox{2pt}{$\blacktriangleright$}}}
\setlist[itemize,2]{itemsep=2pt,parsep=0pt,topsep=3pt,label={\color{primary}\tiny\raisebox{.9pt}{$\blacksquare$}}}
\setlist[itemize,3]{itemsep=2pt,parsep=0pt,topsep=3pt,label={\color{primary}\raisebox{0.5pt}{$\bullet$}}}
\setlist[enumerate,1]{itemsep=2pt,parsep=0pt,topsep=3pt,label=\color{primaryDark}\theenumi.}
\setlist[enumerate,2]{itemsep=2pt,parsep=0pt,topsep=3pt,label=\color{primaryDark}\alph*)}
\setlist[enumerate,3]{itemsep=2pt,parsep=0pt,topsep=3pt,label=\color{primaryDark}\roman*.}

%-----------------------------------------------------
% Colors
%-----------------------------------------------------
\definecolor{primary}{HTML}{0556A3}
\definecolor{primaryLight}{HTML}{A3C1DE}
\definecolor{primaryDark}{HTML}{033666}

%------------------------------------------------------
% Tables
%------------------------------------------------------
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{etoolbox}

\let\oldtabular\tabular
\let\endoldtabular\endtabular
\renewenvironment{tabular}{
	\rowcolors{1}{\ifnumequal{\rownum}{1}{primary}{white}}{primary!10}
	\oldtabular
}{
	\endoldtabular
}

\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}\ifnumequal{\rownum}{1}{\bfseries\color{white}}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}\ifnumequal{\rownum}{1}{\bfseries\color{white}}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}\ifnumequal{\rownum}{1}{\bfseries\color{white}}}m{#1}}
\newcolumntype{Y}{>{\raggedright\arraybackslash}X}

\setlength\extrarowheight{3pt}
\RequirePackage{multicol}
\setlength{\columnsep}{1cm}

%-------------------------------------------------------
% Algorithms
%-------------------------------------------------------
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\counterwithin{algorithm}{chapter}
\renewcommand{\ALG@name}{Algorithm}
\renewcommand{\thealgorithm}{\thechapter.\arabic{algorithm}}
\RequirePackage{xpatch}
\xpretocmd{\algorithmic}{\let\AND\relax\let\OR\relax\let\NOT\relax}{}{}

%-------------------------------------------------------
% Theorems
%-------------------------------------------------------
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{definition}{Definition}[chapter]
\newtheorem{remark}{Remark}[chapter]

%-------------------------------------------------------
% Source codes
%-------------------------------------------------------
\RequirePackage{listings}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

\lstset{
	showspaces=false,
	showtabs=false,
	breaklines=true,
	showstringspaces=false,
	breakatwhitespace=true,
	basicstyle=\linespread{1.1}\ttfamily\small,
	tabsize=3,
	numbers=left,
	numberstyle=\bf\footnotesize\sffamily\color{white},
	numbersep=10.5pt, 
	stepnumber=1,
	backgroundcolor=\color{primary!10},
	xleftmargin=.8cm,
}

%--------------------------------------------------------
% Header and footer
%--------------------------------------------------------
\RequirePackage{fancyhdr}

\def\chaptermark#1{\def\chaptertitle{#1}}

\fancypagestyle{plain}{
	\fancyhead[L]{}
	\fancyhead[R]{}
	\fancyfoot[C]{}
	\fancyfoot[R]{\thepage}
	\renewcommand{\headrulewidth}{0pt}
}

\pagestyle{fancy}
\fancyhead[L]{
	\it
	\if@mainmatter
		\ifnum\value{chapter}>0 
			\chaptertitle
		\else 
			General Introduction
		\fi
	\fi
}
\fancyhead[C]{}
\fancyhead[R]{}
\renewcommand{\headrulewidth}{1pt}
\fancyfoot[L]{}
\fancyfoot[C]{}
\fancyfoot[R]{\thepage}

%-------------------------------------------------------
% Title page
%-------------------------------------------------------
\newcommand{\maketitlepage}{
	\begin{titlingpage}
		\centering
		{\small\bfseries\countryEn}\\
		{\small\bfseries\ministryEn}\\
		\vspace*{.5cm}
		\includegraphics[width=1.8cm]{assets/uni-logo-uc2-dark} \hspace{1.2cm}
		\includegraphics[width=1.8cm]{assets/uni-logo-ntic} \hspace{1.2cm}
		\includegraphics[width=1.8cm]{assets/uni-logo-incubator}\\
		\vspace*{.3cm}
		\Large
		\textsc{\color{primaryDark}\bfseries\universityLongEn}\\
		\vspace*{.2cm}
		\normalsize
		{\bfseries\facultyLongEn}\\
		\vspace*{.2cm}
		{\normalsize\bfseries\department}\\
		\vspace{1.6cm}
		{\Huge\bfseries\MakeUppercase\memoirEn}\\
		\vspace{1.3cm}
		{\normalfont\obtainEn}\\
		\vspace{.3cm}
		{\bfseries\large \specialty}\\
		\vspace{1.5cm}
		--------------------------------\\
		\vspace{.8cm}
		{\LARGE\bfseries\title}\\	
		\vspace{.8cm}	
		--------------------------------\\
		\vspace{2cm}
		\normalsize
		\begin{tabular}{L{7.5cm}R{7.5cm}}
			\rowcolor{white}
			\color{black}\textbf{\studentsEn} & \color{black}\textbf{\supervisorsEn}\\
			\rowcolor{white}
			\studentFullnameA & \supervisorFullnameA\\
			\studentFullnameB & \supervisorFullnameB\\
		\end{tabular}	
		\vfill
		\normalsize\session
	\end{titlingpage}
	\clearpage
}

%-------------------------------------------------------
% Abstract (English only)
%-------------------------------------------------------
\RequirePackage{scrextend}

\newenvironment{abstractEn}{
	\begin{addmargin}[1cm]{1cm}
		\vskip .35cm
		\begin{center}
			\textbf{Abstract}
		\end{center}
		\vspace*{-.6cm}
		\begin{flushleft}
}{
		\end{flushleft}
	\end{addmargin}
}

\newenvironment{abstractAr}{
	\begin{addmargin}[1cm]{1cm}
		\vskip .35cm
		\begin{center}
			\textarabic{\textbf{ملخص}}
		\end{center}
		\vspace*{-.6cm}
		\begin{Arabic}
		\begin{flushleft}
}{
		\end{flushleft}
		\end{Arabic}
	\end{addmargin}
}

\newenvironment{keywordsAr}{
	\vspace*{-.2cm}
	\begin{addmargin}[1cm]{1cm}
	\begin{Arabic}
	\begin{flushleft}
		\textarabic{\textbf{الكلمات المفتاحية:}}
}{
	\end{flushleft}
	\end{Arabic}
	\end{addmargin}
}

\newenvironment{keywordsEn}{
	\vspace*{-.2cm}
	\begin{addmargin}[1cm]{1cm}
\t\begin{flushleft}
\t\t\textbf{Keywords:}
}{
	\end{flushleft}
	\end{addmargin}
}

%-------------------------------------------------------
% Table of contents
%-------------------------------------------------------
\makeatletter
\renewcommand\tableofcontents{
	\chapter*{Table of Contents}
	\addcontentsline{toc}{chapter}{Table of Contents}
	\@starttoc{toc}
}
\makeatother
\setcounter{tocdepth}{2}

\makeatletter
\g@addto@macro\tableofcontents{\clearpage}
\g@addto@macro\listoffigures{\clearpage}
\g@addto@macro\listoftables{\clearpage}
\makeatother

%-------------------------------------------------------
% Chapter style
%-------------------------------------------------------
\RequirePackage{calc}
\newsavebox{\ChpNumBox}

\makeatletter
\newcommand*{\thickhrulefill}{\leavevmode\leaders\hrule height 1\p@ \hfill \kern
 \z@}

\newcommand*\BuildChpNum[2]{
	\begin{tabular}[t]{@{}c@{}}
		\rowcolor{white}
		\makebox[0pt][c]{#1\strut} \\[.5ex]
		\rowcolor{white}
		\colorbox{primary}{
			\rule[-8em]{0pt}{0pt}%
			\rule{1.3ex}{0pt}
			\rule[2.2em]{0pt}{0pt}%
			\color{white}#2\strut
			\rule{.33ex}{0pt}
		}
	\end{tabular}
}

\makechapterstyle{BlueBox}{%
	\renewcommand{\chapnamefont}{\large\scshape}
	\renewcommand{\chapnumfont}{\Huge\bfseries}
	\renewcommand{\chaptitlefont}{\raggedright\huge\bfseries}
	\setlength{\beforechapskip}{10pt}
	\setlength{\midchapskip}{26pt}
	\setlength{\afterchapskip}{30pt}
	\renewcommand{\printchaptername}{}
	\renewcommand{\chapternamenum}{}
	\renewcommand{\printchapternum}{%
		\sbox{\ChpNumBox}{\BuildChpNum{\chapnamefont\@chapapp}{\chapnumfont\thechapter}}
	}
	\renewcommand{\printchapternonum}{%
		\sbox{\ChpNumBox}{\BuildChpNum{\chapnamefont\vphantom{\@chapapp}}{\chapnumfont\hphantom{\thechapter}}}
	}
	\renewcommand{\afterchapternum}{}
	\renewcommand{\printchaptertitle}[1]{%
		\parbox[t]{\hsize-\wd\ChpNumBox-.7em}{%
			\vspace{\midchapskip}%
			\thickhrulefill\par
			\chaptitlefont 
			\raggedleft ##1\par
		}
		\hfill
		\usebox{\ChpNumBox}
		\hspace*{-.4cm}
	}%
}
\chapterstyle{BlueBox}
\makeatother

%-------------------------------------------------------
% Bibliography
%-------------------------------------------------------
\RequirePackage[numbers,square,sort]{natbib}

%-------------------------------------------------------
% Packages that users commonly load in preamble
% (moved here so they load BEFORE polyglossia/bidi)
%-------------------------------------------------------
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{float}

%-------------------------------------------------------
% Polyglossia + Arabic (MUST be last — bidi requirement)
%-------------------------------------------------------
\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\setotherlanguage{arabic}
\newfontfamily\arabicfont[Script=Arabic, Scale=1.1]{Amiri}