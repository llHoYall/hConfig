# Linux Commands

## chmod

Change the mode of each FILE to MODE.

```
$ chmod [OPTION]... MODE[,MODE]... FILE...
$ chmod [OPTION]... OCTAL-MODE FILE...
$ chmod [OPTION]... --reference=RFILE FIEL...
  -c, --changes         : Like verbose but report only when a change is made
  -f, --silent, --quiet : Suppress most error messages
  -v, --verbose         : Output a diagnostic for every file processed
      --reference=RFILE : Use RFILE's mode instead of MODE values
  -R, --recursive       : Change files and directories recursively
      --help
      --version
```

## chown

Change the owner and/or group of each FILE to OWNER and/or GROUP.

```
$ chown [OPTION]... [OWNER][:[GROUP]] FILE...
$ chown [OPTION]... --reference=RFILE FILE...
  -c, --chages          : Like verbose but report only when a change is made
  -f, --silent, --quiet : Suppress most error messages
  -v, --verbose         : Output a diagnostic for every file processed
      --reference=RFILE : Use RFILE's owner and group rather than specifying OWNER:GROUP values
  -R, --recursive       : Operate on files and directories recursively
  -H                    : If a command line argument is a symbolic link to a directory, traverse it
  -L                    : Traverse every symbolic link to a directory encountered
  -P                    : Do not traverse any symbolic links (DEFAULT)
      --help
      --version
```

## cp

Copy SOURCE to DEST, or multiple SOURCE(S) to DIRECTORY.

```
$ cp [OPTION]... [-T] SOURCE DEST
$ cp [OPTION]... SOURCE... DIRECTORY
$ cp [OPTION]... -t DIRECTORY SOURCE...
  -f, --force         : If an existing destination file cannot be opened, remove it and try again.
  -i, --interative    : Prompt before overwrite.
  -R, -r, --recursive : Copy directories recursively.
      --help
      --version
```

## Curl

```
$ curl [OPTION] [URL]
  > --remote-name / -O : Remote의 file 이름으로 output file을 write한다.
  > --request <COMMAND> / -X <COMMAND> : 명시한 command를 요청한다.
  > --silent / -s : Silent mode.
  > --user / -u : <user:password> 형식으로 사용자 계정을 명시한다.

$ curl --request GET http://127.0.0.1 : GET command를 요청한다.
$ curl -X GET http://127.0.0.1 : GET command를 요청한다.
```

## date

Display the current time in the given FORMAT, or set the system date.

```
$ date [OPTION]... [+FORMAT]
$ date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
[OPTION]
  --help
  --version
[FORMAT]
  %a : locale's abbreviated weekday name
  %A : locale's full weekday name
  %b : locale's abbreviated month name
  %B : locale's full month name
  %c : locale's date and time
  %C : century
  %d : day of month
  %D : date
  %e : space padded day of month
  %F : full date
  %H : hour (0 ~ 23)
  %I : hour (1 ~ 12)
  %j : day of year
  %m : month (1 ~ 12)
  %M : minute (0 ~ 59)
  %n : newline
  %p : locale's equivalent of either AM or PM
  %P : like %p, but lower case
  %s : seconds since 1970-01-01 00:00:00 UTC
  %S : second (0 ~ 60)
  %t : tab
  %T : time
  %u : day of week (1 ~ 7)
  %w : day of week (0 ~ 6)
  %x : locale's date representation
  %X : locale's time representation
  %y : last two digits of year
  %Z : alphabetic time zone abbreviation
By default, date pads numeric fields with zeroes. The following optional flags may follow '%'.
  - : do not padd the field
  _ : pad with spaces
  0 : pad with zeros
  ^ : use upper case
  # : use opposite case
```

## find

Search for files in a directory hierarchy

