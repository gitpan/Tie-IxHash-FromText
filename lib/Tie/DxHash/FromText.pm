package Tie::DxHash::FromText;

use strict;

use Tie::DxHash;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(
                 dxhash_parse
                 );

use Tie::IxHash::FromText::Parse;

sub dxhash_parse {
    Tie::IxHash::FromText::Parse::_parse(shift(), 'd');
}


1;
__END__

=head1 NAME

    Tie::IxHash::FromText - A parser for contructing IxHash objects

=head1 SEE ALSO

L<Tie::IxHash::FromText>

=head1 THE AUTHOR

Yung-chung Lin (a.k.a. xern) E<lt>xern@cpan.orgE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself

=cut

