%%%-------------------------------------------------------------------
%% @doc devurand public API
%% @end
%%%-------------------------------------------------------------------

-module(devurand_app).

-behaviour(application).

-export([
         start/2,
         stop/1
        ]).

-define(APP_NAME, devurand).

start(_StartType, _StartArgs) ->
    Path = application:get_env(?APP_NAME, path, "/dev/urandom"),
    devurand_sup:start_link([
                             [{path, Path}]
                            ]).

stop(_State) ->
    ok.

%% internal functions
