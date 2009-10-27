#require 'irb/completion'
#ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
require 'rubygems'
require 'pp'
# wirble is a wonderful gem which add nice features to irb
begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

IRB.conf[:AUTO_INDENT]=true

puts "\n==============================================================="
puts "== Welcome Rob. Here is some useful information..."
puts "==============================================================="
puts "You are running ruby version #{RUBY_VERSION}"
puts "\n\$LOAD_PATH (which can also be accessed via $\") is:"
puts "==============================================================="
pp $LOAD_PATH.sort
puts ""
RUBY_GLOBALS =<<-HERE
  ------------------------------
  - Ruby pre-defined variables -
  ------------------------------
  
  $!         exception information message set by 'raise'.
  $@         Array of backtrace of the last exception thrown.
  
  -----------
  $&         string matched by the last successful pattern match in this scope.
  $`         string to the left of the last successful match.
  $'         string to the right of the last successful match.
  $+         last bracket matched by the last successful match.
  $1 to $9   Nth group of the last successful regexp match.
  $~         information about the last match in the current scope.
  
  -----------
  $=         flag for case insensitive, nil by default.
  $/         input record separator, newline by default.
  $\         output record separator for the print and IO#write. Default is nil.
  $,         output field separator for the print and Array#join.
  $;         default separator for String#split.
  
  -----------
  $.         current input line number of the last file that was read.
  $<         virtual concatenation file of the files given on command line.
  $>         default output for print, printf. $stdout by default.
  $_         last input line of string by gets or readline.
  
  -----------
  $0         Contains the name of the script being executed. May be assignable.
  $*         Command line arguments given for the script sans args.
  $$         process number of the Ruby running this script.
  $?         status of the last executed child process.
  $:         Load path for scripts and binary modules by load or require.
  
  -----------
  $"         array contains the module names loaded by require.
  $DEBUG     status of the -d switch.
  $FILENAME  Current input file from $<. Same as $<.filename.
  $LOAD_PATH alias to the $:.
  $stderr    current standard error output.
  $stdin     current standard input.
  $stdout    current standard output.
  $VERBOSE   verbose flag, which is set by the -v switch.
  $-0        alias to $/.
  $-a        True if option -a ("autosplit" mode) is set. Read-only variable.
  $-d        alias to $DEBUG.
  $-F        alias to $;.
  $-i        If in-place-edit mode is set, this variable holds the extension,
  otherwise nil.
  $-I        alias to $:.
  $-l        True if option -l is set ("line-ending processing" is on).
  Read-only variable.
  $-p        True if option -p is set ("loop" mode is on). Read-only variable.
  $-v        alias to $VERBOSE.
  $-w        True if option -w is set.

        HERE
puts RUBY_GLOBALS
puts "\n==============================================================="
puts 'pp $LOADED_FEATURES.sort to get more information on loaded stuff'
puts 'pp ENV.sort for your env...duh!'

