-module(user_default).

-export([make/0, make/1, make_dir/1, make_dir/2, cd_test/1, cd_test/2, samp/1,
         pp/1]).

make() ->
	make([]).

make(Options) ->
	make:all([load | Options]).

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

cd_test(App) ->
    cd_test(eqc, App).

cd_test(Type, App) ->
    file:set_cwd(
      io_lib:format("~p/trunk/src/test/~s", [App, format_type(Type)])),
    element(2, file:get_cwd()).

format_type(eqc) ->
    "quickcheck";
format_type(eunit) ->
    "eunit".

samp(X) ->
    eqc_gen:sample(X).

pp(Term) ->
    io:format("~w~n", [Term]).
