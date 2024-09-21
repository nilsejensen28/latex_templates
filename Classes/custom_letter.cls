\ProvidesClass{custom_letter}[2024/09/01 Custom Letter Class]

\LoadClass[11pt,
	a4paper,
	letter,
	parskip=yes,
	priority=none,
	SN]{scrlttr2}

\RequirePackage{styling} %Load the custom styling

\RequirePackage[nswissgerman]{babel} %Todo: Add a language toggle
\RequirePackage{fix-cm}
\RequirePackage{graphicx}
\RequirePackage{csquotes}
\RequirePackage{hyperref}
\RequirePackage{geometry}
\RequirePackage{jsonreader}

%\hypersetup{pdfpagemode=None}
\KOMAoptions{
	paper=a4,
	pagenumber=botright,
	fromalign=right,
	fromrule=afteraddress,
	firstfoot=false,
	%        fromfax,
	fromlogo,
	%        fromurl,
	fromemail,
	backaddress,
	foldmarks,
	headsepline,
	%        footsepline,
	enlargefirstpage
}

\setkomavar{fromname}{\getconfigvalue{first_name} \getconfigvalue{last_name}}
\usekomavar[\def\fromname]{fromname}
\setkomavar{fromaddress}{\getconfigvalue{address_street} \getconfigvalue{address_number} \\ \getconfigvalue{address_zip} \getconfigvalue{address_city}}
\setkomavar{fromemail}{\getconfigvalue{email}}
\setkomavar{emailseparator}[E-Mail]{: }
%\setkomavar{fromurl}{\url{//www.example.com}}
%\setkomavar{urlseparator}[]{}
\setkomavar{place}{Zürich}

\setkomavar{fromlogo}{\parbox[b]{8cm}{\usekomafont{fromaddress}
		{\mbox{\LARGE \bfseries \getconfigvalue{first_name} \getconfigvalue{last_name}}}\\
		\smallskip}
}

%Fix Pagenumbering
\renewcommand{\pagemark}{{\usekomafont{pagenumber}{\thepage}}}

%\setkomafont{backaddress}{\sffamily}
\setkomafont{fromaddress}{\sffamily}
\setkomafont{fromname}{\sffamily}
\addtokomafont{fromname}{\scriptsize}
\addtokomafont{fromaddress}{\scriptsize}
\pagestyle{headings}

%Fix the signature alignement
\makeatletter
\renewcommand*{\raggedsignature}{\raggedright}
\makeatother

