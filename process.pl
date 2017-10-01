
use strict;

my $saxon = "java -jar C:\\Bin\\saxon9he\\saxon9he.jar "; # (see http://saxon.sourceforge.net/)

print "Create complete XML version of A Short History of Freethought...\n";

system ("$saxon ShortHistoryOfFreethought.xsl ShortHistoryOfFreethought.xsl > ShortHistoryOfFreethought.xml");

system ("perl -S tei2html.pl -h ShortHistoryOfFreethought.xml");
system ("perl -S tei2html.pl -e ShortHistoryOfFreethought.xml");
