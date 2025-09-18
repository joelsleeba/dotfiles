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
  -- Define article snippet for article template
  s({ trig = "article", desc = "article template" }, {
    c(1, {
      sn(
        nil,
        fmta(
          [[
% initial settings
\documentclass[11pt]{article}
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
\usepackage{tikz-cd} % commutative diagrams.
\usepackage{marginnote} % For sidenotes

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
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{problem}[theorem]{Problem}

\theoremstyle{definition} % upright text, extra space above and below
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{exercise}[theorem]{Exercise}
\newtheorem{question}[theorem]{Question}

\theoremstyle{remark} % upright text, no extra space above or below
\newtheorem{remark}[theorem]{Remark}
\newtheorem{answer}[theorem]{Answer}
\newtheorem*{note}{Note} %'Notes' in italics and without counter

\newcommand{\propositionautorefname}{Proposition}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\corollaryautorefname}{Corollary}
\newcommand{\problemautorefname}{Problem}
\newcommand{\definitionautorefname}{Definition}
\newcommand{\exampleautorefname}{Example}
\newcommand{\exerciseautorefname}{Exercise}
\newcommand{\questionautorefname}{Question}
\newcommand{\remarkautorefname}{Remark}
\newcommand{\answerautorefname}{Answer}
\newcommand{\noteautorefname}{Note}

\addbibresource{<>}


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


% abstract
\begin{abstract}
<>
\end{abstract}



\printbibliography[heading=bibintoc]
\end{document}
          ]],
          {
            i(1, "~/Books/Research/research.bib"),
            i(2, "Document Title"),
            i(3, "Joel Sleeba"),
            i(4, "University of Houston"),
            i(5, "XXXXX@gmail.com"),
            i(6),
          }
        )
      ),
      sn(
        nil,
        fmta(
          [[
          \documentclass{article}
          \begin{document}
            <>
          \end{document}
          ]],
          { i(1) }
        )
      ),
    }),
  }),

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
\usepackage{tikz-cd} % commutative diagrams.
\usepackage{marginnote} % For sidenotes

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

% theorem styles
\theoremstyle{plain} % default; italic text, extra space above and below
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{problem}[theorem]{Problem}

\theoremstyle{definition} % upright text, extra space above and below
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{exercise}[theorem]{Exercise}
\newtheorem{question}[theorem]{Question}

\theoremstyle{remark} % upright text, no extra space above or below
\newtheorem{remark}[theorem]{Remark}
\newtheorem{answer}[theorem]{Answer}
\newtheorem*{note}{Note} %'Notes' in italics and without counter

\newcommand{\propositionautorefname}{Proposition}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\corollaryautorefname}{Corollary}
\newcommand{\problemautorefname}{Problem}
\newcommand{\definitionautorefname}{Definition}
\newcommand{\exampleautorefname}{Example}
\newcommand{\exerciseautorefname}{Exercise}
\newcommand{\questionautorefname}{Question}
\newcommand{\remarkautorefname}{Remark}
\newcommand{\answerautorefname}{Answer}
\newcommand{\noteautorefname}{Note}


\addbibresource{<>}


\begin{document}
    \title{<>}

    \author{
    	Joel Sleeba \\
      University of Houston
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
      { i(1, "~/Books/Research/research.bib"), i(2, "Document Title"), i(3, "Chapter 1 filename") }
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

  -- Define exam snippet for exam sheets and answers
  s(
    { trig = "exam", desc = "exam sheets and answers", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
% initial settings
\documentclass[12pt]{exam}
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
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{problem}[theorem]{Problem}

\theoremstyle{definition} % upright text, extra space above and below
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{exercise}[theorem]{Exercise}
\newtheorem{question}[theorem]{Question}

\theoremstyle{remark} % upright text, no extra space above or below
\newtheorem{remark}[theorem]{Remark}
\newtheorem{answer}[theorem]{Answer}
\newtheorem*{note}{Note} %'Notes' in italics and without counter

\newcommand{\propositionautorefname}{Proposition}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\corollaryautorefname}{Corollary}
\newcommand{\problemautorefname}{Problem}
\newcommand{\definitionautorefname}{Definition}
\newcommand{\exampleautorefname}{Example}
\newcommand{\exerciseautorefname}{Exercise}
\newcommand{\questionautorefname}{Question}
\newcommand{\remarkautorefname}{Remark}
\newcommand{\answerautorefname}{Answer}
\newcommand{\noteautorefname}{Note}


\addbibresource{~/Books/Research/research.bib}


\begin{document}

\title{<> \\ <>}

% author list
\author{
Joel Sleeba \\
}

\maketitle
\printanswers
\unframedsolutions

\begin{questions}
  
  <>


\end{questions}
\printbibliography[heading=bibintoc]
\end{document}
      ]],
      { i(1, "Course"), i(2, "Homework  I"), i(3) }
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

  -- Define lecture snippet for a lecture file
  s(
    { trig = "lecture", desc = "lecture file", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
      % TeX_root = ../<>.tex

      \marginnote{\scriptsize <> }

      ]],
      { i(1, "main"), f(function(_, snip)
        return os.date("%d/%m/%Y")
      end) }
    )
  ),

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
}
