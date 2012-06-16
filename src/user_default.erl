-module(user_default).

-export([make/0, make/1, make_dir/1, make_dir/2, samp/1, pp/1, catch_all/1]).

make() ->
    make([]).

make(Options) ->
    make:all([load, debug_info | Options]).

make_dir(Dir) ->
    make_dir(Dir, []).

make_dir(Dir, Options) ->
    {ok, Old} = file:get_cwd(),
    try
        ok = file:set_cwd(Dir),
        make(Options)
    after
        file:set_cwd(Old)
    end.

pp(Term) ->
    io:format("~w~n", [Term]).

catch_all(Fun) ->
    try Fun()
    catch Type:Reason -> {Type, Reason}
    end.
