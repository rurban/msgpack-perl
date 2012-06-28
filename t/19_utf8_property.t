#!perl
use strict;
use warnings;

use Test::More ($] < 5.008 ? (skip_all => "need 5.8 for Encode") : ());
use Data::MessagePack;
use Encode qw(encode decode);
{
    use utf8;
    my $mp = Data::MessagePack->new;

    isnt $mp->unpack( $mp->pack('はろー！メッセージパック！') ),
       'はろー！メッセージパック！';

    $mp->utf8(1);
    is $mp->unpack( $mp->pack('はろー！メッセージパック！') ),
       'はろー！メッセージパック！';
}

{
    my $mp = Data::MessagePack->new()->utf8();
    my $latin1 = chr(233); # eacute

    my $s = $mp->unpack( $mp->pack($latin1) );
    is $s, $latin1;
    is ord($s), ord($latin1);
}


done_testing;