```
$ find [-H] [-L] [-P] [-Olevel] [-D debugopts] [PATH...] [EXPRESSION]
  -H            : Do not follow symbolic links, except while processing the command line arguments.
  -L            : Follow symbolic links.
  -P            : Never follow symbolic links. (DEFAULT)
  -Olevel       : Enable query optimisation.
    0
    1
    2
    3
  -D debugopts  : Print diagnostic information.
    exec
    help
    opt
    rates
    search
    stat
    tree
  -d, -depth    : Process each directory's contents before the directory itself.
  -name PATTERN : Base of file name matches shell pattern.
  -type C       : File is of type C. To search for more than one type at once, you can supply the combined list of type letters separated by a comma ','.
    b   block (buffered special)
    c   character (unbuffered special)
    d   directory
    p   name pipe (FIFO)
    f   regular file
    l   symbolic link
    s   socket
    D   door (Solaris)
  -help, --help
  -version, --version

Ex)
  $ find -name <TARGET> : 현재 경로 및 하위 경로에서 원하는 file을 찾는다.
  $ find <PATH> -name <TARGET> : 지정한 경로 및 하위 경로에서 file을 찾는다.
  $ find <PATH> -name <TARGET> -type d : 지정한 경로에서 directory를 찾는다.
```

-mtime
-exec

## grep

Search for PATTERN in each FILE.

```
$ grep [OPTION]... PATTERN [FILE]...
  -E, --extended-regexp     : PATTERN is an extended regular expression
  -G, --basic-regexp        : PATTERN is a basic regular expression (DEFAULT)
  -P, --perl-regexp         : PATTERN is a Perl regular expression
  -e, --regexp=PATTERN      : Use PATTERN for matching
  -f, --file=FILE           : Obtain PATTERN from FILE
  -i, --ignore-case         : Ignore case distinctions
  -w, --word-regexp         : Force PATTERN to match only whole words
  -x, --line-regexp         : Force PATTERN to match only whole lines
  -n, --line-number         : Print line number with output lines
  -H, --with-filename       : Print file name with output lines
  -d, --directories=ACTION  : How to handle directories
    read, recurse, skip
  -r, --recursive
  -v, --version
      --help
```

## Head

File의 처음 10 lines를 stdout으로 출력한다.

```
$ head [OPTION] [FILE]

$ head --lines=# <FILE> : File에서 처음 #개의 line을 출력한다.
$ head -n # <FILE> : File에서 처음 #개의 line을 출력한다.
$ head -n -# <FILE> : File에서 마지막 #개의 line을 제외하고 모두 출력한다.
```

## ipcs

Show information on IPC facilities.

```
$ ipcs [RESOURCE-OPTION...] [OUTPUT-OPTION]
$ ipcs -m | -q | -s -i <ID>
  OPTIONS
  -i, --id <ID>     : Print details on resource identified by <ID>
  -h, --help
  -V, --version
  RESOURCE OPTIONS
  -m, --shmems      : Shared memory segments
  -q, --queues      : Message queues
  -s, --semaphores  : Semaphores
  -a, --all         : All (DEFAULT)
  OUTPUT OPTIONS:
  -t, --time        : Show attach, detach and change times
  -p, --pid         : Show PIDs of creator and and last operator
  -l, --limits      : Show resource limits
  -u, --summary     : Show status summary
      --human       : Show sizes in human-readable format
  -b, --bytes       : Show sizes in bytes
```

## jobs

Display status of jobs.

```
$ jobs [-lnprs] [jobspec ...]
$ jobs -x command [args]
  -l  : Lists process IDs in addition to the normal information
  -n  : Lists only processes that have changed status since the last notification
  -p  : Lists process IDs only
  -r  : Restrict output to running jobs
  -s  : Restrict output to stopped jobs
```

## kill

Send a signal to a job.

```
$ kill [-s sigspec | -n signum | -sigspec] pid | jobspec ...
$ kill -l [sigspec]
  -s SIG  : SIG is a signal name
  -n SIG  : SIG is a signal number
  -l, -L  : List the signal names
```

## ln

Create hard links by default, symbolic links with `--symbolic`.

