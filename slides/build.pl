#!/usr/bin/env perl


use strict;
use warnings;

my $html_file = 'perl-rdf.html';
my $temp_file = $html_file . '.temp';

`pandoc --read markdown --write s5 -o $html_file --standalone perl-rdf.md`;

open my $html, '<', $html_file;
open my $temp, '>', $temp_file;

my $skip = 0;
while (<$html>) {
    if ($skip) {
        $skip = 0;
    } else {
        print $temp $_;
    }
    if (/>2010-06-08<\/h4/) {
        print $temp "><div style=\"float:right; margin-top:-4em;\"><img src=\"img/semweb-camel.png\" /></div></div>\n";
        $skip = 1;
    }
}

`mv $temp_file $html_file`;
