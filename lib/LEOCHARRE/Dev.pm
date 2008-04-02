package LEOCHARRE::Dev;
our $VERSION = sprintf "%d.%02d", q$Revision: 1.5 $ =~ /(\d+)/g;

sub _show_symbol_table {
  require Data::Dumper;
   
  print STDERR " SYMBOL TABLE\n" . Data::Dumper::Dumper(\%LEOCHARRE::Dev::);
  print STDERR "\n";


}




1;
