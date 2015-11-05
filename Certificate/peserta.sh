#!/bin/bash
  rm -rf "pdf/peserta/peserta.pdf.tar.lzma"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  sp="/-\|"
  i=1
  for file in $(cat peserta.csv)
  do
   data=${file%%}
	IFS=',' read -a array <<< "$data"
	sed "s/xxNAMAxx/${array[1]} ${array[2]}/g ; s/xxKODExx/${array[0]}/g" peserta.svg > "pdf/peserta/${array[0]}.svg"
	inkscape --export-pdf="pdf/peserta/${array[0]}.pdf" "pdf/peserta/${array[0]}.svg"
	jumlah=$((jumlah+1))
   printf "\b${sp:i++%${#sp}:1}"
	rm "pdf/peserta/${array[0]}.svg"
  done
  cd "pdf/peserta/"
  pdfunite *.pdf peserta.pdf
  tar cvf peserta.pdf.tar peserta.pdf ; lzma peserta.pdf.tar
  rm *.pdf
