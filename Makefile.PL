use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Math::Prime::Simple',
    VERSION_FROM => 'lib/Math/Prime/Simple.pm',
    PREREQ_PM    => { Exporter => 0 },
    ($] >= 5.005 
      ? (ABSTRACT_FROM  => 'lib/Math/Prime/Simple.pm') : ()
    ),
);
