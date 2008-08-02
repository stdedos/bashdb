# -*- shell-script -*-
# handle.cmd - gdb-like "handle" debugger command
#
#   Copyright (C) 2002, 2003, 2004, 2005, 2006, 2008 Rocky Bernstein
#   rocky@gnu.org
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

# Process debugger "handle" command. 
_Dbg_do_handle() {
  typeset sig=$1
  typeset cmd=$2
  typeset -i signum
  if [[ -z $sig ]] ; then
    _Dbg_msg "Missing signal name or signal number."
    return 1
  fi

  eval "$_seteglob"
  if [[ $sig == $int_pat ]]; then
    eval "$_resteglob"
    signame=$(_Dbg_signum2name $sig)
    if (( $? != 0 )) ; then
      _Dbg_msg "Bad signal number: $sig"
      return 1
    fi
    signum=sig
  else
    eval "$_resteglob"
    typeset signum;
    signum=$(_Dbg_name2signum $sig)
    if (( $? != 0 )) ; then
      _Dbg_msg "Bad signal name: $sig"
      return 1
    fi
  fi

  case $cmd in
    nop | nopr | nopri | noprin | noprint )
      _Dbg_sig_print[signum]='noprint'
      # noprint implies nostop
      _Dbg_sig_stop[signum]='stop'
      ;;

    nosta | nostac | nostack )
      _Dbg_sig_show_stack[signum]='nostack'
      ;;

    nosto | nostop  )
      _Dbg_sig_stop[signum]='nostop'
      ;;

    p | pr | pri | prin | print )
      _Dbg_sig_print[signum]='print'
      ;;

    sta | stac | stack )
      _Dbg_sig_show_stack[signum]='showstack'
      ;;

    sto | stop )
      _Dbg_sig_stop[signum]='stop'
      # stop keyword implies print
      _Dbg_sig_print[signum]='print'
      ;;
    * )
      if (( !cmd )) ; then 
	_Dbg_msg \
         "Need to give a command: stop, nostop, stack, nostack, print, noprint"
      else
	_Dbg_msg "Invalid handler command $cmd"
      fi
      ;;
  esac
}

