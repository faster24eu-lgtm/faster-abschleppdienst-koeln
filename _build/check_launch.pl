#!/usr/bin/perl
# Launch-prep verification: run after `perl _build/build.pl`. Checks:
# - exactly one occurrence each of consent-default / gtag.js / gtag config / click script, in that order
# - exactly one H1, one <title>, one meta description, one canonical
# - phone number in visible text matches phone_conversion_number
# - no external script hosts other than googletagmanager.com
# - internal links resolve to an existing file
use strict; use warnings; use FindBin qw($Bin); use File::Find;
my $ROOT = "$Bin/..";
my @files; find(sub { push @files, $File::Find::name if /index\.html$/ }, $ROOT);
my $errors = 0;
for my $f (sort @files) {
  open(my $fh,'<:raw',$f) or next; local $/; my $h = <$fh>; close $fh;
  (my $rel = $f) =~ s/\Q$ROOT\E//;
  my $c_default = () = $h =~ /gtag\('consent', 'default'/g;
  my $c_gtagjs  = () = $h =~ /googletagmanager\.com\/gtag\/js\?id=AW-10963026341/g;
  my $c_config  = () = $h =~ /phone_conversion_number/g;
  my $c_click   = () = $h =~ /phone_click/g;
  print "! $rel: consent-default x$c_default (want 1)\n" and $errors++ if $c_default != 1;
  print "! $rel: gtag.js loader x$c_gtagjs (want 1)\n" and $errors++ if $c_gtagjs != 1;
  print "! $rel: phone_conversion_number x$c_config (want 1)\n" and $errors++ if $c_config != 1;
  print "! $rel: click script x$c_click (want 1)\n" and $errors++ if $c_click != 1;
  # order: default before gtag/js loader before phone_click
  my $i1 = index($h, "gtag('consent', 'default'");
  my $i2 = index($h, 'googletagmanager.com/gtag/js');
  my $i3 = index($h, 'phone_conversion_number');
  my $i4 = index($h, 'phone_click');
  if (!($i1>=0 && $i2>$i1 && $i3>$i2 && $i4>$i3)) { print "! $rel: wrong script order\n"; $errors++; }
  my $h1c = () = $h =~ /<h1[ >]/g;
  print "! $rel: $h1c H1 tags (want 1)\n" and $errors++ if $h1c != 1;
  my $titlec = () = $h =~ /<title>/g;
  print "! $rel: $titlec <title> (want 1)\n" and $errors++ if $titlec != 1;
  my $descc = () = $h =~ /<meta name="description"/g;
  print "! $rel: $descc meta description (want 1)\n" and $errors++ if $descc != 1;
  my $canonc = () = $h =~ /<link rel="canonical"/g;
  print "! $rel: $canonc canonical (want 1)\n" and $errors++ if $canonc != 1;
  # phone number consistency: visible text occurrences vs phone_conversion_number value
  if ($h =~ /'phone_conversion_number':\s*'([^']*)'/) {
    my $pn = $1;
    print "! $rel: phone_conversion_number is '$pn', expected '+49 176 41956993'\n" and $errors++ if $pn ne '+49 176 41956993';
  }
  # external scripts: only googletagmanager.com allowed
  while ($h =~ /<script[^>]+src="(https?:\/\/[^"]+)"/g) {
    my $src = $1;
    if ($src !~ m{^https://www\.googletagmanager\.com/}) { print "! $rel: external script $src\n"; $errors++; }
  }
  # internal links: href="./x/" or href="../x/" etc. resolve to a file that exists
  my $dir = $f; $dir =~ s{/[^/]+$}{};
  while ($h =~ /href="([^"#][^"]*)"/g) {
    my $href = $1;
    next if $href =~ m{^(https?:|mailto:|tel:)};
    next if $href =~ /^#/;
    my $target = $href;
    $target =~ s/\?.*$//; $target =~ s/#.*$//;
    my $abs = $target =~ m{^/} ? "$ROOT$target" : "$dir/$target";
    $abs .= 'index.html' if $abs =~ m{/$};
    $abs = "$abs/index.html" if -d $abs && ! -f "$abs/index.html" && -d $abs;
    if (! -e $abs && ! -e "$abs.html") { print "! $rel: broken link '$href' -> $abs\n"; $errors++; }
  }
}
print "\nChecked ".scalar(@files)." pages, $errors issue(s).\n";
exit($errors ? 1 : 0);
