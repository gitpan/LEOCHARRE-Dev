use ExtUtils::MakeMaker;
WriteMakefile(
	NAME => 'LEOCHARRE::Dev',
	VERSION_FROM => 'lib/LEOCHARRE/Dev.pm',

   PREREQ_PM => {
      'File::Find::Rule' => '0.30',
      'Data::Dumper' => '2.121',
      'Devel::Symdump' => '2.06',
      'Exporter' => '5.58',
      'LEOCHARRE::Class::Accessors' => '0',
      'Cwd' => '3.01',
      'Module::Info' => 0,
      'Smart::Comments' => 0,
   },
   
	EXE_FILES => [qw(
bin/pmused 
bin/pmver 
bin/unbleach 
bin/pmtestcheck 
bin/pmtestmake 
bin/pmsubs 
bin/pminspect 
bin/pinstall 
bin/pmhelp
bin/pmusing
bin/devdebug-httpd
)],
);
