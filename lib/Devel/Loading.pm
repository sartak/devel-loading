package Devel::Loading;

sub import {
    my $class = shift;
    my $code  = shift;

    if ($code) {
        my $old_code = $code;
        $code = sub {
            local $_ = $_[1];
            $old_code->($_[1]);
            return undef;
        };
    }
    else {
        $code = sub {
            my @caller = caller;
            warn "$_[1] at $caller[1] line $caller[2]\n";
            return undef;
        };
    }

    unshift @INC, $code;
}

1;

__END__

=head1 NAME

Devel::Loading - Run code before each module is loaded

=head1 SYNOPSIS

    perl -MDevel::Loading -Mbase -e0
        base.pm at - line 0
        strict.pm at /opt/local/lib/perl5/5.8.8/base.pm line 3
        vars.pm at /opt/local/lib/perl5/5.8.8/base.pm line 4
        warnings/register.pm at /opt/local/lib/perl5/5.8.8/vars.pm line 7
        warnings.pm at /opt/local/lib/perl5/5.8.8/warnings/register.pm line 24
        Carp.pm at /opt/local/lib/perl5/5.8.8/warnings.pm line 134
        Exporter.pm at /opt/local/lib/perl5/5.8.8/Carp.pm line 193


    use Devel::Loading sub { die "I can't load $_!" if /$RE{profanity}/ };

=head1 DESCRIPTION

Putting coderefs into C<@INC> is pretty sick and wrong. But sometimes you just
need to know, you know?

=head1 CAVEATS

Other modules that prepend things to C<@INC> (such as L<lib>) won't have their
loading announced. Perhaps some XS is in order. Then again, am I evil enough to
tie C<@INC>? Stay tuned.

Multiple C<Devel::Loading> hooks may be present in C<@INC>. This is a feature!

=head1 AUTHOR

Shawn M Moore, C<< <sartak@bestpractical.com> >>

=head1 SEE ALSO

L<Devel::Loaded>

=cut

