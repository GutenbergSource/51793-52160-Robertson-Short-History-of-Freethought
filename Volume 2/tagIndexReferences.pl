# tagIndexReferences.pl -- tag references in a multi-volume index.

use strict;

use Roman;  # Roman.pm version 1.1 by OZAWA Sakuro <ozawa@aisoft.co.jp>


my $inputFile = $ARGV[0];


open(INPUTFILE, $inputFile) || die("Could not open $inputFile");

# Test
#  II, 23; IX, 12, 23.
#  II, 23, IX, 12, 23.
#  II, 23, IX, 12-23, 45&ndash;67
#  III, IV, 123.


while (<INPUTFILE>) {
    my $line = $_;

    my $remainder = $line;
    my $result = "";

    # Skip existing reference tags.
    while ($remainder =~ m/<ref\b(.*?)>(.*?)<\/ref>/) {
        my $before = $`;
        my $ref = $&;
        $remainder = $';

        $result .= tagFragment($before) . $ref;
    }
    $result .= tagFragment($remainder);

    print $result;
}


sub tagFragment {
    my $remainder = shift;
    my $result = "";

    # print "Fragment: $remainder";

    while ($remainder =~ /(\b[IVXLCivxlc]+\b)(([,]?) ([0-9]+))?/) {
        my $before = $`;
        my $volumeNumber = $1;
        my $pagePart = $2;
        my $separator = $3;
        my $page = $4;
        $remainder = $';

        my $volume = arabic($volumeNumber);

        $result .= $before;

        if ($page eq "") {
            # We just have a volume reference, but we do nothing with it.
            # $result .= "<ref target=p$volume>$volumeNumber</ref>";
            $result .= $volumeNumber . $pagePart;
        } else {
            # We have a volume and page reference, turn it into a reference.
            $result .= "$volumeNumber$separator <ref target=v$volume.pb$page>$page</ref>";

            # Maybe we have more page references for this volume?
            while ($remainder =~ /^( <hi>(n|sq)\.<\/hi>)?([;,] |\&ndash;|-)([0-9]+)/) {
                my $locationIndicator = $1;
                my $separator = $3;
                my $page = $4;
                $remainder = $';

                $result .= "$locationIndicator$separator<ref target=v$volume.pb$page>$page</ref>";
            }
        }
    }

    return $result . $remainder;
}