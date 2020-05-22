import gleam/dynamic.{Dynamic}

external type NoLeak;

pub external fn stdin_read_all() -> Result(String, Dynamic)
  = "gleam_io" "stdin_read_all"

external fn do_print(String) -> NoLeak
  = "io" "fwrite"

pub fn print(string) -> Nil {
  do_print(string)
  Nil
}

pub external type IoDevice

type LiteralIoDevice {
  StandardIo
  StandardError
};

external fn do_write(IoDevice, String, List(String)) -> NoLeak
  = "io" "fwrite"

pub fn stderr() -> IoDevice {
  StandardError |> dynamic.unsafe_coerce
}

pub fn write(string, device) -> Nil {
  do_write(device, string, [])
  Nil
}

external fn erl_display(a) -> Nil =
  "erlang" "display"

/// Print a given value using Erlang syntax and return the value.
///
/// This is useful for runtime debugging of your code that type checks but have
/// unexpected behaviour.
///
/// ## Examples
///
///    display(Ok("Gleam")) // Prints `{ok, <<"Gleam">>}`
///
///    data
///    |> transform
///    |> display // Prints the value at this point in the pipeline
///    |> analyse
///
pub fn display(x: anything) -> anything {
  erl_display(x)
  x
}
