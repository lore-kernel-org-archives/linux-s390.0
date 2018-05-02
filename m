From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/52] perf/core improvements and fixes
Date: Wed,  2 May 2018 12:18:50 -0300
Message-ID: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>, Dave Martin <dave.martin@linaro.org>, David Ahern <dsahern@gmail.com>, "Dr . David Alan Gilbert" <david.gilbert@linaro.org>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kate Stewart <kstewart@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, linux-s390@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <nam>
List-ID: <linux-s390.vger.kernel.org>

Hi Ingo,

	Please consider pulling, done on top of perf/urgent,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit d4652f614f2163a56aee4c03a88af76f98d52161:

  Merge tag 'perf-urgent-for-mingo-4.17-20180425' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-04-26 07:28:29 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180502

for you to fetch changes up to 107cad95ffd81afad295ed5c29d006e525f1f80f:

  perf machine: Ditch find_kernel_function variants (2018-04-30 12:20:54 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf stat: (Jiri Olsa)

- Display time in precision based on std deviation

- Add --table option to display time of each run

- Display length strings of each run for --table option

perf buildid-cache: (Ravi Bangoria)

- Add --list and --purge-all options

perf test: (Hendrik Brueckner)

- Let 'perf test list' display subtests

Core libraries:

- Remove the splitting of maps into MAP__FUNCTION and MAP__VARIABLE.
  It isn't needed, adds complexity, so remove this split in a very granular
  fashion using better ways of detecting if a map is executable, using map->prot,
  etc. More is needed to further untangle map aspects from DSO ones and
  also to have arch specific stuff better isolated.  (Arnaldo Carvalho de Melo)

- Fix spelling mistake: "builid" -> "buildid" in a jitdump error
  message (Colin Ian King)

Build system: (Jiri Olsa)

- Add support to check 2 independent files in check-headers.sh

Documentation: (Takashi Iwai)

- Support for asciidoctor, since 'asciidoc' wasn't so far ported to
  python3 and distros are ditching python2

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (42):
      perf top: Use __map__is_kernel()
      perf symbols: Use __map__is_kernel() instead of ad-hoc equivalent code
      perf dso: Add dso__has_symbols() method
      perf map: Introduce map__has_symbols()
      perf thread: Introduce thread__find_map()
      perf thread: Introduce thread__find_symbol()
      perf script: Use thread__find_symbol() instead of ad-hoc equivalent
      perf thread: Make thread__find_map() return the map
      perf thread: Make thread__find_symbol() return the symbol searched
      perf map: Shorten map_groups__find_by_name() signature
      perf machine: Introduce machine__kernel_maps()
      perf machine: Shorten machine__load_kallsyms() signature
      perf machine: Remove needless map_type from machine__load_vmlinux_path()
      perf tests vmlinux-kallsyms: Use machine__find_kernel_function(_by_name)
      perf tests vmlinux-kallsyms: Use map__for_each_symbol() instead of open coded equivalent
      perf map: Shorten map_groups__find() signature
      perf ui stdio: Use map_groups__fprintf()
      perf symbols: Shorten dso__(first|last)_symbol()
      tools lib symbols: Introduce kallsyms__is_function()
      perf tools: Use kallsyms__is_function()
      perf symbols: Unexport symbol_type__is_a()
      perf map: Remove enum_type arg to map_groups__first()
      perf symbols: Remove map_type arg from dso__find_symbol()
      perf thread: Remove addr_type arg from thread__find_cpumode_addr_location()
      perf machine: Use machine__find_kernel_function() instead of open coded version
      perf thread: Ditch __thread__find_symbol()
      perf thread: Make thread__find_map() search all maps
      perf map: Remove map_type arg from map_groups__find()
      perf symbols: Store the ELF symbol type in the symbol struct
      perf machine: Set PROT_EXEC for executable PERF_RECORD_MMAP records
      perf sort: Use mmap->prot on "dcacheline" formatting
      perf symbols: No need to special case MAP__FUNCTION in fixup
      perf symbols: Use symbol type instead of map->type
      perf map: Use map->prot in place of type==MAP__FUNCTION
      perf symbols: Use map->prot in place of type==MAP__FUNCTION
      perf symbols: Unify symbol maps
      perf symbols: Remove needless goto
      perf symbols: Split kernel symbol processing from dso__load_sym()
      perf symbols: Remove unused dso__load_all_kallsyms() 'map' parameter
      perf symbols: kallsyms__delta() needs the kmap, not the map
      perf symbols: Move split_kallsyms to struct map_groups
      perf machine: Ditch find_kernel_function variants

Colin Ian King (1):
      perf tools: Fix spelling mistake: "builid" -> "buildid"

Hendrik Brueckner (1):
      perf tests: Let 'perf test list' display subtests

Jiri Olsa (5):
      perf check-headers.sh: Simplify arguments passing
      perf check-headers.sh: Add support to check 2 independent files
      perf stat: Display time in precision based on std deviation
      perf stat: Add --table option to display time of each run
      perf stat: Display length strings of each run for --table option

Ravi Bangoria (2):
      perf buildid-cache: Support --list option
      perf buildid-cache: Support --purge-all option

Takashi Iwai (1):
      perf Documentation: Support for asciidoctor

 tools/lib/symbol/kallsyms.c                        |   6 +
 tools/lib/symbol/kallsyms.h                        |   2 +
 tools/perf/Documentation/Makefile                  |  29 ++-
 tools/perf/Documentation/asciidoctor-extensions.rb |  29 +++
 tools/perf/Documentation/perf-buildid-cache.txt    |   7 +-
 tools/perf/Documentation/perf-stat.txt             |  16 ++
 tools/perf/arch/arm/tests/dwarf-unwind.c           |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |   2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   3 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |   2 +-
 tools/perf/builtin-annotate.c                      |   2 +-
 tools/perf/builtin-buildid-cache.c                 |  77 +++++-
 tools/perf/builtin-inject.c                        |   4 +-
 tools/perf/builtin-kallsyms.c                      |   2 +-
 tools/perf/builtin-kmem.c                          |   6 +-
 tools/perf/builtin-report.c                        |  14 +-
 tools/perf/builtin-script.c                        |  30 +--
 tools/perf/builtin-stat.c                          |  92 ++++++-
 tools/perf/builtin-timechart.c                     |   8 +-
 tools/perf/builtin-top.c                           |   7 +-
 tools/perf/builtin-trace.c                         |   9 +-
 tools/perf/check-headers.sh                        |  30 ++-
 tools/perf/tests/builtin-test.c                    |   9 +
 tools/perf/tests/code-reading.c                    |   5 +-
 tools/perf/tests/hists_common.c                    |   6 +-
 tools/perf/tests/mmap-thread-lookup.c              |   7 +-
 tools/perf/tests/vmlinux-kallsyms.c                |  20 +-
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/stdio/hist.c                         |   3 +-
 tools/perf/util/auxtrace.c                         |  12 +-
 tools/perf/util/build-id.c                         |   4 +-
 tools/perf/util/cs-etm.c                           |   4 +-
 tools/perf/util/db-export.c                        |   7 +-
 tools/perf/util/dso.c                              |  34 +--
 tools/perf/util/dso.h                              |  37 +--
 tools/perf/util/event.c                            |  37 ++-
 tools/perf/util/genelf.c                           |   2 +-
 tools/perf/util/intel-bts.c                        |   3 +-
 tools/perf/util/intel-pt.c                         |   8 +-
 tools/perf/util/machine.c                          | 162 +++++-------
 tools/perf/util/machine.h                          |  47 ++--
 tools/perf/util/map.c                              |  99 +++-----
 tools/perf/util/map.h                              |  59 ++---
 tools/perf/util/probe-event.c                      |  29 +--
 tools/perf/util/session.c                          |  13 +-
 tools/perf/util/sort.c                             |   6 +-
 tools/perf/util/srcline.c                          |   1 +
 tools/perf/util/stat.h                             |   3 +-
 tools/perf/util/symbol-elf.c                       | 275 ++++++++++-----------
 tools/perf/util/symbol-minimal.c                   |   3 +-
 tools/perf/util/symbol.c                           | 205 +++++++--------
 tools/perf/util/symbol.h                           |  24 +-
 tools/perf/util/symbol_fprintf.c                   |   4 +-
 tools/perf/util/thread.c                           |  35 ++-
 tools/perf/util/thread.h                           |  13 +-
 tools/perf/util/unwind-libdw.c                     |  23 +-
 tools/perf/util/unwind-libunwind-local.c           |  19 +-
 tools/perf/util/vdso.c                             |   6 +-
 59 files changed, 794 insertions(+), 813 deletions(-)
 create mode 100644 tools/perf/Documentation/asciidoctor-extensions.rb

Test results:

The first ones are container (docker) based builds of tools/perf with
and without libelf support.  Where clang is available, it is also used
to build perf with/without libelf, and building with LIBCLANGLLVM=1
(built-in clang) with gcc and clang when clang and its devel libraries
are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.3.0-15) 7.3.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-15) 7.3.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-12) 7.3.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-12) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.3.0-12) 7.3.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  44 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  45 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  53 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  54 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

