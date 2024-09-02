#!/usr/bin/env perl
use v5.35;

my $key = 'x';

foreach (@ARGV) {
	# Read from @ARGV
	open my $in, '<:raw', $_ or die "Can't open $_";
	binmode $in;
	my $data = '';
	my $bytes = read $in, $data, 128_000_000;
	close $in;

	# Just doing our job
	$data ^.= $key x $bytes;

	# Write to @ARGV
	open my $out, '>:raw', $_ or die "Can't write to $_";
	binmode $out;
	print $out "$data";
	close $out;

	print "Processed $bytes bytes from $_\n";
}
