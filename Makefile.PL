use inc::Module::Install;

name          ( 'PPI-HTML'                  );
abstract      ( 'Generate syntax-hightlighted HTML for Perl using PPI' );
author        ( 'Adam Kennedy<cpan@ali.as>' );
version_from  ( 'lib/PPI/HTML.pm'           );
license       ( 'perl'                      );

requires      ( 'perl'           => '5.005' );
requires      ( 'CSS::Tiny'      => '1.06'  );
requires      ( 'PPI'            => '0.840' );

build_requires( 'File::Spec'     => '0.82'  );
build_requires( 'Test::More'     => '0.47'  );

auto_install();

&WriteAll;
