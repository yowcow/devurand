-module(devurand_svr).

-behavior(gen_server).

-export([
         init/1,
         terminate/2,
         handle_call/3,
         handle_cast/2,
         handle_info/2
        ]).

-export([
         start/1,
         stop/0,
         read/1
        ]).

-export_type([
              output/0
             ]).

-type output() :: {ok, binary()}
                | eof
                | {error, term()}.

-define(config(K, L), proplists:get_value(K, L, undefined)).

init(Args) ->
    {ok, Device} = file:open(?config(path, Args), [read, binary]),
    {ok, #{device => Device}}.

terminate(
  _,
  #{device := Device}
 ) ->
    file:close(Device).

handle_call(
  {read, Bytes},
  _From,
  #{device := Device} = State
 ) ->
    {reply, file:read(Device, Bytes), State}.

handle_cast(Req, State) ->
    logger:notice("(unhandled handle_cast) req: ~p, state: ~p", [Req, State]),
    {noreply, State}.

handle_info(Req, State) ->
    logger:notice("(unhandled handle_info) req: ~p, state: ~p", [Req, State]),
    {noreply, State}.

%% API
-spec start(proplists:proplist()) -> ignore
                                   | {error, term()}
                                   | {ok, pid()}.
start(Args) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).

-spec stop() -> ok.
stop() ->
    gen_server:stop(?MODULE).

-spec read(integer()) -> output().
read(Bytes) ->
    gen_server:call(?MODULE, {read, Bytes}).
