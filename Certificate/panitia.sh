#!/bin/bash
  rm -rf "pdf/panitia/panitia.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat panitia.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]}/g ; s/xxKODExx/${array[0]}/g" panitia.svg > "pdf/panitia/${array[0]}.svg"
	inkscape --export-pdf="pdf/panitia/${array[0]}.pdf" "pdf/panitia/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/panitia/${array[0]}.svg"
  done
  cd "pdf/panitia/"
  pdfunite *.pdf panitia.pdf
  tar cvf panitia.pdf.tar panitia.pdf ; lzma panitia.pdf.tar
  rm *.pdf