```
$ ln [OPTION]... [-T] TARGET LINK_NAME
$ ln [OPTION]... TARGET
$ ln [OPTION]... TARGET... DIRECTORY
$ ln [OPTION]... -t DIRECTORY TARGET...
  -f, --force       : Remove existing destination files
  -i, --interactive : Prompt whether to remove destinations
  -s, --symbolic    : Make symbolic links instead of hard links
  -v, --verbose     : Print name of each linked file
      --help
      --version
```

## ls

List information about the FILES.

```
$ ls [OPTIONS]... [FILE]...
  -a, --all             : Don't ignore entries starting with .
  -A, --almost-all      : Don't list implied . and ..
  -d, --directory       : List directories themselves, not their contents
  -h, --human-readable  : With -l and/or -s, print human readable sizes
      --si              : Use power of 1000 not 1024
  -l                    : Use a long listing format
      --help
      --version
```

## mkdir

Create the directory(ies), if they do not already exist.

```
$ mkdir [OPTION]... DIRECTORY...
  -m, --mode=MODE : Set file mode (as in chmod)
  -p, --parents   : No error if existing, make parent directories as neede
  -v, --verbose   : Print a message for each created directory
      --help
      --version
```

## ping

Send ICMP ECHO_REQUEST to network hosts.

```
$ ping [-aAbBdDfhLnOqrRUvV46] [-c COUNT] [-F FLOWLABEL] [-i INTERVAL] [-I INTERFACE] [-l PRELOAD] [-m MARK] [-M          PMTUDISC_OPTION] [-N NODEINFO_OPTION] [-w DEADLINE] [-W TIMEOUT] [-p PATTERN] [-Q TOS] [-s PACKETSIZE]  [-S SNDBUF] [-t TTL] [-T TIMESTAMP_OPTION] [hop ...] DESTINATION
```

## ps

Report a snapshot of the current processes.

```
$ ps [OPTION]
  -A, -e    : Select all processes.
  -a        : Select all processes except both session leaders and processes not associated with a terminal.

Ex)
  To see every process on the system using standard syntax
    $ ps [-e | -ef | -eF | -elY]
  To see every process on the system using BSD syntax
    $ ps [ax | aux]
  To print a process tree
    $ ps [-ejH | axjf]
  To get info about threads
    $ ps [-eLf | axms]
  To get security info
    $ ps [-eo euser,ruser,suser,fuser,f,comm,label | -eM | axZ]
```

## pwd

Print the name of the current working directory.

```
$ pwd [OPTION]
  -L : Print the value of $PWD if it names the current working directory (DEFAULT)
  -P : Print the physical directory, without any symbolic links
```

## Tail

File의 마지막 10 lines를 stdout으로 출력한다.

```
$ tail [OPTION] [FILE]

$ tail --lines=# <FILE> : File에서 마지막 #개의 line을 출력한다.
$ tail -n # <FILE> : File에서 마지막 #개의 line을 출력한다.
$ tail -n +# <FILE> : File에서 처음 #개의 line을 제외하고 모두 출력한다.
```

## tar

GNU `tar` saves many files together into a single tape or disk archive, and can restore individual files from the archive.

```
$ tar [OPTION...] [FILE]...
Main Operation Mode
  -c, --create                    : Create a new archive
  -x, --extract, --get            : extract files from an archive
Device Selection and Switching
  -f, --file=ARCHIVE              : Use archive file or device ARCHIVE
Compression Options
  -z, --gzip, --gunzip, --ungzip  : Filter the archive through gzip
Informative Output
  -v, --verbose                   : Verbosely list files processed
Other Options
  -?, --help
      --usage
      --version
Ex)
  $ tar -cvzf <FILE...>
  $ tar -xvzf <FILE...>
```


## Wget

Non-interactive network retriever.

```
$ wget [OPTION] [URL]
  > --quiet / -q : Quiet mode.
  > --password=<PASSWORD> : Password를 설정한다.
```

## whoami

Print the user name associated with the current effective user ID.

```
$ whoami [OPTION]
  --help
  --version
```
