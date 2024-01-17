# This script should download the file specified in the first argument ($1),
# place it in the directory specified in the second argument ($2),
# and *optionally*:
# - uncompress the downloaded file with gunzip if the third
#   argument ($3) contains the word "yes"
# - filter the sequences based on a word contained in their header lines:
#   sequences containing the specified word in their header should be **excluded**
#
# Example of the desired filtering:
#
#   > this is my sequence
#   CACTATGGGAGGACATTATAC
#   > this is my second sequence
#   CACTATGGGAGGGAGAGGAGA
#   > this is another sequence
#   CCAGGATTTACAGACTTTAAA
#
#   If $4 == "another" only the **first two sequence** should be output

#carpeta vacía?
if ['$#' -lt 2]; then
	echo 'Usage: $0 <url> <output_directory> [y/n] [filtered_keyword]'
	exit 1
fi

#Variables
url = '$1'
output_directory ='$2'
filtered_key = '$3'
uncompress = '$4'

#Crear output_directory. SOLO si no exixte (-p)
mkdir -p '$2'

#Descargar el fichero
wget -o '$2/$(basename '$1')' '$1'

#Descomprimir el fichero
if ['$4' == 'y'];then
	gunzip '$2/$(basename '$1')'
fi

#Filtrar secuencia
if [-n '$3'];then
	grep -v '$3' '$2/$3(basename '$1')' > '$2/filtered_$(basename '$1')'
fi
