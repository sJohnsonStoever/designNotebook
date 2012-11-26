#!/bin/sh

# Configuration options
dnbpath="." #This should be changed if calling this script from outside its parent dir.
outputpath="output"
mdparser="multimarkdown"

cd $dnbpath

# HTML ouputting functions
openDiv () {
    if [ $# = "0" ]; then
	echo '<div>'
    else 
	echo "<div id=\""$1"\">"
    fi
}
endDiv () {
    echo '</div>'
}
gethead1 () {
    $mdparser site/head1.md | sed 's/<p>//g' | sed 's/<\/p>//g'
}
gethead2 () {
    $mdparser site/head2.md | sed 's/<p>//g' | sed 's/<\/p>//g'
}
newline () {
    echo ' '
}
printCredit () {
    openDiv credit
    $mdparser site/credit.md | sed 's/<p>//g' | sed 's/<\/p>//g'
    endDiv
}
printEntry () {
	entryfile=$1
	# Open Entry ID Number
	openDiv $(echo $entryfile | cut -d/ -f 2 | cut -d. -f 1)
	# Open topper
	openDiv topper
	sed -n '2p' $entryfile | sed 's/NBTopper://g' | $mdparser | sed 's/<p>//g' | sed 's/<\/p>//g'
	# Close topper
	endDiv
	echo '<h2>'
	sed -n '1p' $entryfile | sed 's/Title://g' | $mdparser | sed 's/<p>//g' | sed 's/<\/p>//g'
	echo '</h2>'
	# Open entry
	echo "<div class=\"entry\">"
	tail -n+6 $entryfile | $mdparser
	# Close entry
	endDiv
	# Open postinfo
	openDiv postinfo
	dateInfo=$(sed -n '3p' $entryfile | sed 's/Date://g' | $mdparser | sed 's/<p>//g' | sed 's/<\/p>//g')
	tagsInfo=$(sed -n '4p' $entryfile | sed 's/Tags://g' | $mdparser | sed 's/<p>//g' | sed 's/<\/p>//g')
	echo "Posted on: "$dateInfo" | Tagged with: "$tagsInfo
	# Close postinfo
	endDiv
	# Close Entry ID Number
	endDiv
}
printEntryLink () {
	entryfile=$1
	echo "<li><a href=\"#"$(echo $entryfile | cut -d/ -f 2 | cut -d. -f 1)"\">"
	sed -n '1p' $entryfile | sed 's/Title://g' | $mdparser | sed 's/<p>//g' | sed 's/<\/p>//g'
	echo "</a></li>"
}
#HTML Sections
printHead () {
    echo '<!DOCTYPE html>'
    echo '<html>'
    echo '<head>'
    echo "\t<meta charset=\"utf-8\"/>"
    echo "\t<link type=\"text/css\" rel=\"stylesheet\" href=\"css/style.css\"/>"
    echo '\t<title>Design Notebook</title>'
    echo '</head>'
    echo '<body>'
    #Open rap
    openDiv rap
    newline
    #Open headwrap
    openDiv headwrap
    #Open header
    openDiv header
    gethead1
    #Close header
    endDiv
    #Open desc
    openDiv desc
    gethead2
    #Close desc
    endDiv
    #Close headwrap
    endDiv
}
printEnd () {
    #Close rap
    endDiv
    echo '</body>'
    echo '</html>'
}
printEntries () {
    #Open content
    openDiv content
    entryFILES=$(ls entries/*.md | sed '1!G;h;$!d' )
    for f in $entryFILES
    do
    	printEntry $f
    done
    #Open/Close navigation
    echo "<div class=\"navigation\"></div>"
    #Close content
    endDiv
}
printSidebar () {
	#Open sidebar
	openDiv sidebar
	echo '<ul>'
	echo '<li>Entries:</li>'
	echo '<ul>'
	entryFILES=entries/*.md
    for f in $entryFILES
    do
    	printEntryLink $f
    done
    echo '</ul>'
	echo '<li>Blog Links:</li>'
	$mdparser site/blogLinks.md
	echo '</ul>'
	#Close sidebar
	endDiv
}
# The structure of the entire document
printHTML () {
    printHead
    printEntries
    printSidebar
    printCredit
    printEnd
}

### Main Body of the Script
if [ -d $outputpath.bak ]; then
	rm -r $outputpath.bak
fi
if [ -d $outputpath ]; then 
    mv $outputpath $outputpath.bak
fi
mkdir $outputpath
if [ -d entries/images ]; then
	cp -r entries/images $outputpath/
fi
cp -r css $outputpath/
printHTML > $outputpath/index.html
