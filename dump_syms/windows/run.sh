#! /bin/bash

regsvr32 /dump_syms/windows/msdia140.dll >/dev/null 2>&1

wine /dump_syms/windows/dump_syms.exe "$1"
