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

use Test::More tests => 6;
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

exit();
