# -*- Mode: perl -*-
#
# $Id: Exception.pm,v 0.1 2001/04/22 17:57:03 ram Exp $
#
#  Copyright (c) 1998-2001, Raphael Manfredi
#  Copyright (c) 2000-2001, Christophe Dehaudt
#  
#  You may redistribute only under the terms of the Artistic License,
#  as specified in the README file that comes with the distribution.
#
# HISTORY
# $Log: Exception.pm,v $
# Revision 0.1  2001/04/22 17:57:03  ram
# Baseline for first Alpha release.
#
# $EndLog$
#

use strict;

package CGI::MxScreen::Exception;

use Carp::Datum;
use Log::Agent;

use overload
	qw("" stringify);

#
# ->make		-- deferred
#
sub make {
	logconfess "deferred";
}

#
# ->stringify	-- may be redefined by heirs
#
# For display purposes, if they try to stringify us.
#
sub stringify {
	DFEATURE my $f_;
	my $self = shift;

	my $pkg = ref $self;
	$pkg =~ s/^__PACKAGE__:://;

	return DVAL "CGI::MxScreen exception (type $pkg)";
}

1;

=head1 NAME

CGI::MxScreen::Exception - Mother of all exception classes

=head1 SYNOPSIS

 # Deferred class, meant to be inherited from

=head1 DESCRIPTION

This B<deferred> class is intended to be the common ancestor for all
defined C<CGI::MxScreen> exceptions.

=head1 AUTHORS

Raphael Manfredi F<E<lt>Raphael_Manfredi@pobox.comE<gt>>
and
Christophe Dehaudt F<E<lt>Christophe.Dehaudt@teamlog.frE<gt>>.

=head1 SEE ALSO

CGI::MxScreen::Exception::Bounce(3).

=cut

