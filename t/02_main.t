#!/usr/bin/perl -w

# Formal testing for PPI

# This test script only tests that the tree compiles

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}

use Test::More tests => 9;
use PPI       ();
use PPI::HTML ();





#####################################################################
# Basic Empiric Testing

# Trivial Docment
{
	my $Document = PPI::Document->new( 'my $foo = "bad";' );
	isa_ok( $Document, 'PPI::Document' );

	my $HTML = PPI::HTML->new();
	isa_ok( $HTML, 'PPI::HTML' );

	is( $HTML->html( $Document ) . "\n", <<'END_HTML', 'Trivial document matches expected HTML' );
<span class="word">my</span> <span class="symbol">$foo</span> <span class="operator">=</span> <span class="double">&quot;bad&quot;</span><span class="structure">;</span>
END_HTML
}





# Line numbers and newlines
{
	my $Document = PPI::Document->new( "this();\nthat();\n" );
	isa_ok( $Document, 'PPI::Document' );

	my $HTML = PPI::HTML->new( line_numbers => 1 );
	isa_ok( $HTML, 'PPI::HTML' );

	is( $HTML->html( $Document ) . "\n", <<'END_HTML', 'Trivial document matches expected HTML' );
<span class="line_number">1: </span><span class="word">this</span><span class="structure">();</span><br>
<span class="line_number">2: </span><span class="word">that</span><span class="structure">();</span><br>
<span class="line_number">3: </span>
END_HTML
}





# Page wrap, and manually specify colors
{
	my $Document = PPI::Document->new( "my \$foo = 1;\n" );
	isa_ok( $Document, 'PPI::Document' );

	my $HTML = PPI::HTML->new(
		page         => 1,
		line_numbers => 1,
		colors => {
			line_number => '#CCCCCC',
			number      => '#990000',
			},
		);
	isa_ok( $HTML, 'PPI::HTML' );

	is( $HTML->html( $Document ), <<'END_HTML', 'Page wrapped, manually coloured page matches expected' );
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta name="robots" content="noarchive">
<style type="text/css">
<!--
.number {
	color: #990000;
}
.line_number {
	color: #CCCCCC;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<span class="line_number">1: </span>my $foo = <span class="number">1</span>;<br>
<span class="line_number">2: </span>
</body>
</html>
END_HTML
}

exit();
