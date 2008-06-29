use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'LEOCHARRE::Dev',
   VERSION_FROM => 'lib/LEOCHARRE/Dev.pm',


   # gen /usr/bin/pmused by Wed Jun 25 10:53:28 EDT 2008 
   PREREQ_PM => {
      'AppConfig::Std'                    => '1.07',
      'Bogus'                             => '0',
      'Carp'                              => '1.04',
      'Cwd'                               => '3.12',
      'Data::Dumper'                      => '2.121_08',
      'Devel::AssertEXE'                  => '0',
      'Devel::ModInfo'                    => '0',
      'Devel::Symdump'                    => '2.07',
      'Exporter'                          => '5.58',
      'ExtUtils::MakeMaker'               => '6.30',
      'File::Basename'                    => '2.74',
      'File::Find'                        => '1.10',
      'File::Find::Rule'                  => '0.30',
      'File::Path'                        => '1.08',
      'HTTP::Request::Common'             => '1.26',
      'HTTP::Status'                      => '1.28',
      'LEOCHARRE::CLI'                    => '1.18',
      'LEOCHARRE::DEBUG'                  => '1.11',
      'LWP::UserAgent'                    => '2.033',
      'Module::Info'                      => '0.3',
      'Net::FTP'                          => '2.75',
      'Smart::Comments'                   => 'v1.0.2',
      'Term::ReadKey'                     => '2.30',
      'Test2'                             => '0',
      'Test::Simple'                      => '0.7',
   },


   EXE_FILES => [qw(bin/cpanupload
		bin/cvs2cl
		bin/devdebug-httpd
		bin/dyercvsinstall
		bin/pinstall
		bin/pmassertexe
		bin/pmassertos
		bin/pmchanges
		bin/pmdistest
		bin/pmhelp
		bin/pminspect
		bin/pmmakefile
		bin/pmmanifest
		bin/pmpod
		bin/pmpodoutline
		bin/pmsubs
		bin/pmtestcheck
		bin/pmtestmake
		bin/pmused
		bin/pmusing
		bin/pmver
		bin/unbleach)],
);


