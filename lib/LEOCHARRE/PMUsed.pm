package LEOCHARRE::PMUsed;
use Cwd;
require Exporter;
use vars qw(@ISA $VERSION @EXPORT_OK %EXPORT_TAGS);
use strict;
@ISA = qw(Exporter);
@EXPORT_OK =qw(module_is_installed find_code_files modules_used modules_used_scan_tree);
%EXPORT_TAGS = ( all => \@EXPORT_OK );

$VERSION = sprintf "%d.%02d", q$Revision: 1.3 $ =~ /(\d+)/g;

$LEOCHARRE::PMUsed::DEBUG = 0;
sub DEBUG : lvalue {$LEOCHARRE::PMUsed::DEBUG}
sub debug { my $msg = shift; print STDERR " $msg\n" if DEBUG; }

sub module_is_installed {
   my $module = shift;
   $module or confess('missing argument to module_is_installed');
   no warnings;
   if ( do { eval "require $module;" } ){
      return 1;
   }   
   warn("Missing perl module: $module");
   return 0;
}


sub find_code_files {
   my $abs = shift;
   require File::Find::Rule;

   my $r = new File::Find::Rule();
   $r->file;
   $r->name( qr/\.pl$|\.pm$|\.t$/ );

   
   my @files = $r->in($abs);

  
   #also find in bin, if usr/bin/perl type line is present in first 3 lines

   if (-d "$abs/bin"){
      debug('bin detected');
   
      opendir(DIR, "$abs/bin") or die($!);
      my @bins = grep { -T "$abs/bin/$_" } readdir DIR;
      closedir DIR;

      debug('count in bin '.scalar @bins);

      BINFILES : for (@bins){
         my $abs_bin= "$abs/bin/$_";
         
         my $x =0;
         open(BIN,'<',$abs_bin);         
         LINES : while(<BIN>){
            my $line = $_;
            if ($line=~/#![\/A-Za-z]+bin\/perl\b/){
               push @files, $abs_bin;
               close BIN;         
               next BINFILES;
            }
            if (++$x > 3){
               close BIN;
               next BINFILES;               
            }
         }
         close BIN;      
      }
   }


   
   return \@files;
   
}


sub modules_used {
   my $abs_code = shift;
   (-f $abs_code) or warn("File [$abs_code] is not a file.") and return;
   
   my $lines = [];
   my $modules = {};
   my $code;
   open(FILE,'<',$abs_code);
   while(<FILE>){
      push @$lines,$_;
   }
   
   close FILE;

   LINES: for(@$lines){
      my $line = $_;

      $line=~s/#\s.+$//g; # take out comments
      
      if ( $line=~/use base '([^\']+)'/ ){
         $modules->{$1}++;
      }
      elsif ( $line=~/use base qw\W([\s\w\:]+)\W/){
         my @mods = split(/\s/,$1);
         map{ $modules->{$_}++ if $_=~/\w/ } @mods;
      }   

      
      elsif( $line=~/^use\s+([\w\:]+)[\s;]/s ){      
         $modules->{$1}++;            
      }
      elsif ($line=~/^[\W]*use\s+([\w\:]+)[\s;]/s){
         $modules->{$1}++;         
      }
            
      if ( $line=~/require\s+([\w\:]+)\s*;/s ){
         my $module = $1;
         
         $module=~/\.pl$|\.pm$/ or next LINES;
         $module!~/\./ or next LINES;
         $modules->{$module}++;
      }   
      
   
   }


   
   return $modules;
}


sub modules_used_scan_tree {
   my $abs_dir = shift;

   my $codefiles = find_code_files($abs_dir) or warn("no code files found?") and return;
  
   
   my $all={};
   
   for(@$codefiles){
      my $modules = modules_used($_);

      for(keys %$modules){
         
         my $name = $_;
         my $count = $modules->{$name};

         if(defined $all->{$name}){
            $count = $count + $all->{$name};
         }

         $all->{$name} = $count;         
      }     
   }

   return $all;   
}








1;

=head1 NAME

LEOCHARRE::PMUsed - check what modules are used in a directory


=head1 DESCRIPTION

Will recurse all pl, t, pm and any files in bin for use $modulename.
Basically check all perl and find what modules are being used.

Also check if they are installed; optionally.

=head2 module_is_installed()

argument is a module name, like PDF::API2.
returns boolean, warns if not installed.

=head2 find_code_files()

argument is abs path to dir to start from, your dev base etc.
Find all .t .pm .pl files, also if there is a bin dir, will  seek perl scripts
returns array ref with abs paths to files.

=head2 modules_used()

argument is abs path to a perl code file, 
returns hash ref, each key is a module name, the value is the count of times seen.

returns undef and warns if file not there

this list includes modules used and modules required.
if a require such as library.pl is present, this is discarded.
all requires of names with a dot are discarded.

=head2 modules_used_scan_tree()

argument is abs dir, such as /home/me/dev/MySuperThing.
scans entire filetree

returns hash ref, each key is a module name, the value is the count of times seen.


=head1 AUTHOR

Leo Charre leocharre at cpan dot org
