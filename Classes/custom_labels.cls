\ProvidesClass{custom_labels}[2024/09/01 Custom Labels Class]

\LoadClass[12pt, a4paper]{article}

%Global style settings
\RequirePackage{styling}

\RequirePackage[newdimens]{labels} %The labels package is used to create the labels
\RequirePackage{luacode}
\RequirePackage{luatexbase}

%Font setup (use bolder Fira Sans)
\setmainfont[
	Ligatures=TeX,
	% UprightFont = ,
	ItalicFont = Fira Sans Italic,
	% SmallCapsFont = ,
	BoldFont = Fira Sans Bold,
	BoldItalicFont = Fira Sans Bold Italic
]{Fira Sans}
\setsansfont[Ligatures=TeX]{Fira Sans}

%-----------------------------------------------------------------------------------------------------------
% Setup for the diffent label sizes
%-----------------------------------------------------------------------------------------------------------

\begin{luacode*}
    function setup_labels_from_dim(cols, rows, leftpagemargin, rightpagemargin, toppagemargin, bottompagemargin, interlabelcolumn, interlabelrow, leftlabelborder, rightlabelborder, toplabelborder, bottomlabelborder)
        tex.print("\\LabelRows=" .. rows)
        tex.print("\\LabelCols=" .. cols)
        tex.print("\\LeftPageMargin=" .. leftpagemargin)
        tex.print("\\RightPageMargin=" .. rightpagemargin)
        tex.print("\\TopPageMargin=" .. toppagemargin)
        tex.print("\\BottomPageMargin=" .. bottompagemargin)
        tex.print("\\InterLabelColumn=" .. interlabelcolumn)
        tex.print("\\InterLabelRow=" .. interlabelrow)
        tex.print("\\LeftLabelBorder=" .. leftlabelborder)
        tex.print("\\RightLabelBorder=" .. rightlabelborder)
        tex.print("\\TopLabelBorder=" .. toplabelborder)
        tex.print("\\BottomLabelBorder=" .. bottomlabelborder)
    end

    function setup_labels(labeltype)
        if labeltype == "hanging_folder" then
            setup_labels_from_dim(3, 13, "15mm", "15mm", "12mm", "12mm", "0mm", "0mm", "1mm", "1mm", "1mm", "1mm")
            tex.print("\\LabelGridtrue")
        elseif labeltype == "sticker" then
            setup_labels_from_dim(3, 8, "0mm", "0mm", "5mm", "4mm", "0mm", "0mm", "5mm", "5mm", "5mm", "5mm")
        else
            tex.print("Unknown label type: " .. labeltype)
        end
    end

    

\end{luacode*}

\newcommand{\setuplabels}[1]{\directlua{setup_labels([[#1]])}}

%-----------------------------------------------------------------------------------------------------------
% Custom label command
%-----------------------------------------------------------------------------------------------------------

\newcommand{\printlabel}[1]{\addresslabel{#1}}

\newcommand{\customlabel}[3]{\addresslabel{\centering{\large #1 -- #2}\vspace{2mm}\par{\textbf{\large #3}}}}

