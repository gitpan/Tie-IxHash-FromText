use inc::Module::Install;

name            ('Tie-IxHash-FromText');
abstract        ('A parser for contructing IxHash objects');
author          ('Yung-chung Lin <xern@cpan.org>');
version_from    ('lib/Tie/IxHash/FromText.pm');
license         ('perl');

requires        ('Tie::IxHash');
requires        ('Tie::DxHash');
build_requires  ('Test::More');
auto_install();

&WriteAll;

