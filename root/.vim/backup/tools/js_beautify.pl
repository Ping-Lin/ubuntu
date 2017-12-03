#!/usr/bin/perl

use JavaScript::Beautifier qw/js_beautify/;
local $/;
$js_source_code = <STDIN>;
my $pretty_js = jsbeautify( $js_souce_code, {
	indent_size => 2,
	indent_character => ' ',
});
print $pretty_js;
