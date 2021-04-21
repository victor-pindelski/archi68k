# README

## Description

Download the contents of the repository, extract the files from `TP_68000_Ubuntu64.tar.gz` at the root of the repository.
Then you can assemble the code with the provided make files. To launch the debugger from the root of the repository :
`./68000/d68k.sh <filename>` (`filename` is optional).

## Bugs

On opening the debugger :
```
<PATH>: error while loading shared libraries: libQt5Widgets.so.5: cannot open shared object file: No such file or directory
```

Solution :
```
$ sudo apt-get install libqt5widgets5
```
