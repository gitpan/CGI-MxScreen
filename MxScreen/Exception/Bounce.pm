# -*- Mode: perl -*-
#
# $Id: Bounce.pm,v 0.1.1.1 2001/05/30 21:13:41 ram Exp $
#
#  Copyright (c) 1998-2001, Raphael Manfredi
#  Copyright (c) 2000-2001, Christophe Dehaudt
#  
#  You may redistribute only under the terms of the Artistic License,
#  as specified in the README file that comes with the distribution.
#
# HISTORY
# $Log: Bounce.pm,v $
# Revision 0.1.1.1  2001/05/30 21:13:41  ram
# patch1: removed DFEATURE call from stringify hook
#
# Revision 0.1  2001/04/22 17:57:03  ram
# Baseline for first Alpha release.
#
# $EndLog$
#

use strict;

package CGI::MxScreen::Exception::Bounce;

require CGI::MxScreen::Exception;
use vars qw(@ISA);
@ISA = qw(CGI::MxScreen::Exception);

use Carp::Datum;
use Log::Agent;

use overload
	qw("" stringify);

use constant TARGET		=> 0;

#
# ->make			-- defined
#
# Creation routine.
#
# Contains the state and args definition as a blessed ARRAY, indicating to
# the manager where to "bounce".
#
sub make {
	DFEATURE my $f_;
	my $self = bless [], shift;
	my ($target) = @_;

	VERIFY ref $target eq 'ARRAY', "target given as [state, args...]";

	$self->[TARGET] = $target;

	return DVAL $self;
}

sub target		{ $_[0]->[TARGET] }

#
# ->stringify		-- redefined
#
# For display purposes, if they try to stringify us.
#
sub stringify {
	# Can't DFEATURE this routine, or would be a recursive call
	my $self = shift;
	my ($state, @args) = @{$self->target};
	my $state_str = $state;
	$state_str .= "(" . join(', ', @args) . ")" if @args;
	return "bounce exception => $state_str";
}

1;

=head1 NAME

CGI::MxScreen::Exception::Bounce - State bouncing exception

=head1 SYNOPSIS

 # Not meant to be used directly

=head1 DESCRIPTION

This class models a state bouncing exception, generated by calling the
C<bounce()> routine on screens.  It is used internally by C<CGI::MxScreen>.

=head1 AUTHORS

The original authors are
Raphael Manfredi F<E<lt>Raphael_Manfredi@pobox.comE<gt>>
and
Christophe Dehaudt F<E<lt>Christophe.Dehaudt@teamlog.frE<gt>>.

Send bug reports, suggestions, problems or questions to
Jason Purdy F<E<lt>Jason@Purdy.INFOE<gt>>

=head1 SEE ALSO

CGI::MxScreen::Screen(3).

=cut

