use Test::Simple 'no_plan';
use strict;
use lib './lib';
use LEOCHARRE::PMUsed ':all';
use Cwd;
use Smart::Comments '###';
use Carp;
use Data::Dumper;

ok(1);
$LEOCHARRE::PMUsed::DEBUG = 1;


# ----------------------------
my $files = find_code_files(cwd().'/t/mockdev');


# ----------------------------
ok(1,"\n\nONE AT A TIME");
for (@$files){
   my $codefile = $_;

   ok($codefile!~/bin\/notperl$/, "should not detect bin/notperl as a perl script");

   ok(1," codefile: $codefile");
   my $used = modules_used($codefile);
   ### $used
   ok($used, ' got used for codefile');
   
   map { ok(1," used: $_") } keys %$used; 
   
}




# ----------------------------
ok(1,"\n\nALL AT ONCE");

my $all = modules_used_scan_tree(cwd().'/t/mockdev');

my @listed = keys %$all;
ok( scalar @listed, 'got back' )or die;
map { ok(1," used: $_") } keys %$all; 







# ----------------------------
ok(1,"\n\nCHECK WE HAVE WHAT WE SHOULD");


use Data::Dumper;
print STDERR Data::Dumper::Dumper( $all );

for (qw(
Cwd
Carp
File::Find::Rule
strict
File::Find
Module::Info
File::Path
)){
   ok( _has($all,$_), " +has $_");


}

ok(1,"\n\nCHECK WE HAVE DONT HAVE WHAT WE SHOULD NOT");
for (qw(notmodule NotModuleEither)){
   ok( ! _has($all,$_), " -has not $_");
}


sub _has {
   my ($href,$what) = @_;
   defined $href and defined $what or confess('missing');

   LOOK: for ( keys %$href){
      $_ eq $what or next LOOK;
      return 1;
   }
   return 0;   
}



# ----------------------------
ok(1,"\n\nTEST INSTALLED OR NOT");
for( qw(
Carp
strict
File::Find
File::Find::Rule
) ){
   ok( module_is_installed($_),"module [$_] is installed");
}


for( qw(Blartibartfast::S23Kikow::Swe FAABILjhshdf::INcrwr::Marterns::Yes) ){
   ok( !module_is_installed($_),"bogus module [$_] is not installed");
}










