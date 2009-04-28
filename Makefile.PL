use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'LEOCHARRE::Dev',
   VERSION_FROM => 'lib/LEOCHARRE/Dev.pm',
   

   # gen /usr/bin/pmused by Fri Mar  6 16:43:53 EST 2009 
   PREREQ_PM => {
      'AppConfig::Std'                    => '1.07',
      'Carp'                              => '1',
      'Cwd'                               => '3',
      'Data::Dumper'                      => '2.121_08',
      'Devel::ModInfo'                    => '0.05',
      'Devel::Symdump'                    => '2.07',
      'Exporter'                          => '5',
      'ExtUtils::MakeMaker'               => '6',
      'File::Basename'                    => '2.74',
      'File::Find'                        => '1.10',
      'File::Find::Rule'                  => '0.30',
      'File::Path'                        => '2.07',
      'Getopt::Std::Strict'               => '1.01',
      'HTTP::Request::Common'             => '1.26',
      'HTTP::Status'                      => '1.28',
      'LEOCHARRE::CLI'                    => '1.18',
      'LEOCHARRE::Class2'                 => '1.16',
      'LEOCHARRE::DEBUG'                  => '1.12',
      'LEOCHARRE::Dir'                    => '1.06',
      'LEOCHARRE::Test'                   => '1.10',
      'LWP::UserAgent'                    => '2.033',
      'Module::Info'                      => '0.3',
      'Net::FTP'                          => '2.75',
      'Smart::Comments'                   => '1',
      'Term::ReadKey'                     => '2.30',
      'Test::Simple'                      => '0',
      'Time::Format'                      => '1.09',
      'WWW::CPAN'                         => '0.011',
   },

   
   LICENSE => 'perl',
   
   
   
   EXE_FILES => [qw(bin/cpanupload
		bin/cvs2cl
		bin/devdebug-httpd
		bin/dyercvsinstall
		bin/pinstall
		bin/pmassertexe
		bin/pmassertos
		bin/pmchanges
		bin/pmcommit
		bin/pmdbhmysql
		bin/pmdistest
		bin/pmdistupdate
		bin/pmfindcode
		bin/pmhelp
		bin/pminspect
		bin/pmlicense
		bin/pmmakefile
		bin/pmmanifest
		bin/pmmanifest.skip
		bin/pmname
		bin/pmpod
		bin/pmpodoutline
		bin/pmreadme
		bin/pmsub
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


