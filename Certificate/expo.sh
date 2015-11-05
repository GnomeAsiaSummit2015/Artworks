#!/bin/bash
  rm -rf "pdf/expo/expo.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat expo.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]}/g ; s/xxKODExx/${array[0]}/g" expo.svg > "pdf/expo/${array[0]}.svg"
	inkscape --export-pdf="pdf/expo/${array[0]}.pdf" "pdf/expo/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/expo/${array[0]}.svg"
  done
  cd "pdf/expo/"
  pdfunite *.pdf expo.pdf
  tar cvf expo.pdf.tar expo.pdf ; lzma expo.pdf.tar
  rm *.pdf
