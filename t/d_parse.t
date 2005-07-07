use Test::More tests => 5;

use Tie::DxHash::FromText;

#use Data::Dumper;
#$Data::Dumper::Indent=1;
{local$/;
$s = <DATA>;
}
#print Dumper dxhash_parse($s);
$h = dxhash_parse($s);

ok(exists $h->{ServerName}->{foo});
ok(exists $h->{RewriteCond}->{bar});
ok(exists $h->{RewriteRule}->{bletch});
ok(exists $h->{RewriteCond}->{phooey});
ok(exists $h->{RewriteRule}->{squelch});

__END__
* ServerName
** foo
* RewriteCond
** bar
* RewriteRule
** bletch
* RewriteCond
** phooey
* RewriteRule
** squelch
