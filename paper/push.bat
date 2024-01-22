clear
pdflatex Main.tex
python Textomd.py
cd .
git add .
git commit -m"paper update"
git push