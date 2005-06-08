use inc::Module::Install;

name           ( 'PPI-HTML'                   );
abstract       ( 'Generate syntax-hightlighted HTML for Perl using PPI' );
author         ( 'Adam Kennedy <cpan@ali.as>' );
version_from   ( 'lib/PPI/HTML.pm'            );
license        ( 'perl'                       );
requires       ( 'perl'           => '5.005'  );
requires       ( 'CSS::Tiny'      => '1.10'   );
requires       ( 'PPI'            => '0.990'  );
requires       ( 'Params::Util'   => '0.05'   );
build_requires ( 'File::Spec'     => '0.82'   );
build_requires ( 'Test::More'     => '0.47'   );
install_script ( 'bin/ppi2html'               );

auto_install();

&WriteAll;
