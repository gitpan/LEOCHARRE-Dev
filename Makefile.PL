use ExtUtils::MakeMaker;
WriteMakefile(
	NAME => 'LEOCHARRE::Dev',
	VERSION_FROM => 'lib/LEOCHARRE/Dev.pm',
	PREREQ_PM => {
		'File::Find::Rule' => 0,
      'Module::Info' => 0,
      'LEOCHARRE::CLI' => 0,
      'LEOCHARRE::DEBUG' => '1.02',
	},
	EXE_FILES => [qw(bin/pmused bin/pmver bin/unbleach bin/pmtestcheck bin/pmtestmake bin/pmsubs)],
);
