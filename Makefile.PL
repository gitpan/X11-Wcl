#!/usr/bin/perl

use ExtUtils::MakeMaker;

WriteMakefile(
	'INC'		=>	'-I/usr/local/include',
	'LIBS'		=>	['-L/usr/X11R6/lib -lXmp -lWc -lXm -lXt -lX11'],
#	'LINKTYPE'	=>	'static',
	'NAME'		=>	'X11::Wcl',
	'OBJECT'	=>	'Wcl_wrap.o',
	'OPTIMIZE'	=>	'-O',
	'PM'		=>	{'Wcl.pm' => '$(INST_LIBDIR)/Wcl.pm'},
	'VERSION'	=>	'0.1',
	'clean'	=>	{FILES => 'Wcl.i Wcl.pm Wcl_wrap.c Wcl_wrap.html'},
);

sub MY::postamble
{
	<<\EOF;
Wcl.pm : Wcl_wrap.c
Wcl_wrap.c : Wcl-i Wcl-i2 Wcl-pm Wcl-gen
	cat Wcl-i >Wcl.i
	$(FULLPERL) Wcl-gen >>Wcl.i
	cat Wcl-i2 >>Wcl.i
	swig -package 'X11::Wcl' -module 'Wcl' -perl5 -dhtml -shadow Wcl.i
	cat Wcl-pm >> Wcl.pm
	perl -p -i -e 's#package Wcl;#package X11::Wcl;#' Wcl.pm
	perl -p -i -e 's#bootstrap Wcl;#bootstrap X11::Wcl;#' Wcl.pm
	perl -p -i -e 's#boot_Wcl#boot_X11__Wcl#' Wcl_wrap.c
EOF
}
