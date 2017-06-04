#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use feature qw/ say /;
use Getopt::Std;
use Text::CSV;

my %opts;
getopt('d', \%opts);

my $delim = $opts{d};
my $f     = shift;

my $csv = Text::CSV->new(
    {
        binary => 1,
    }
) or die "Can't init Text::CSV: " . Text::CSV->error_diag() . "\n";

my $fh;
if ($f eq '-') {
  $fh = *STDIN;
}
else {
  open $fh, '<:encoding(utf8)', $f;
}

my @output;

while (my $cols = $csv->getline( $fh ) ) {
  my $rv = join("$delim", @$cols);
  push @output, $rv;
}

say for @output;
