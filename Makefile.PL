use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'LEOCHARRE::Dev',
   VERSION_FROM => 'lib/LEOCHARRE/Dev.pm',


   # gen /usr/bin/pmused by Fri Oct 31 10:13:12 EDT 2008 
   PREREQ_PM => {
      'AppConfig::Std'                    => '1.07',
      'Carp'                              => '1',
      'Cwd'                               => '3',
      'Data::Dumper'                      => '2.121_02',
      'Devel::ModInfo'                    => '0.05',
      'Devel::Symdump'                    => '2.0602',
      'Exporter'                          => '5',
      'ExtUtils::MakeMaker'               => '6',
      'File::Basename'                    => '2.73',
      'File::Find'                        => '1.07',
      'File::Find::Rule'                  => '0.30',
      'File::Path'                        => '1.06',
      'Getopt::Std::Strict'               => '1.01',
      'HTTP::Request::Common'             => '1.26',
      'HTTP::Status'                      => '1.28',
      'LEOCHARRE::CLI'                    => '1.19',
      'LEOCHARRE::DEBUG'                  => '1.12',
      'LWP::UserAgent'                    => '2.033',
      'Module::Info'                      => '0.31',
      'Net::FTP'                          => '2.75',
      'Smart::Comments'                   => '1',
      'Term::ReadKey'                     => '2.30',
      'Test::Simple'                      => '0',
      'WWW::CPAN'                         => '0.011',
   },


   EXE_FILES => [qw(bin/cpanupload
		bin/cvs2cl
		bin/devdebug-httpd
		bin/pinstall
		bin/pmassertexe
		bin/pmassertos
		bin/pmchanges
		bin/pmcommit
		bin/pmdistest
		bin/pmhelp
		bin/pminspect
		bin/pmmakefile
		bin/pmmanifest
		bin/pmname
		bin/pmpod
		bin/pmpodoutline
		bin/pmreadme
		bin/pmsubs
		bin/pmtestcheck
		bin/pmtestmake
		bin/pmtodo
		bin/pmused
		bin/pmusing
		bin/pmver
		bin/pmvercpan
		bin/pmverstatus
		bin/unbleach)],
);


