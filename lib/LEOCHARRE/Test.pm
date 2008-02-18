package LEOCHARRE::Test;
use vars qw(@ISA $VERSION @EXPORT);
use strict;
use Exporter;
@ISA = qw/Exporter/;
@EXPORT = qw(ok_part);

my $part =0;
sub ok_part {
   my $label = shift;
   $label ||='';
   
   printf STDERR "\n\n# ------- PART %s %s ------ #\n",$part++, uc($label);
   return 1;
}

1;
