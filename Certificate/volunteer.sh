#!/bin/bash
  rm -rf "pdf/volunteer/volunteer.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat volunteer.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]}/g ; s/xxKODExx/${array[0]}/g" volunteer.svg > "pdf/volunteer/${array[0]}.svg"
	inkscape --export-pdf="pdf/volunteer/${array[0]}.pdf" "pdf/volunteer/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/volunteer/${array[0]}.svg"
  done
  cd "pdf/volunteer/"
  pdfunite *.pdf volunteer.pdf
  tar cvf volunteer.pdf.tar volunteer.pdf ; lzma volunteer.pdf.tar
  rm *.pdf
