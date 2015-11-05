#!/bin/bash
  rm -rf "pdf/all.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat data.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]} ${array[2]}/g ; s/xxKODExx/${array[0]}/g" master.svg > "pdf/${array[0]}.svg"
	inkscape --export-pdf="pdf/${array[0]}.pdf" "pdf/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/${array[0]}.svg"
  done
  cd "pdf/"
  pdfunite *.pdf all.pdf
  tar cvf all.pdf.tar all.pdf ; lzma all.pdf.tar
  rm *.pdf
