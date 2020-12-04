%%%-------------------------------------------------------------------
%% @doc devurand public API
%% @end
%%%-------------------------------------------------------------------

-module(devurand_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    devurand_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
