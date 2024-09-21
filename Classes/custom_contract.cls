\ProvidesClass{custom_contract}[2024/09/01 Custom Contract Class]

\LoadClass[11pt, parskip=half]{scrreprt}

%Global style settings
\RequirePackage{styling}

\RequirePackage{lmodern}
\RequirePackage[juratotoc]{scrjura}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{xparse}
\RequirePackage{luacode}
\RequirePackage{luatexbase}

%Custom paragraph formatting
\makeatletter
\renewcommand*{\parformat}{% 
	\global\hangindent 2em
	\makebox[2em][l]{(\thepar)\hfill}\hspace{-0,3cm}
}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Custom Setup for the parties                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{luacode*}
    -- Global table to store contract parties
    contract_parties = {}

    -- Function to add a contract party to the list
    function add_contract_party(data)
        -- Split the data by comma
        local parts = {}
        for part in string.gmatch(data, "([^,]+)") do
            table.insert(parts, part:match("^%s*(.-)%s*$"))  -- Trim whitespace
        end

        -- Now parts[1] to parts[10] hold your ten arguments
        local first_name = parts[1]
        local last_name = parts[2]
        local birthdate = parts[3]
        local birthplace = parts[4]
        local address_street = parts[5]
        local address_number = parts[6]
        local address_zip = parts[7]
        local address_city = parts[8]
        local address_country = parts[9]

        -- Your existing logic for adding the contract party
        local party = {
            first_name = first_name,
            last_name = last_name,
            birthdate = birthdate,
            birthplace = birthplace,
            address_street = address_street,
            address_number = address_number,
            address_zip = address_zip,
            address_city = address_city,
            address_country = address_country,
            short_name = parts[10]
        }
        table.insert(contract_parties, party)
    end

    -- Function to format and print contract parties at the beginning of the document
    function format_parties_header()
        if #contract_parties == 0 then
            tex.print("No contract parties found.")
        else
            tex.print("\\begin{tabular}{p{15cm}p{.5cm}l}")
            tex.print{"Zwischen den Vertragsparteien:\\\\ \\medskip"}
            for i, party in ipairs(contract_parties) do
                tex.print("\\textbf{" .. party.first_name .. " " .. party.last_name .. "}, geboren in " .. party.birthplace .. " am " .. party.birthdate .. "\\par")
                tex.print("Wohnhaft in " .. party.address_street .. " " .. party.address_number .. ", " .. party.address_zip .. " " .. party.address_city .. ", " .. party.address_country .. "\\par")
                tex.print("\\medskip \\hfill \\textit{- nachfolgend ''" .. party.short_name .. "'' genannt -}\\\\")
                if i < #contract_parties then
                    tex.print("\\bigskip und\\\\")
                    tex.print("\\medskip")
                end
            end
            tex.print("\\end{tabular}")
        end
    end

    -- Function to print signature lines for all contract parties
    function print_signature_lines()
        if #contract_parties == 0 then
            tex.print("No contract parties available for signature.")
        else
            for i, party in ipairs(contract_parties) do
                tex.print("\\begin{minipage}{10cm}")
                tex.print("\\vspace{2cm}")
                 -- Print a 10 cm long line for the signature
                
                tex.print("\\par \\rule{10cm}{0.4pt} \\par")
            
                -- Print the name aligned left and place/date aligned right
                tex.print("\\textbf{" .. party.first_name .. " " .. party.last_name .. "} \\hfill " ..
                      ("\\textbf{Ort}") .. ", " ..
                      ("\\textbf{Datum}") .. "\\par")
                tex.print("\\end{minipage}")
                tex.print("\\par")
            end
        end
    end
\end{luacode*}

% Define command to add a new contract party using Lua
\NewDocumentCommand{\newcontractparty}{m}{
    \directlua{add_contract_party([[#1]])}
}

% Define a command to output all contract parties at the start
\newcommand{\printcontractparties}{
    \directlua{format_parties_header()}
}

% Define a command to output signature lines at the end
\newcommand{\printsignaturelines}{
    \directlua{print_signature_lines()}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Custom Setup for the articles, paragraphs, ect.           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{art}
\setcounter{art}{1}

\newenvironment{article}[1]{\textbf{Art. \theart: #1 } \addtocounter{art}{1} \par}{\par\vspace{5mm}}

%
\newlist{paragraphs}{enumerate}{1}
\newlist{letters}{enumerate}{1}
\setlist[paragraphs, 1]{
    label        = {\textsuperscript{\arabic*}},
    ref          = {Abs.\ \arabic*},
    align        = left,
    leftmargin   = 0em,   % Make sure text flows all the way to the left page margin.
    labelindent  = 0em,   % Make sure the labels are all the way on the left page margin.
    labelsep     = 0.5ex, % Label separation of about a space.
    labelwidth   = 1ex,   % For some reason this needs to be fixed for this to work. Makes no sense, but it works.
    itemindent   = !,     % Calculate the indent of the first line of text based on the values above.
    before*      = \nopagebreak,
    first*       = \nopagebreak,
    beginpenalty = 100000,
    midpenalty   = 1000,
    noitemsep,
    nosep
}

\endinput
