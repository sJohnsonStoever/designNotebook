# Design Notebook #

By [Samuel Johnson Stoever](http://github.com/sJohnsonStoever)

A (very) simple blog-style static html 'notebook' generator with layout and design adopted from the bbv1 Wordpress theme by [Aaron Adams](http://aaronadams.me/), as used by the [MIT Disobedience Project webpage](http://disobedience.mit.edu/).

The project consists of a pair of a very simple shell scripts, and a css style sheet. Notebook 'entries' are stored as markdown documents named so that the shell automatically orders them in chronological order as to avoid doing sorting within the script itself. 

I'm not sure if the shell scripts are POSIX-compliant, though they have been tested (and work) both on OS X and Ubuntu Linux. 

The only dependency normally not included in vanilla falvors of the aforementioned unix-like distributions is a markdown parser -- I use [peg-multimarkdown](http://github.com/fletcher/peg-multimarkdown) by the marvelous Penney Fletcher. In fact, this project started out because [Pelican](http://docs.getpelican.com/), a static blog generator I used to use for my 'notebooks' does not support multimarkdown syntax, that and pelican has a bunch of dependencies that i didn't want to bother installing onto my girlfriend's laptop that I borrow from time to time.

## Usage ##

To generate the notebook (example entries are provided) simply navigate to the base directory for the project and run publish.sh. 

In order to make the notebook your own, simply delete all the entries in the 'entries' directory, and add a new entry by running 'newEntry.sh'. A new file will be created in the 'entries' directory using specific conventions. 

**Remember to leave two lines of whitespace after the last markdown header (e.g., Date: 2012-11-06 23:17:21) and the body of your entry.** This condition will probably be removed as this software matures.

Also, remember to not add any extra markdown headers, or to remove any, even if you don't use them (e.g., the tags header).


