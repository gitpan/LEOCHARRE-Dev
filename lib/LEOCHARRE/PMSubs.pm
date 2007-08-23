package LEOCHARRE::PMSubs;
require Exporter;
use vars qw(@ISA $VERSION @EXPORT_OK %EXPORT_TAGS);
use strict;
use Carp;
use warnings;
@ISA = qw(Exporter);
@EXPORT_OK =qw(subs_defined _subs_defined _subs_used subs_used);
%EXPORT_TAGS = ( all => \@EXPORT_OK );
$VERSION = sprintf "%d.%02d", q$Revision: 1.1 $ =~ /(\d+)/g;

sub subs_defined {
   my ($abs_file,$public_only) = @_;
   defined $abs_file or confess('missing file arg');
   $public_only ||=0;

   -f $abs_file or warn("File [$abs_file] is not a file.") and return [];

   my $code = _slurp($abs_file);
   my $subs = _subs_defined($code,$public_only);
   return $subs;
}


sub _subs_defined {
   my ($code,$public_only) = @_;
   defined $code or carp('missing code arg ') and return [];
   $code=~/\w/ or carp('nothing in code arg') and return [];   
   $public_only ||=0;
 
   my $sub={};

   while($code=~/sub\s+([a-zA-Z_]+[\w\: ]*)\s*\{/sg){
      my $_sub = $1;
      $_sub=~s/\s//g;
      next if $public_only and $_sub=~/^_/;
      $sub->{$_sub}++;  
   }   
   
   my @subs = sort keys %$sub;   
   return \@subs;
}



sub _slurp {
   my $abs = shift;
   defined $abs or confess('missing arg');
   
   my $code;
   open(FILE,'<',$abs) or confess($!);;
   while(<FILE>){
      $code.=$_."\n";
   }
   close FILE or confess($!);
   return $code;
}




sub _subs_used {
   my $code = shift;
   defined $code or warn('missing code arg arg') and return {};
   $code=~/\w/ or carp('nothing in code arg') and return {};   
 
   my $sub={};

   while($code=~/(->[a-zA-Z_]+[\w]*|[a-zA-Z_]+[\w]*\()/sg){
      my $_sub = $1; 
      $_sub=~s/^\>|\($//g;
      $sub->{$_sub}++;  
   }  
   
   
   
   return $sub;
}

sub subs_used {
  my ($abs_file) = @_;
  defined $abs_file or confess('missing file arg');

  -f $abs_file or warn("File [$abs_file] is not a file.") and return {};

  my $code = _slurp($abs_file);
  my $sub = _subs_used($code);
  return $sub;
}



1;

__END__

=pod

=head1 NAME

LEOCHARRE::PMSubs - find out what subroutines and or methods are defined in perl code

=head1 SYNOPSIS

   use LEOCHARRE::PMSubs 'subs_defined';
   
   my $codefile = './lib/Module.pm';
   my $subs = subs_defined($codefile);

   map { print STDERR "$codefile : $_\n" } @$subs;   

=head1 DESCRIPTION

This works via regexes and is not perfect, but quick.
This is useful for devel purposes.

=head1 API

=head2 subs_defined()

argument is abs path to perl code file
returns array ref of subs defined in file
optional argument is boolean, if to include only public methods,
methods that do not begin with underscore.
default is 0, all subs/methods.

if no file argument, throws exception
if file does not exist, warns and returns []

=head2 _subs_defined()

argument is code text
returns array ref

optional argument is boolean, if to include only public methods,
methods that do not begin with underscore.

if no code, warns and returns [].


=head2 _subs_used()

argument is code text
for curiosity
returns hash ref with subs used and count of times

CAVEAT: needs to be worked out for kinks

=head2 subs_used()

argument is abs path to code file
returns hash ref with subs used and count of times

=head1 CLI

See bin/pmsubs included in this distro.

=head1 AUTHOR

Leo Charre leocharre at cpan dot org

=head1 SEE ALSO

L<LEOCHARRE::PMUsed>
L<LEOCHARRE::Dev>

=cut
