#!/bin/bash
  rm -rf "pdf/pembicara/pembicara/pembicara.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat pembicara.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]}/g ; s/xxKODExx/${array[0]}/g" pembicara.svg > "pdf/pembicara/${array[0]}.svg"
	inkscape --export-pdf="pdf/pembicara/${array[0]}.pdf" "pdf/pembicara/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/pembicara/${array[0]}.svg"
  done
  cd "pdf/pembicara/"
  pdfunite *.pdf pembicara.pdf
  tar cvf pembicara.pdf.tar pembicara.pdf ; lzma pembicara.pdf.tar
  rm *.pdf
