package Tie::IxHash::FromText;


use strict;

our $VERSION = '0.02';

use Tie::IxHash;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(
		 ixhash_parse
		 );

use Tie::IxHash::FromText::Parse;

sub ixhash_parse {
    Tie::IxHash::FromText::Parse::_parse(shift(), 'i');
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
