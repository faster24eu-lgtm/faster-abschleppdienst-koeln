#!/usr/bin/perl
# Cleanup QA: flags leftover encyclopedia trivia and unverifiable claims in city/Autobahn/Bundesland
# main content. Usage: perl scripts/check_trivia.pl [glob-prefix=staedte]
# Exit 0 = clean, 1 = hits found (each hit is printed with the file and matched text).
use strict; use warnings; use File::Basename; use Cwd qw(abs_path); use utf8;
binmode(STDOUT,':utf8');
my $root = abs_path(dirname(__FILE__).'/..');
my @prefixes = @ARGV ? @ARGV : ('staedte','autobahnen','bundeslaender');
my @trivia = qw(Einwohner gegründet Jahrhundert Quadratmeter Hektar amtlich Oberzentrum Regierungsbezirk Naturschutzgebiet Vogelschutz Bundeswehr Mittelalter Gebietsreform Stadtrecht Jungsteinzeit Eisenzeit);
my @money = ('€','Euro','Minuten','Sterne','Bewertung');
my $hits = 0;
for my $prefix (@prefixes) {
  for my $f (sort glob("$root/$prefix/*/index.html")) {
    open my $fh,'<:encoding(UTF-8)',$f or next; local $/; my $h = <$fh>; close $fh;
    (my $m) = $h =~ /<main[^>]*>(.*?)<\/main>/s; $m //= $h;
    $m =~ s/<(script|style)[^>]*>.*?<\/\1>//gs;
    (my $rel = $f) =~ s{^\Q$root\E/}{};
    for my $w (@trivia) {
      while ($m =~ /(.{0,25}\Q$w\E.{0,25})/g) { print "TRIVIA  $rel: [$w] ...$1...\n"; $hits++; }
    }
    for my $w (@money) {
      while ($m =~ /(.{0,25}\Q$w\E.{0,25})/g) { print "MONEY   $rel: [$w] ...$1...\n"; $hits++; }
    }
  }
}
print "\n$hits hit(s).\n";
exit($hits ? 1 : 0);
