use Test::Simple 'no_plan';
use strict;
use lib './lib';
use LEOCHARRE::PMSubs qw(subs_defined _subs_defined _subs_used subs_used);

ok(1);




my $file1  = './t/code1.pm';
my $file2  = './t/code2.pm'; # empty file


my $s1 = subs_defined($file1);
ok($s1,'subs_defined returns');

map { ok($_,"$_") } @$s1;

my $count = scalar @$s1;
ok($count = "count $count");



ok(1,'testing empty file..');
my $s2 = subs_defined($file2);
ok($s2,'subs_defined returns');



my $count2 = scalar @$s2;
ok( !$count2 , "count $count2");





## used...


my $su = subs_used($file1);
ok($su,'subs_used returns');

use Data::Dumper;
print STDERR " \n" . Data::Dumper::Dumper($su) ."\n\n";


for (keys %$su){
   ok($_, "$_: ".$su->{$_});   

}





