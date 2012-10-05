-module(user_default).

-export([make/0, make/1, make_dir/1, make_dir/2, samp/1, pp/1, pps/1,
         catch_all/1, src/1]).

make() ->
    make([]).

make(Options) ->
    make:all(
      [load, debug_info | Options]
      ++ [{i, "../include"}, {outdir, "../ebin"}]).

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

%% NOTE: This is cheating, those types are defined as opaque by their developers
samp(X) ->
    case X of
        {eqc_gen, _} -> eqc_gen:sample(X);
        {'$type', _} -> proper_gen:sample(X)
    end.

pp(Term) ->
    io:format("~w~n", [Term]).

pps(Term) ->
    io:format("~p~n", [Term]).

catch_all(Fun) ->
    try Fun()
    catch Type:Reason -> {Type, Reason}
    end.

src(Module) -> proplists:get_value(source, Module:module_info(compile)).
