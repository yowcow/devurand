-module(devurand).

-export([read/2]).

-type format() :: binary | hex.
-type output() :: {ok, term()} | devurand_svr:output().

-spec read(format(), integer()) -> output().
read(binary, Bytes) ->
    devurand_svr:read(Bytes);
read(hex, Bytes) ->
    to_hex(devurand_svr:read(Bytes)).

-spec to_hex(devurand_svr:output()) -> output().
to_hex({ok, Data}) ->
    {ok, to_hex(Data, <<>>)};
to_hex(Error) ->
    Error.

-spec to_hex(binary(), binary()) -> binary().
to_hex(<<>>, Acc) ->
    Acc;
to_hex(<<X:4, Y:4, T/binary>>, Acc) ->
    A = hex(X),
    B = hex(Y),
    to_hex(T, <<Acc/binary, A/binary, B/binary>>).

-spec hex(integer()) -> binary().
hex(0) -> <<"0">>;
hex(1) -> <<"1">>;
hex(2) -> <<"2">>;
hex(3) -> <<"3">>;
hex(4) -> <<"4">>;
hex(5) -> <<"5">>;
hex(6) -> <<"6">>;
hex(7) -> <<"7">>;
hex(8) -> <<"8">>;
hex(9) -> <<"9">>;
hex(10) -> <<"a">>;
hex(11) -> <<"b">>;
hex(12) -> <<"c">>;
hex(13) -> <<"d">>;
hex(14) -> <<"e">>;
hex(15) -> <<"f">>.
