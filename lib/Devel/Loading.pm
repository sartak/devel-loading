package Devel::Loading;

sub import {
    my $class = shift;
    my $code  = shift;

    if ($code) {
        my $old_code = $code;
        $code = sub { local $_ = $_[1]; $old_code->($_[1]); undef };
    }
    else {
        $code = sub {
            my @caller = caller;
            warn "$_[1] at $caller[1] line $caller[2]\n";
            undef
        };
    }

    unshift @INC, $code;
}

1;

