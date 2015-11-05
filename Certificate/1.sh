#!/bin/bash
  rm -rf "pdf/1/1.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat 1.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]} ${array[2]}/g ; s/xxKODExx/${array[0]}/g" 1.svg > "pdf/1/${array[0]}.svg"
	inkscape --export-pdf="pdf/1/${array[0]}.pdf" "pdf/1/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/1/${array[0]}.svg"
  done
  cd "pdf/1/"
  pdfunite *.pdf 1.pdf
  tar cvf 1.pdf.tar 1.pdf ; lzma 1.pdf.tar
  rm *.pdf
