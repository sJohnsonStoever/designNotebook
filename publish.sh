#!/bin/sh

#. ./config.sh
dnbpath="."
mdparser="multimarkdown"

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
    $mdparser $dnbpath/site/head1.md | sed 's/<p>/\t/g' | sed 's/<\/p>/\t/g'
}
gethead2 () {
    $mdparser $dnbpath/site/head2.md | sed 's/<p>/\t/g' | sed 's/<\/p>/\t/g'
}
newline () {
    echo ' '
}
printCredit () {
    openDiv credit
    $mdparser $dnbpath/site/credit.md | sed 's/<p>/\t/g' | sed 's/<\/p>/\t/g'
    endDiv
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
    
    #Close content
    endDiv
}
printHTML () {
    printHead
    printEntries
    printCredit
    printEnd
}

printHTML > index.html
