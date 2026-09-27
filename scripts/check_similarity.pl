#!/usr/bin/perl
# Word 5-gram shingle overlap between pages. Usage: perl scripts/check_similarity.pl [threshold_percent=30] [glob-prefix=staedte]
# Prints every pair above the threshold (shared shingles / shingles of the smaller page) and the ten highest pairs.
use strict; use warnings; use File::Basename; use Cwd qw(abs_path); use utf8;
binmode(STDOUT,':utf8');
my $root = abs_path(dirname(__FILE__).'/..');
my $thr = $ARGV[0] // 30; my $prefix = $ARGV[1] // 'staedte';
my @files = sort glob("$root/$prefix/*/index.html");
my %S;
for my $f (@files) {
  open my $fh,'<:encoding(UTF-8)',$f or next; local $/; my $h = <$fh>; close $fh;
  $h =~ s/<(script|style|nav|header|footer)[^>]*>.*?<\/\1>//gs; my ($m) = $h =~ /<main[^>]*>(.*?)<\/main>/s; $h = $m if $m;
  $h =~ s/<[^>]+>/ /g; $h =~ s/&[a-z#0-9]+;/ /g; $h = lc $h; $h =~ s/[^\p{L}\p{N} ]/ /g; my @w = split ' ', $h;
  my %s; for my $i (0..$#w-4) { $s{join ' ', @w[$i..$i+4]} = 1 } (my $k=$f) =~ s{^\Q$root\E/}{}; $k =~ s{/index\.html$}{}; $S{$k} = \%s;
}
my @k = sort keys %S; my @res;
for my $i (0..$#k) { for my $j ($i+1..$#k) { my ($a,$b) = @S{$k[$i],$k[$j]}; my ($small,$big) = keys(%$a) <= keys(%$b) ? ($a,$b) : ($b,$a); my $c = 0; for (keys %$small) { $c++ if $big->{$_} } my $p = 100*$c/((scalar keys %$small)||1); push @res, [$p,$k[$i],$k[$j]] } }
@res = sort { $b->[0] <=> $a->[0] } @res;
my $over = grep { $_->[0] > $thr } @res;
printf "%d pages, %d pairs, %d above %d%%\n", scalar(@k), scalar(@res), $over, $thr;
printf "  %.1f%%  %s <-> %s\n", @$_ for grep { $_->[0] > $thr } @res;
print "top pairs:\n"; printf "  %.1f%%  %s <-> %s\n", @$_ for @res[0..($#res>9?9:$#res)];
exit($over ? 1 : 0);
