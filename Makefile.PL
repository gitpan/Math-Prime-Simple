use ExtUtils::MakeMaker;

WriteMakefile(
    DISTNAME     => 'Math-Prime-Simple',
    NAME         => 'Math::Prime::Simple',
    VERSION_FROM => 'lib/Math/Prime/Simple.pm',
    PREREQ_PM    => { Exporter => 0 },
    'dist'       => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    ($] >= 5.005 ?  
       (ABSTRACT_FROM  => 'lib/Math/Prime/Simple.pm',
        AUTHOR         => 'Steven Schubiger') : ()),
);
