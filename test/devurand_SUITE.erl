-module(devurand_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

%% ct callbacks
-export([
         init_per_testcase/2,
         end_per_testcase/2,
         all/0
        ]).

%% testcase
-export([
         read_binary_1_byte/1,
         read_binary_2_bytes/1,
         read_binary_4_bytes/1,
         read_hex_1_byte/1,
         read_hex_2_bytes/1,
         read_hex_4_bytes/1
        ]).

init_per_testcase(_, Config) ->
    Args = [
            {path, ?config(data_dir, Config)++"example-urandom"}
           ],
    {ok, Pid} = devurand_svr:start(Args),
    [{devurand_svr, Pid}|Config].

end_per_testcase(_, _) ->
    ok = devurand_svr:stop(),
    ok.

all() ->
    [
     read_binary_1_byte,
     read_binary_2_bytes,
     read_binary_4_bytes,
     read_hex_1_byte,
     read_hex_2_bytes,
     read_hex_4_bytes
    ].

read_binary_1_byte(_) ->
    Bin = devurand:read(binary, 1),
    ?assertEqual(<<190>>, Bin).

read_binary_2_bytes(_) ->
    Bin = devurand:read(binary, 2),
    ?assertEqual(<<190, 113>>, Bin).

read_binary_4_bytes(_) ->
    Bin = devurand:read(binary, 4),
    ?assertEqual(<<190, 113, 76, 205>>, Bin).

read_hex_1_byte(_) ->
    Bin = devurand:read(hex, 1),
    ?assertEqual(<<"be">>, Bin).

read_hex_2_bytes(_) ->
    Bin = devurand:read(hex, 2),
    ?assertEqual(<<"be71">>, Bin).

read_hex_4_bytes(_) ->
    Bin = devurand:read(hex, 4),
    ?assertEqual(<<"be714ccd">>, Bin).
