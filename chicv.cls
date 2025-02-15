\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chicv}[2022/08/21 A CV template based on the Curriculum Vitae of Alex Chi Zhang]
\LoadClass[10pt]{article} % based on article class

%
\RequirePackage[
    a4paper,
    left=0.8in,
    right=0.8in,
    top=0.5in,
    bottom=0.5in,
    nohead
]{geometry}

\RequirePackage{fancyhdr}

% For font setting
\RequirePackage[T1]{fontenc}
\RequirePackage{fontspec}
\RequirePackage{titlesec}
% For color
\RequirePackage{xcolor}

% For smarter command definition
\RequirePackage{xifthen}
\RequirePackage{xparse}

% For hyperlink customization
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{fontawesome5} % icons

% For list environment customizations
\RequirePackage{enumitem}

%% ----------------- END OF PACKAGES ----------------- %%

% Footer
%%% Only add "updated" footer to last page
\pagestyle{fancy}
\fancypagestyle{default}{
    \fancyhf{}
    \RenewDocumentCommand{\headrulewidth}{}{0pt}
}
\fancypagestyle{lastpage}{
    \fancyhf{}
    \RenewDocumentCommand{\headrulewidth}{}{0pt}
    \rfoot{\color{gray}Updated on \today}
}

% Spacings
\setlength{\footskip}{4pt}
\setlength{\parindent}{0pt}
\setlist[itemize]{
    leftmargin=36pt,
    itemsep=-\parsep,
    topsep=-\partopsep-\parskip,
}

% Font size macros
\newcommand{\HUGE}{\@setfontsize\HUGE{24pt}{18}}
\renewcommand\Huge{\@setfontsize\Huge{22pt}{18}}
\renewcommand\huge{\@setfontsize\huge{20pt}{18}}
\renewcommand\LARGE{\@setfontsize\LARGE{18pt}{18}}
\renewcommand\Large{\@setfontsize\Large{12pt}{18}}
\renewcommand\large{\@setfontsize\large{11pt}{18}}

% mainfont: XCharter
\IfFontExistsTF{XCharter}{
    \setmainfont{XCharter}
}{
    \setmainfont{XCharter}[ % in case XCharter is not installed
        Path = ./fonts/,
        Extension = .otf,
        BoldFont = XCharter-Bold,
        ItalicFont = XCharter-Italic,
        BoldItalicFont = XCharter-BoldItalic,
        BoldSlantedFont = XCharter-BoldSlanted,
        SlantedFont = XCharter-Slanted,
        RomanFont = XCharter-Roman,
    ]
}

% heading font: Avenir Next
\IfFontExistsTF{Avenir Next LT Pro}{
    \newfontfamily{\headingfont}{Avenir Next LT Pro}
}{
    \IfFontExistsTF{Avenir Next}{
        \newfontfamily{\headingfont}{Avenir Next}
    }{
        % use local font in ./fonts folder
        \newfontfamily{\headingfont}{AvenirNextLTPro}[
            Path = ./fonts/,
            Extension = .otf,
            UprightFont = *-Regular,
            BoldFont = *-Bold,
            ItalicFont = *-Italic,
        ]
    }
}

% format for section title
\titleformat{\section}
    {\headingfont\Large}                % shape
    {}                                  % format
    {0em}                               % label
    {\vspace{-2ex}{\color{gray}\hrule}}  % before-code
    []                                  % after-code
\titlespacing{\section}
    {0pt} % left spacing
    {0pt} % before spacing
    {0pt} % after spacing

% format for subseciton title
\titleformat{\subsection}
    {\large} % shape
    {} % format
    {0em} % label
    {} % beforcode
    [] % aftercode
\titlespacing{\subsection}
    {12pt} % left spacing
    {\parskip} % before spacing
    {\parskip} % after spacing

\NewDocumentCommand{\cventry}{ m m o o }
{
    \subsection[#1]{\textbf{#1} \hfill #2}
    \IfNoValueTF{#3}
    {}
    {{\parindent=12pt\par #3 \hfill #4 \par}}
}


\NewDocumentCommand{\name}{ m }
{{\headingfont\Huge#1}}


\NewDocumentEnvironment{compactlist}{}
{
    \begin{itemize}[
        label={},
        leftmargin=12pt,
        itemsep=-\parsep,
        topsep=0pt-\partopsep-\parskip,
    ]
}
{
    \end{itemize}
}

\newcounter{infonum}
\NewDocumentCommand{\infomark}{}{}

\NewDocumentEnvironment{basicinfo}{ o }
{%
    \par\vspace{1ex}
    \setcounter{infonum}{0}
    \IfValueTF{#1}{
        \RenewDocumentCommand{\infomark}{}{#1}
    }
    {
    }
}
{%
}

\NewDocumentCommand{\info}{ m }{
    \stepcounter{infonum}
    \ifthenelse{\theinfonum = 1}{
        #1
    }{
        $\mid$ #1
    }
}

% defines one's email
% usage: \email{<email>}
\NewDocumentCommand{\email}{ m }{
    \faEnvelope\ \underline{\href{mailto:#1}{#1}}\hspace{-14pt}
}

% defines one's phone
% usage: \phone{<phone>}
\NewDocumentCommand{\phone}{ m }{
    \faPhone\ {#1}\hspace{-14pt}
}

% defines one's linkedin
% usage: \linkedin{<linkedin>}
\NewDocumentCommand{\linkedin}{ m o }{
    \faLinkedinIn\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }
    \hspace{-20pt}
}

\NewDocumentCommand{\linkedinsquare}{ m o }{
    \faLinkedin\IfNoValueTF{#1}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }
    \hspace{-20pt}
}

% defines one's GitHub
% usage: \github{<github>}
\NewDocumentCommand{\github}{ m o }{
    \faGithub\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }
    \hspace{-20pt}
}

% defines one's homepage
% usage: \homepage{<homepage>}
\NewDocumentCommand{\homepage}{ m o }{
    \faGlobe\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }
    \hspace{-20pt}
}

% defines one's GoogleScholar
% usage: \googlescholar{<homepage>}
\NewDocumentCommand{\googlescholar}{ m o }{
    \faGraduationCap\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }
    \hspace{-20pt}
}

% Customize icon link
% usage: \iconlink[<icon:fontawesome>][<text>]{<url>}
\NewDocumentCommand{\iconlink}{ o o m }{
    \IfNoValueTF{#1}{
        \let\icon\faLink
    }{
        \let\icon#1
    }
    \IfNoValueTF{#2}{
        \hspace{-12pt}\underline{\href{#3}{\icon}}
    }{
        \hspace{-12pt}\underline{\href{#3}{\icon\ #2}}
    }
    \hspace{-8pt}
}

% Set up pagestyle
\pagestyle{default}
\AtEndDocument{\thispagestyle{lastpage}}
