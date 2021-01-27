-module(devurand).

-export([read/2]).

-type format() :: binary | hex.
-type output() :: binary().

-spec read(format(), integer()) -> output().
read(binary, Bytes) ->
    case devurand_svr:read(Bytes) of
        {ok, Bin} -> Bin;
        Err -> throw(Err)
    end;
read(hex, Bytes) ->
    case devurand_svr:read(Bytes) of
        {ok, Bin} -> to_hex(Bin);
        Err -> throw(Err)
    end.

-spec to_hex(binary()) -> binary().
to_hex(Bin) ->
    to_hex_acc(Bin, <<>>).

-spec to_hex_acc(binary(), binary()) -> binary().
to_hex_acc(<<>>, Acc) ->
    Acc;
to_hex_acc(<<X:4, Y:4, T/binary>>, Acc) ->
    A = hex(X),
    B = hex(Y),
    to_hex_acc(T, <<Acc/binary, A/binary, B/binary>>).

-spec hex(integer()) -> binary().
hex(0)  -> <<"0">>;
hex(1)  -> <<"1">>;
hex(2)  -> <<"2">>;
hex(3)  -> <<"3">>;
hex(4)  -> <<"4">>;
hex(5)  -> <<"5">>;
hex(6)  -> <<"6">>;
hex(7)  -> <<"7">>;
hex(8)  -> <<"8">>;
hex(9)  -> <<"9">>;
hex(10) -> <<"a">>;
hex(11) -> <<"b">>;
hex(12) -> <<"c">>;
hex(13) -> <<"d">>;
hex(14) -> <<"e">>;
hex(15) -> <<"f">>.


-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

to_hex_test_() ->
    Cases = [
             {
              "empty binary",
              <<>>,
              <<>>
             },
             {
              "ordered binary",
              <<1, 2, 255, 254>>,
              <<"0102fffe">>
             }
            ],
    F = fun({Title, Input, Expected}) ->
                Actual = to_hex(Input),
                {Title, ?_assertEqual(Expected, Actual)}
        end,
    lists:map(F, Cases).

-endif.
