-- Abbreviations used in LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
  -- Define article snippet for latex templates
  s({ trig = "article", desc = "latex template" }, {
    c(1, {
      sn(
        nil,
        fmta(
          [[
% initial settings
\documentclass[11pt]{article}
\usepackage{geometry}
\usepackage{graphicx}
\usepackage{enumitem}
\usepackage[usenames,dvipsnames]{xcolor}
\usepackage[backend=biber, style=alphabetic]{biblatex}
\usepackage{url,hyperref}

\usepackage{amsmath} % math symbols, matrices, cases, trig functions, var-greek symbols.
\usepackage{amsfonts} % mathbb, mathfrak, large sum and product symbols.
\usepackage{amssymb} % extended list of math symbols from AMS. https://ctan.math.washington.edu/tex-archive/fonts/amsfonts/doc/amssymb.pdf
\usepackage{amsthm} % theorem styling.
\usepackage{mathrsfs} % mathscr fonts.
\usepackage{yhmath} % widehat.
\usepackage{empheq} % emphasize equations, extending 'amsmath' and 'mathtools'.
\usepackage{bm} % simplified bold math. Do \bm{math-equations-here}

% geometry of paper
\geometry{
  a4paper, % 'a4paper', 'c5paper', 'letterpaper', 'legalpaper'
  asymmetric, % don't swap margins in left and right pages. as opposed to 'twoside'
  centering, % to center the content between margins
  bindingoffset=0cm,
}

% hyprlink settings
\hypersetup{
  colorlinks = true,
  linkcolor = {red!60!black},
  anchorcolor = red,
  citecolor = {green!50!black},
  urlcolor = magenta,
  }

% theorem styles
\theoremstyle{plain} % default; italic text, extra space above and below
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}{Proposition}[section]
\newtheorem{lemma}{Lemma}[section]
\newtheorem{corollary}{Corollary}[theorem]

\theoremstyle{definition} % upright text, extra space above and below
\newtheorem{definition}{Definition}[section]
\newtheorem{example}{Example}[section]

\theoremstyle{remark} % upright text, no extra space above or below
\newtheorem{remark}{Remark}[section]
\newtheorem*{note}{Note} %'Notes' in italics and without counter 

% renewcommands for counters
\newcommand{\propositionautorefname}{Proposition}
\newcommand{\definitionautorefname}{Definition}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\remarkautorefname}{Remark}
\newcommand{\exampleautorefname}{Example}

% For exercise and solutions
\newif\ifshowsolutions
\showsolutionstrue % Change to \showsolutionsfalse to hide solutions

% Custom environments for problems and solutions
\newcounter{exercise}[chapter]
\newenvironment{problem}[1][]
  {\par\noindent\textbf{#1.}}
  {\par}

\newenvironment{solution}
  {\ifshowsolutions \expandafter\solutioncontent \else \expandafter\comment \fi}
  {\ifshowsolutions \hfill \qedsymbol \else \expandafter\endcomment \fi \vspace{1em}}

\newenvironment{solutioncontent}
  {\par\noindent\textit{Solution.}}
  {\par}
\addbibresource{<>.bib}


\begin{document}

\title{<>}

% author list
\author{
<> \\
<> \\
<> \\
\and
Author 2 \\
This University, Country \\
author@emaildomain.com \\
}

\maketitle

\showsolutionstrue
%\showsolutionsfalse %To hide solutions

% abstract
\begin{abstract}
<>
\end{abstract}



\printbibliography[heading=bibintoc]
\end{document}
          ]],
          {
            i(1, "articles"),
            i(2, "Document Title"),
            i(3, "Joel Sleeba"),
            i(4, "University of Houston"),
            i(5, "XXXXX@gmail.com"),
            i(6),
          }
        )
      ),
    }),

    c(2, {
      sn(
        nil,
        fmta(
          [[
            \documentclass{<>}<>
            \begin{document}
              <>
            \end{document}
          ]],
          { i(1, "article"), i(2), i(3) }
        )
      ),
    }),
  }),

  -- Define presentation snippet for presentation templates
  s(
    { trig = "presentation", desc = "presentation template", trigEngine = "plain", wordTrig = false },
    fmta(
      [[
\documentclass[dvipsnames]{beamer}
\usetheme{default}

% Make content that is hidden by pauses "transparent"
\setbeamercovered{transparent}

% --- Slide layout settings ---
% Set line spacing
\renewcommand{\baselinestretch}{1.15}

% Set left and right text margins
\setbeamersize{text margin left=12mm, text margin right=12mm}

% Add slide numbers in bottom right corner
\setbeamertemplate{footline}[frame number]

% Remove navigation symbols
\setbeamertemplate{navigation symbols}{}

% Allow local line spacing changes
\usepackage{setspace}

% Change itemized list bullets to circles
\setbeamertemplate{itemize item}{$\bullet$}
\setbeamertemplate{itemize subitem}{$\circ$}

% --- Color and font settings ---

\usepackage{xcolor}

% Slide title background color
\definecolor{background}{HTML}{ede6d8}

% Slide title text color
\definecolor{titleText}{HTML}{B40404}

% Set colors
\setbeamercolor{frametitle}{bg=background, fg=titleText}
\setbeamercolor{subtitle}{fg=titleText}

% Set font sizes for frame title and subtitle
\setbeamerfont{frametitle}{size=\fontsize{15}{16}}
\setbeamerfont{framesubtitle}{size=\small}

% --- Math/Statistics commands ---

% Add a reference number to a single line of a multi-line equation
% Usage: "\numberthis\label{labelNameHere}" in an align or gather environment
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}

% \mathscr{(letter here)} is sometimes used to denote vector spaces
\usepackage[mathscr]{euscript}

% --- Title slide ---

\title{\color{titleText}<>}
\subtitle{\color{Blue}<>}
\author{Joel Sleeba\vspace{-.3cm}}
\date{\small <>}
\institute{<>}

\begin{document}

\begin{frame}
  \titlepage
\end{frame}

<>

\end{document}
    ]],
      { i(1, "Title"), i(2, "Subtitle"), i(3, "date"), i(4, "Institute"), i(0) }
    )
  ),

  -- Define book snippet for a book head file with chapters into different files
  s(
    {
      trig = "book",
      desc = "book template with chapters split to files in chapters/",
      trigEngine = "plain",
      wordTrig = true,
    },
    fmta(
      [[
\documentclass[12pt]{report}

\usepackage{geometry} % automatic papersizes, margins.
\usepackage{makeidx} % 'makeidx' make and show index
\usepackage{enumitem} % itemize, enumerate, description.
\usepackage{hyperref} % hyperlinks, cross-references.
\usepackage{xcolor} % foreground and background color management. Better color mixing compared to 'color'
\usepackage{graphicx} % provide options for \includegraphics. Builds on 'graphic'
\usepackage{caption} % better control over captions of figures and equations.
\usepackage{appendix} % extra control over appendix
\usepackage[backend=biber, style=alphabetic]{biblatex} % better than bibtex, people say.
\usepackage{tocbibind} % add ToC/Bibliography/Index to ToC

\usepackage{amsmath} % math symbols, matrices, cases, trig functions, var-greek symbols.
\usepackage{amsfonts} % mathbb, mathfrak, large sum and product symbols.
\usepackage{amssymb} % extended list of math symbols from AMS. https://ctan.math.washington.edu/tex-archive/fonts/amsfonts/doc/amssymb.pdf
\usepackage{amsthm} % theorem styling.
\usepackage{mathrsfs} % mathscr fonts.
\usepackage{yhmath} % widehat.
\usepackage{empheq} % emphasize equations, extending 'amsmath' and 'mathtools'.
\usepackage{bm} % simplified bold math. Do \bm{math-equations-here}
\usepackage{tikz} % for tikz diagrams
% \usepackage{tikz-cd} % commutative diagrams.
\usepackage{verbatim} % for concealing solutions

\geometry{
  a4paper, % 'a4paper', 'c5paper', 'letterpaper', 'legalpaper'
  asymmetric, % don't swap margins in left and right pages. as opposed to 'twoside'
  centering, % to center the content between margins
  bindingoffset=0cm,
}

\hypersetup{
    colorlinks,
    linkcolor={blue!50!black},
    citecolor={blue!50!black},
    urlcolor={blue!80!black}
}

\theoremstyle{plain} % default; italic text, extra space above and below
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}{Proposition}[section]
\newtheorem{lemma}{Lemma}[section]
\newtheorem{corollary}{Corollary}[theorem]
\newtheorem{problem}{Problem}[section]

\theoremstyle{definition} % upright text, extra space above and below
\newtheorem{definition}{Definition}[section]
\newtheorem{example}{Example}[section]

\theoremstyle{remark} % upright text, no extra space above or below
\newtheorem{remark}{Remark}[section]
\newtheorem*{note}{Note} %'Notes' in italics and without counter 

\newcommand{\propositionautorefname}{Proposition}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\corollaryautorefname}{Corollary}
\newcommand{\problemautorefname}{Problem}
\newcommand{\definitionautorefname}{Definition}
\newcommand{\exampleautorefname}{Example}
\newcommand{\remarkautorefname}{Remark}
\newcommand{\noteautorefname}{Note}

% For exercise and solutions
\newif\ifshowsolutions
\showsolutionstrue % Change to \showsolutionsfalse to hide solutions

% Custom environments for problems and solutions
\newcounter{exercise}[chapter]
\newenvironment{problem}[1][]
  {\par\noindent\textbf{#1.}}
  {\par}

\newenvironment{solution}
  {\ifshowsolutions \expandafter\solutioncontent \else \expandafter\comment \fi}
  {\ifshowsolutions \hfill \qedsymbol \else \expandafter\endcomment \fi \vspace{1em}}

\newenvironment{solutioncontent}
  {\par\noindent\textit{Solution.}}
  {\par}

\addbibresource{articles.bib}


\begin{document}
    \title{<>}

    \showsolutionstrue
    %\showsolutionsfalse %If need to hide solutions

    \author{
    	Joel Sleeba \\
    	% Cochin University of Science and Technology\\
    	joelsleeba1@gmail.com \\
    }

    \maketitle

    \pagenumbering{roman} \setcounter{page}{2}
    \tableofcontents
    \pagenumbering{arabic} \setcounter{page}{1}

    \include{chapters/<>.tex}


    \printbibliography[heading=bibintoc]

\end{document}

     ]],
      { i(1, "Document Title"), i(2, "Chapter 1 filename") }
    )
  ),

  -- Define chapter snippet for a chapter file of a document
  s(
    { trig = "chapter", desc = "chapter file template", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
      % TeX_root = ../<>.tex
      
      \chapter{<>}
      ]],
      { i(1, "main"), i(2, "Chapter Name") }
    )
  ),

  -- Define include snippet to include a file to a root file
  s(
    { trig = "include", desc = "include file", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \include{<>/<>.tex}
      ]],
      { i(1, "folder"), i(2, "file") }
    )
  ),
}
