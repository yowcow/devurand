%%%-------------------------------------------------------------------
%% @doc devurand top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(devurand_sup).

-behaviour(supervisor).

-export([start_link/1]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link(Args) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, Args).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init(Args) ->
    SupFlags = #{
                 strategy => one_for_one,
                 intensity => 1,
                 period => 1
                },
    ChildSpecs = [
                  #{
                    id => devurand_svr,
                    start => {devurand_svr, start, Args},
                    restart => permanent
                   }
                 ],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
