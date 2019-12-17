-module(gleam_io).

-export([stdin_read_all/0]).

stdin_read_all() ->
    do_stdin_read_all([]).

do_stdin_read_all(Acc) ->
    case io:get_line("") of
        Line when is_binary(Line); is_list(Line) -> do_stdin_read_all([Acc | Line]);
        eof -> {ok, iolist_to_binary(Acc)};
        Error = {error, _} -> Error
    end.
