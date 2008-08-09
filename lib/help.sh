# dbg-help.sh - Bourne Again Shell Debugger Help Routines

#   Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008
#   Rocky Bernstein rocky@gnu.org
#
#   bashdb is free software; you can redistribute it and/or modify it under
#   the terms of the GNU General Public License as published by the Free
#   Software Foundation; either version 2, or (at your option) any later
#   version.
#
#   bashdb is distributed in the hope that it will be useful, but WITHOUT ANY
#   WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#   for more details.
#   
#   You should have received a copy of the GNU General Public License along
#   with bashdb; see the file COPYING.  If not, write to the Free Software
#   Foundation, 59 Temple Place, Suite 330, Boston, MA 02111 USA.

typeset -r _Dbg_set_cmds="args annotate autoeval basename debugger editing linetrace listsize prompt showcommand trace-commands"
typeset -r _Dbg_show_cmds="args annotate autoeval basename debugger commands copying debugger directories linetrace listsize prompt trace-commands warranty"

_Dbg_help_set() {
  local -r set_cmd=$1
  local label=$2

  if [[ -z $set_cmd ]] ; then 
      local thing
      for thing in $_Dbg_set_cmds ; do 
	_Dbg_help_set $thing 1
      done
      return
  fi

  case $set_cmd in 
    ar | arg | args )
      [[ -n $label ]] && label='set args -- '
      _Dbg_msg \
"${label}Set argument list to give program being debugged when it is started.
Follow this command with any number of args, to be passed to the program."
      return 0
      ;;
    an | ann | anno | annot | annota | annotat | annotate )
      if [[ -n $label ]] ; then 
	label='set annotate  -- '
      else
	local post_label='
0 == normal;     1 == fullname (for use when running under emacs).'
      fi
      _Dbg_msg \
"${label}Set annotation level.$post_label"
      return 0
      ;;
    au | aut | auto | autoe | autoev | autoeva | autoeval )
      [[ -n $label ]] && label='set autoeval  -- '
      local onoff="off."
      (( $_Dbg_autoeval != 0 )) && onoff='on.'
      _Dbg_msg \
"${label}Evaluate unrecognized commands is" $onoff
      return 0
      ;;
    b | ba | bas | base | basen | basena | basenam | basename )
      [[ -n $label ]] && label='set basename  -- '
      local onoff="off."
      (( $_Dbg_basename_only != 0 )) && onoff='on.'
      _Dbg_msg \
"${label}Set short filenames (the basename) in debug output is" $onoff
      return 0
      ;;
    d|de|deb|debu|debug|debugg|debugger|debuggi|debuggin|debugging )
      local onoff=${1:-'on'}
      [[ -n $label ]] && label='set debugger  -- '
      (( $_Dbg_debug_debugger )) && onoff='on.'
     _Dbg_msg \
"${label}Set debugging the debugger is" $onoff
      return 0
      ;;
    e | ed | edi | edit | editi | editin | editing )
      [[ -n $label ]] && label='set editing   -- '
      local onoff="off."
      (( $_Dbg_edit )) && onoff='on.'
      _Dbg_msg \
"${label}Set editing of command lines as they are typed is" $onoff
      ;;
    lin | line | linet | linetr | linetra | linetrac | linetrace )
      [[ -n $label ]] && label='set linetrace -- '
      local onoff='off.'
      (( $_Dbg_linetrace )) && onoff='on.'
     _Dbg_msg \
"${label}Set tracing execution of lines before executed is" $onoff
      if (( $_Dbg_linetrace )) ; then
	  _Dbg_msg \
"set linetrace delay -- delay before executing a line is" $_Dbg_linetrace_delay
      fi
      return 0
      ;;
     lis | list | lists | listsi | listsiz | listsize )
      [[ -n $label ]] && label='set listsize  -- '
      _Dbg_msg \
"${label}Set number of source lines bashdb will list by default."
      ;;
    p | pr | pro | prom | promp | prompt )
      [[ -n $label ]] && label='set prompt    -- '
      _Dbg_msg \
