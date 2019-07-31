#!/usr/bin/env bash
#pushes errors to stderr
echoerr() { echo "$@" 1>&2; }
#handles the case of arguments not being set correctly and spitting out help
badopt() { echoerr "$@"; help='true'; }
#handles validating the argument and setting it, if it isn't set sends the arguments to error
opt() { if [[ -z $2 ]]; then badopt "$1 flag must be followed by an argument"; fi; export $1="$2"; }
#handles ensuring arguments are set that are required
required_args() { for arg in $@; do if [[ -z "${!arg}" ]]; then badopt "$arg is a required argument"; fi; done; }

#handles the arguments
message="default"
while [[ $# -gt 0 ]]; do
  arg="$1"
  case $arg in
    --allowance|-a)  shift; opt allowance "$1"; shift;;
    --message|-m)    shift; opt message "$1"; shift;;
    --help|-h)              opt help true; shift;;
    *) shift;;
  esac
done

#if we are not in a help situation, ensures the arguments are set that are required
if [[ -z $help ]]; then
  required_args allowance
fi

if [[ -n $help ]]; then
  echoerr "Usage: $0"
  echoerr "    -a, --allowance    <allowance>   The allowance we are giving"
  echoerr "    -m  --message      <message>     The message to set"
  echoerr "    -h, --help"
  exit 1
fi

echo "Allowance is set as $allowance"
echo "Messsage is $message"
