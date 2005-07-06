package Tie::IxHash::FromText;

use strict;
use Tie::IxHash;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(ixhash_parse);

our $VERSION = '0.01';


sub _ixhash {
    my %h;
    tie(%h, 'Tie::IxHash');
    \%h;
}

sub ixhash_parse {
    local $_ = shift;
    s/^[\s\n]+//so;
    s/^\*+\*\s/* /so;
    s/\n+$//sg;
    s/\n+/\n/sg;
    s/\s+$//mg;
    $_.=$/;

#    print ;    print $/x3;
    my @last = (0);
    my @st = ();
    my $tree=_ixhash();
    s/^([\*]+)\s+(.+)/
      #	print "$1 $2\n";
      if(length($1) > $last[-1]){
	push @last, length($1);
	push @st, $2;
#	print '$tree->'.join('->', map{"{'$_'}"}@st)."\n";
	eval '$tree->'.join('->', map{"{'$_'}"}@st).'=_ixhash()';
      }
    elsif(length($1) < $last[-1]){
      foreach (1..$last[-1] - length($1)){
#	print '...';
	pop @st;
	pop @last;
      }
	if(length($1) eq $last[-1]){
	  pop @st;
	  pop @last;
	  push @last, length($1);
	  push @st, $2;
	}
#      print '$tree->'.join('->', map{"{'$_'}"}@st)."\n";
      eval '$tree->'.join('->', map{"{'$_'}"}@st).'=_ixhash()';
    }
    else {
      pop @st;
      pop @last;
      push @last, length($1);
      push @st, $2;
#      print '$tree->'.join('->', map{"{'$_'}"}@st)."\n";
	
      eval '$tree->'.join('->', map{"{'$_'}"}@st).'=_ixhash()';
    }
#    print " (@last) (@st)\n\n";
    
/mexg;
    $tree;
}

1;
__END__

=head1 NAME

  Tie::IxHash::FromText - A parser for contructing IxHash objects

=head1 USAGE

  use Tie::IxHash::FromText;
  use Data::Dumper;

  print Dumper ixhash_parse(<<'TEXT');
  * 1
  ** 1-1
  ** 1-2
  *** 1-2-1
  * 2
  ** 2-1
  * 3
  ** 3-1
  ** 3-2
  *** 3-2-1
  **** 3-2-1-1
  ***** 3-2-1-1-1
  ***** 3-2-1-1-2
  ****** 3-2-1-1-2-1
  TEXT

And it returns stuff like this:


  $VAR1 = {
    '1' => {
      '1-1' => {},
      '1-2' => {
        '1-2-1' => {}
      }
    },
    '2' => {
      '2-1' => {}
    },
    '3' => {
      '3-1' => {},

      '3-2' => {
        '3-2-1' => {
          '3-2-1-1' => {
            '3-2-1-1-1' => {},
            '3-2-1-1-2' => {
              '3-2-1-1-2-1' => {}
            }
          }
        }
      }
    },
    '4' => {}
  };


=head1 THE AUTHOR

Yung-chung Lin (a.k.a. xern) E<lt>xern@cpan.orgE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself

=cut
