# upLaTeX + upBibTeX + dvipdfmx の設定
$latex    = 'uplatex -synctex=1 %O %S';
$bibtex = 'bibtexu %O %B';
$dvipdf   = 'dvipdfmx %O -o %D %S';
$makeindex = 'upmendex %O -o %D %S';
$max_repeat = 10;

# 出力形式を DVI -> PDF (dvipdfmx) に設定
$pdf_mode = 3;

$pdf_previewer = 'open -a Skim %O %S';
