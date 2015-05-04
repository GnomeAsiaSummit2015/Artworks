#!/bin/bash
  rm -rf "pdf/*"
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  for file in $(cat data.csv)
  do
   data=${file%%}
	#echo  "+$data"
		IFS=',' read -a array <<< "$data"
		
			cp "master.svg" "pdf/${array[0]}.svg"
			replace "&lt;&lt;NAME&gt;&gt;" "${array[1]} ${array[2]}" -- "pdf/${array[0]}.svg"
			replace "&lt;&lt;KODE&gt;&gt;" "${array[0]}" -- "pdf/${array[0]}.svg"
						
			inkscape --export-pdf="pdf/${array[0]}.pdf" "pdf/${array[0]}.svg"

			#echo "ID: ${array[0]}"
			#echo "First: ${array[1]}"
			#echo "Last: ${array[2]}"

  done
  cd "pdf/"
  rm *.svg
  pdfunite *.pdf all.pdf
  tar cvf all.pdf.tar all.pdf ; lzma all.pdf.tar
  rm *.pdf
