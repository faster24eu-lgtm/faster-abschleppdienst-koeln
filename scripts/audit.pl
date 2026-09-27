#!/usr/bin/perl
# Site audit for the generated static site. Usage: perl scripts/audit.pl
# Checks: exactly one H1, title <=60 (without brand suffix trimmed by builder), description <=155, canonical,
# robots noindex, valid JSON-LD, phone number in tel:/wa.me links, placeholders, broken relative links, reachability <=3 clicks.
use strict; use warnings; use File::Find; use File::Basename; use Cwd qw(abs_path); use JSON::PP;
my $root = abs_path(dirname(__FILE__).'/..');
my (%html, @pages);
find({ no_chdir=>1, wanted => sub { return unless /index\.html$/; return if $File::Find::name =~ m{/(\.git|_build)/}; my $rel = $File::Find::name; $rel =~ s{^\Q$root\E/?}{}; push @pages, $rel; } }, $root);
@pages = sort @pages;
my $errors = 0; sub bad { $errors++; print "  ! @_\n" }
my %out; # page -> [targets]
my $phone_ok = 0;
for my $p (@pages) {
  open my $fh,'<:raw',"$root/$p" or die; local $/; my $h = <$fh>; close $fh; $html{$p}=$h;
  my $n = () = $h =~ /<h1[ >]/g; bad("$p: H1 count $n") if $n != 1;
  my ($t) = $h =~ /<title>(.*?)<\/title>/s; bad("$p: no title") unless $t;
  bad("$p: title too long (".length($t).")") if $t && length($t) > 75;
  my ($d) = $h =~ /name="description" content="(.*?)"/s; bad("$p: no description") unless $d;
  (my $dd = $d//'') =~ s/&amp;/&/g; bad("$p: description >155 (".length($dd).")") if length($dd) > 155;
  bad("$p: no canonical") unless $h =~ /<link rel="canonical" href="https:\/\/abschleppdienst-faster\.de\//;
  bad("$p: no noindex") unless $h =~ /<meta name="robots" content="noindex, nofollow"/ ;
  while ($h =~ /<script type="application\/ld\+json">(.*?)<\/script>/gs) { my $j = $1; eval { decode_json($j) }; bad("$p: invalid JSON-LD: $@") if $@; }
  while ($h =~ /href="tel:([^"]*)"/g) { bad("$p: wrong phone $1") if $1 ne '+4917641956993' && $1 ne '+3233756737'; }
  while ($h =~ /href="https:\/\/wa\.me\/(\d+)/g) { bad("$p: wrong wa.me $1") if $1 ne '4917641956993'; }
  unless ($p =~ m{^(impressum|datenschutz)/}) { bad("$p: placeholder text") if $h =~ /TODO|\[ergänzen\]|Lorem|XXX/; }
  # links
  my @t;
  while ($h =~ /href="([^"#]+)(?:#[^"]*)?"/g) { my $u = $1; next if $u =~ m{^(https?:|mailto:|tel:|data:|javascript:)}; push @t, $u }
  my $dir = dirname("$root/$p");
  for my $u (@t) {
    my $target = $u; $target =~ s/\?.*//;
    my $full = ($target =~ m{^/}) ? "$root$target" : "$dir/$target";
    $full =~ s{/\./}{/}g; 1 while $full =~ s{[^/]+/\.\./}{};
    my $f = $full; $f .= 'index.html' if $f =~ m{/$}; $f = "$f/index.html" if -d $f;
    unless (-e $f) { bad("$p: broken link $u"); next }
    (my $rel = $f) =~ s{^\Q$root\E/?}{}; push @{$out{$p}}, $rel if $rel =~ /index\.html$/;
  }
}
# reachability from home within 3 clicks
my %depth = ('index.html'=>0); my @q = ('index.html');
while (@q) { my $c = shift @q; for my $n (@{$out{$c}||[]}) { next if exists $depth{$n}; $depth{$n} = $depth{$c}+1; push @q,$n } }
for my $p (@pages) { next if $p =~ m{^danke/}; if (!exists $depth{$p}) { bad("$p: not reachable from home") } elsif ($depth{$p} > 3) { bad("$p: needs $depth{$p} clicks") } }
my %hist; $hist{$depth{$_}}++ for grep { exists $depth{$_} } @pages;
print "pages: ".scalar(@pages)."  errors: $errors  click depth: ".join(', ', map {"$_=>$hist{$_}"} sort keys %hist)."\n";
exit($errors ? 1 : 0);
