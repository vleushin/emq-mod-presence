%%--------------------------------------------------------------------
%% Copyright (c) 2016 Feng Lee <feng@emqtt.io>.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emq_mod_presence_app).

-behaviour(application).

-export([start/2, stop/1]).

-behaviour(supervisor).

-export([init/1]).

start(_Type, _Args) ->
    if_enabled(fun emq_mod_presence:load/1),
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop(_State) ->
    if_enabled(fun emq_mod_presence:unload/1).

%% Dummy supervisor
init([]) ->
	{ok, {{one_for_one, 1, 5}, []}}.

if_enabled(Fun) ->
    case application:get_env(emq_mod_presence, enable, false) of
        true  -> Fun(application:get_all_env(emq_mod_presence));
        false -> ok
    end.