"${label}bashdb's prompt is:\n" \
"      \"$_Dbg_prompt_str\"."
      return 0
      ;;
    sho|show|showc|showco|showcom|showcomm|showcomma|showcomman|showcommand )
      [[ -n $label ]] && label='set showcommand -- '
      _Dbg_msg \
"${label}Set showing the command to execute is $_Dbg_show_command."
      return 0
      ;;
    t|tr|tra|trac|trace|trace-|tracec|trace-co|trace-com|trace-comm|trace-comma|trace-comman|trace-command|trace-commands )
      [[ -n $label ]] && label='set trace-commands -- '
      _Dbg_msg \
"${label}Set showing debugger commands is $_Dbg_trace_commands."
      return 0
      ;;
    * )
      _Dbg_msg \
"There is no \"set $set_cmd\" command."
  esac
}

_Dbg_help_show() {
  local -r show_cmd=$1

  if [[ -z $show_cmd ]] ; then 
      local thing
      for thing in $_Dbg_show_cmds ; do 
	_Dbg_help_show $thing 1
      done
      return
  fi

  case $show_cmd in 
    ar | arg | args )
      _Dbg_msg \
"show args        -- Show argument list to give program being debugged when it 
                    is started"
      return 0
      ;;
    an | ann | anno | annot | annota | annotat | annotate )
      _Dbg_msg \
"show annotate    -- Show annotation_level"
      return 0
      ;;
    au | aut | auto | autoe | autoev | autoeva | autoeval )
      _Dbg_msg \
"show auotoeval    -- Show if we evaluate unrecognized commands"
      return 0
      ;;
    b | ba | bas | base | basen | basena | basenam | basename )
      _Dbg_msg \
"show basename    -- Show if we are are to show short or long filenames"
      return 0
      ;;
    com | comm | comma | comman | command | commands )
      _Dbg_msg \
"show commands [+|n] -- Show the history of commands you typed.
You can supply a command number to start with, or a + to start after
the previous command number shown. A negative number indicates the 
number of lines to list."
      ;;
    cop | copy| copyi | copyin | copying )
      _Dbg_msg \
"show copying     -- Conditions for redistributing copies of debugger"
     ;;
    d|de|deb|debu|debug|debugg|debugger|debuggi|debuggin|debugging )
     _Dbg_msg \
"show debugger    -- Show if we are set to debug the debugger"
      return 0
      ;;
    di|dir|dire|direc|direct|directo|director|directori|directorie|directories)
      _Dbg_msg \
"show directories -- Show if we are set to debug the debugger"
      ;;
    lin | line | linet | linetr | linetra | linetrac | linetrace )
      _Dbg_msg \
"show linetrace   -- Show whether to trace lines before execution"
      ;;
    lis | list | lists | listsi | listsiz | listsize )
      _Dbg_msg \
"show listsize    -- Show number of source lines debugger will list by default"
      ;;
    p | pr | pro | prom | promp | prompt )
      _Dbg_msg \
"show prompt      -- Show debugger's prompt"
      return 0
      ;;
    t|tr|tra|trac|trace|trace-|trace-c|trace-co|trace-com|trace-comm|trace-comma|trace-comman|trace-command|trace-commands )
      _Dbg_msg \
"show trace-commands -- Show if we are echoing debugger commands"
      return 0
      ;;
    w | wa | war | warr | warra | warran | warrant | warranty )
      _Dbg_msg \
"show warranty    -- Various kinds of warranty you do not have"
      return 0
      ;;
    * )
      _Dbg_msg \
    "Undefined show command: \"$show_cmd\".  Try \"help show\"."
  esac
}

# This is put at the so we have something at the end to stop at 
# when we debug this. By stopping at the end all of the above functions
# and variables can be tested.
typeset -r _Dbg_help_ver=\
'$Id: help.sh,v 1.1 2008/08/08 21:17:30 rockyb Exp $'

#;;; Local Variables: ***
#;;; mode:shell-script ***
#;;; End: ***