[root@seventh ~]# uname -a
Linux seventh 4.17.0-rc3-00005-gfff75eb2a08c #1 SMP Tue May 1 08:50:07 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@seventh ~]# perf test
 1: vmlinux symtab matches kallsyms                       : Ok
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
 4: Read samples using the mmap interface                 : Ok
 5: Test data source output                               : Ok
 6: Parse event definition strings                        : Ok
 7: Simple expression parser                              : Ok
 8: PERF_RECORD_* events & perf_sample fields             : Ok
 9: Parse perf pmu format                                 : Ok
10: DSO data read                                         : Ok
11: DSO data cache                                        : Ok
12: DSO data reopen                                       : Ok
13: Roundtrip evsel->name                                 : Ok
14: Parse sched tracepoints fields                        : Ok
15: syscalls:sys_enter_openat event fields                : Ok
16: Setup struct perf_event_attr                          : Ok
17: Match and link multiple hists                         : Ok
18: 'import perf' in python                               : Ok
19: Breakpoint overflow signal handler                    : Ok
20: Breakpoint overflow sampling                          : Ok
21: Breakpoint accounting                                 : Ok
22: Number of exit events of a simple workload            : Ok
23: Software clock events period values                   : Ok
24: Object code reading                                   : Ok
25: Sample parsing                                        : Ok
26: Use a dummy software event to keep tracking           : Ok
27: Parse with no sample_id_all bit set                   : Ok
28: Filter hist entries                                   : Ok
29: Lookup mmap thread                                    : Ok
30: Share thread mg                                       : Ok
31: Sort output of hist entries                           : Ok
32: Cumulate child hist entries                           : Ok
33: Track with sched_switch                               : Ok
34: Filter fds with revents mask in a fdarray             : Ok
35: Add fd to a fdarray, making it autogrow               : Ok
36: kmod_path__parse                                      : Ok
37: Thread map                                            : Ok
38: LLVM search and compile                               :
38.1: Basic BPF llvm compile                              : Ok
38.2: kbuild searching                                    : Ok
38.3: Compile source for BPF prologue generation          : Ok
38.4: Compile source for BPF relocation                   : Ok
39: Session topology                                      : Ok
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Ok
40.2: BPF pinning                                         : Ok
40.3: BPF prologue generation                             : Ok
40.4: BPF relocation checker                              : Ok
41: Synthesize thread map                                 : Ok
42: Remove thread map                                     : Ok
43: Synthesize cpu map                                    : Ok
44: Synthesize stat config                                : Ok
45: Synthesize stat                                       : Ok
46: Synthesize stat round                                 : Ok
47: Synthesize attr update                                : Ok
48: Event times                                           : Ok
49: Read backward ring buffer                             : Ok
50: Print cpu map                                         : Ok
51: Probe SDT events                                      : Ok
52: is_printable_array                                    : Ok
53: Print bitmap                                          : Ok
54: perf hooks                                            : Ok
55: builtin clang support                                 : Skip (not compiled in)
56: unit_number__scnprintf                                : Ok
57: mem2node                                              : Ok
58: x86 rdpmc                                             : Ok
59: Convert perf time to TSC                              : Ok
60: DWARF unwind                                          : Ok
61: x86 instruction decoder - new instructions            : Ok
62: Use vfs_getname probe to get syscall args filenames   : Ok
63: Check open filename arg using perf trace + vfs_getname: Ok
64: probe libc's inet_pton & backtrace it with ping       : Ok
65: probe libc's inet_pton & backtrace it with ping       : Ok
66: Add vfs_getname probe to get syscall args filenames   : Ok
# 

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_install_O: make install
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_help_O: make help
             make_no_libperl_O: make NO_LIBPERL=1
                   make_pure_O: make
                 make_perf_o_O: make perf.o
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_static_O: make LDFLAGS=-static
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_util_map_o_O: make util/map.o
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_install_prefix_O: make install prefix=/tmp/krava
               make_no_slang_O: make NO_SLANG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_debug_O: make DEBUG=1
              make_no_libbpf_O: make NO_LIBBPF=1
                    make_doc_O: make doc
            make_install_bin_O: make install-bin
              make_no_libelf_O: make NO_LIBELF=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
