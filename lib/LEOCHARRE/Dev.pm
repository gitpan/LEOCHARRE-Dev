package LEOCHARRE::Dev;
use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT_OK %EXPORT_TAGS);
$VERSION = sprintf "%d.%02d", q$Revision: 1.11 $ =~ /(\d+)/g;
@EXPORT_OK = qw(is_pmdist ls_pmdist pmdist_guess_name pmdist_guess_version_from);
@ISA = qw/Exporter/;
%EXPORT_TAGS = ( 'all' => \@EXPORT_OK );

$LEOCHARRE::Dev::DEBUG = 1;
sub debug { print STDERR " - @_\n" if $LEOCHARRE::Dev::DEBUG; 1 }

sub _show_symbol_table {
  require Data::Dumper;
   
  print STDERR " SYMBOL TABLE\n" . Data::Dumper::Dumper(\%LEOCHARRE::Dev::);
  print STDERR "\n";

}

sub is_pmdist {
   my $d = shift;
   require Cwd;
   $d ||= Cwd::cwd();
   
   $d = Cwd::abs_path($d);

   -d $d
      or warn("$d is not dir")
      and return;

   -f "$d/Makefile.PL"
      or warn("$d is not dist, no Makefile.PL")
      and return 0;

   return $d;
}


sub ls_pmdist {
   my $d = shift;
   $d ||= './';
   my $abs_d = is_pmdist($d)  or die;

   my @ls;
   for my $distfile ( sort grep { !/CVS|\.swp$/ } split( /\n/, `find '$abs_d' -type f`) ){
      $distfile=~s/^$abs_d\///;
      push @ls,$distfile;
   }
   defined @ls or warn("nothing in $abs_d ?");
   return @ls;
}


sub pmdist_guess_name {
      my $d = shift;
      $d ||= './';
      
      my $abs_d = is_pmdist($d)  or die;
      $abs_d=~s/^\/.+\/devel\///;
      print STDERR " dist nameguess $abs_d\n";

      $abs_d=~s/.+\///;
      $abs_d=~s/\-/::/g;
      print STDERR " returning $abs_d\n";
   return $abs_d;
   
}

sub pmdist_guess_version_from {
      my $d = shift;
      $d ||= './';
      my $abs_d = is_pmdist($d)  or die;

   if( my $distname = pmdist_guess_name($abs_d) ){
      $distname=~s/::/\//g;
      $distname.='.pm';
      my $pm = $distname;
      if (-f "$abs_d/$distname"){
         debug("found $abs_d/$distname.");

         return $distname;
      }
      elsif( -f "$abs_d/lib/$distname"){
         debug("found $abs_d/lib/$distname.");

         return "lib/$distname";
      }
      debug("Got distname $distname but could not match a file.");
   }

   debug("did not get distname from pmdist_guess_name()"); 
   
   my @pms = grep { /\.pm$/ and !/^blib\// and !/^t\// } ls_pmdist($d);
   @pms and scalar @pms or return;

   my @libpms = grep { /^lib\// } @pms;
   if (@libpms and scalar @libpms ){ # return first
      return $libpms[0];
   }

   # any other?
   return $pms[0];


   #my @pm = grep { /\.pm$/ } ls_pmdist($d) or return;
   #my $first = shift @pm;
   #return $first;

}



1;


__END__

=pod

=head1 NAME

LEOCHARRE::Dev

=head1 DESCRIPTION

This package is a collection of modules and scripts to aid in development.

=head1 SUBS

These subs are contained in the main module. None are exported by default.

=head2 is_pmdist()

Argument is abs path to dist directory.
If no argument provided, uses Cwd.
Returns abs path resolved by Cww::abs_path

   my $abs_dist = is_pmdist();
   my $abs_dist = is_pmdist('./dev/My-Module');

We deem a directory to be a distro if a Makefile.PL file is present therein.

=head2 ls_pmdist()

Argument is path to distro dir.  If left out, tries to use is_pmdist().
Returns list of files relative to dist dir, with no leading slash. (not array ref).

Leaves out CVS entries.


=head1 Executables

A number of useful perl module tools are present to aid in development.


