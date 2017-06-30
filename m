Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/30] perf/core improvements and fixes
Date: Fri, 30 Jun 2017 19:24:44 -0300
Message-Id: <20170630222514.11832-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, linux-s390@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 8e70e8409102a37ab066bd91007b75fd5d113931:

  Merge tag 'perf-core-for-mingo-4.13-20170621' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-06-21 20:11:53 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170630

for you to fetch changes up to 644e0840ad4615e032d67adec6ee60f821b669fe:

  perf auxtrace: Add CPU filter support (2017-06-30 11:50:55 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

Intel PT:

- Support "ptwrite" instructio, a way to stuff 32 or 64 bit values into
  the Intel PT trace (Adrian Hunter)

- Support power events in Intel PT to report changes to C-state (Adrian
  Hunter)

- Synthesize Intel PT events as PERF_RECORD_SAMPLE records with a
  perf_event_attr.type (PERF_TYPE_SYNTH) just after the range used by the
  kernel, i.e. right after what is allocated for PMUs, at INT_MAX + 1U,
  attr.config will have the identification for the synthesized event and
  the PERF_SAMPLE_RAW payload will have its fields (Adrian Hunter)

Infrastructure:

- Remove warning() and error(), using instead pr_warning() and
  pr_error(), consolidating error reporting (Arnaldo Carvalho de Melo)

- Add platform dependency to 'perf test 15' (Thomas Richter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (19):
      x86/insn: perf tools: Add new ptwrite instruction
      perf script: Add 'synth' event type for synthesized events
      tools include: Add byte-swapping macros to kernel.h
      perf auxtrace: Add itrace option to output ptwrite events
      perf auxtrace: Add itrace option to output power events
      perf script: Add 'synth' field for synthesized event payloads
      perf script: Add synthesized Intel PT power and ptwrite events
      perf intel-pt: Factor out common code synthesizing event samples
      perf intel-pt: Remove unused instructions_sample_period
      perf intel-pt: Join needlessly wrapped lines
      perf intel-pt: Tidy Intel PT evsel lookup into separate function
      perf intel-pt: Tidy messages into called function intel_pt_synth_event()
      perf intel-pt: Factor out intel_pt_set_event_name()
      perf intel-pt: Move code in intel_pt_synth_events() to simplify attr setting
      perf intel-pt: Synthesize new power and "ptwrite" events
      perf intel-pt: Add example script for power events and PTWRITE
      perf intel-pt: Update documentation to include new ptwrite and power events
      perf intel-pt: Do not use TSC packets for calculating CPU cycles to TSC
      perf auxtrace: Add CPU filter support

Arnaldo Carvalho de Melo (9):
      perf help: Introduce exec_failed() to avoid code duplication
      perf help: Elliminate dup code for reporting
      perf help: Use pr_warning()
      perf config: Use pr_warning()
      perf event-parse: Use pr_warning()
      perf tools: Remove warning()
      perf tools: Replace error() with pr_err()
      perf config: Do not die when parsing u64 or int config values
      perf tools: Kill die()

Colin Ian King (1):
      perf jit: fix typo: "incalid" -> "invalid"

Thomas Richter (1):
      perf tests: Add platform dependency to test 15

 arch/x86/lib/x86-opcode-map.txt                    |   2 +-
 tools/include/linux/kernel.h                       |  35 +-
 tools/objtool/arch/x86/insn/x86-opcode-map.txt     |   2 +-
 tools/perf/Documentation/intel-pt.txt              |  42 +-
 tools/perf/Documentation/itrace.txt                |   8 +-
 tools/perf/Documentation/perf-script.txt           |   6 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        |  12 +
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        |  30 +
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       |  30 +
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-diff.c                          |   5 +-
 tools/perf/builtin-help.c                          |  48 +-
 tools/perf/builtin-kmem.c                          |   4 +-
 tools/perf/builtin-record.c                        |   4 +-
 tools/perf/builtin-report.c                        |   8 +-
 tools/perf/builtin-sched.c                         |   2 +-
 tools/perf/builtin-script.c                        | 205 ++++++-
 tools/perf/builtin-stat.c                          |   4 +-
 tools/perf/builtin-top.c                           |   2 +-
 tools/perf/jvmti/jvmti_agent.c                     |   2 +-
 .../perf/scripts/python/bin/intel-pt-events-record |  13 +
 .../perf/scripts/python/bin/intel-pt-events-report |   3 +
 tools/perf/scripts/python/intel-pt-events.py       | 128 +++++
 tools/perf/tests/attr.c                            |  10 +-
 tools/perf/tests/attr.py                           |  48 ++
 tools/perf/tests/parse-events.c                    |  13 -
 tools/perf/util/auxtrace.c                         |  18 +
 tools/perf/util/auxtrace.h                         |   6 +
 tools/perf/util/config.c                           |  43 +-
 tools/perf/util/config.h                           |   4 +-
 tools/perf/util/data-convert-bt.c                  |   6 +-
 tools/perf/util/event.h                            | 121 ++++
 tools/perf/util/help-unknown-cmd.c                 |   2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  14 +
 .../perf/util/intel-pt-decoder/x86-opcode-map.txt  |   2 +-
 tools/perf/util/intel-pt.c                         | 623 +++++++++++++++------
 tools/perf/util/sort.c                             |  22 +-
 tools/perf/util/trace-event-parse.c                |   4 +-
 tools/perf/util/usage.c                            |  58 --
 tools/perf/util/util.h                             |   4 -
 40 files changed, 1228 insertions(+), 369 deletions(-)
 create mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
 create mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
 create mode 100644 tools/perf/scripts/python/intel-pt-events.py

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
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

  # dm
   1 alpine:3.4: Ok
   2 alpine:3.5: Ok
   3 alpine:3.6: Ok
   4 alpine:edge: Ok
   5 android-ndk:r12b-arm: Ok
   6 archlinux:latest: Ok
   7 centos:5: Ok
   8 centos:6: Ok
   9 centos:7: Ok
  10 debian:7: Ok
  11 debian:8: Ok
  12 debian:9: Ok
  13 debian:experimental: Ok
  14 debian:experimental-x-arm64: Ok
  15 debian:experimental-x-mips: Ok
  16 debian:experimental-x-mips64: Ok
  17 debian:experimental-x-mipsel: Ok
  18 fedora:20: Ok
  19 fedora:21: Ok
  20 fedora:22: Ok
  21 fedora:23: Ok
  22 fedora:24: Ok
  23 fedora:24-x-ARC-uClibc: Ok
  24 fedora:25: Ok
  25 fedora:rawhide: Ok
  26 mageia:5: Ok
  27 opensuse:13.2: Ok
  28 opensuse:42.1: Ok
  29 opensuse:tumbleweed: Ok
  30 ubuntu:12.04.5: Ok
  31 ubuntu:14.04.4: Ok
  32 ubuntu:14.04.4-x-linaro-arm64: Ok
  33 ubuntu:15.10: Ok
  34 ubuntu:16.04: Ok
  35 ubuntu:16.04-x-arm: Ok
  36 ubuntu:16.04-x-arm64: Ok
  37 ubuntu:16.04-x-powerpc: Ok
  38 ubuntu:16.04-x-powerpc64: Ok
  39 ubuntu:16.04-x-powerpc64el: Ok
  40 ubuntu:16.04-x-s390: Ok
  41 ubuntu:16.10: Ok
  42 ubuntu:17.04: Ok
  43 ubuntu:17.10: Ok

  # uname -a
  Linux jouet 4.12.0-rc6+ #3 SMP Tue Jun 27 15:12:38 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: Simple expression parser                   : Ok
   7: PERF_RECORD_* events & perf_sample fields  : Ok
   8: Parse perf pmu format                      : Ok
   9: DSO data read                              : Ok
  10: DSO data cache                             : Ok
  11: DSO data reopen                            : Ok
  12: Roundtrip evsel->name                      : Ok
  13: Parse sched tracepoints fields             : Ok
  14: syscalls:sys_enter_openat event fields     : Ok
  15: Setup struct perf_event_attr               : Ok
  16: Match and link multiple hists              : Ok
  17: 'import perf' in python                    : Ok
  18: Breakpoint overflow signal handler         : Ok
  19: Breakpoint overflow sampling               : Ok
  20: Number of exit events of a simple workload : Ok
  21: Software clock events period values        : Ok
  22: Object code reading                        : Ok
  23: Sample parsing                             : Ok
  24: Use a dummy software event to keep tracking: Ok
  25: Parse with no sample_id_all bit set        : Ok
  26: Filter hist entries                        : Ok
  27: Lookup mmap thread                         : Ok
  28: Share thread mg                            : Ok
  29: Sort output of hist entries                : Ok
  30: Cumulate child hist entries                : Ok
  31: Track with sched_switch                    : Ok
  32: Filter fds with revents mask in a fdarray  : Ok
  33: Add fd to a fdarray, making it autogrow    : Ok
  34: kmod_path__parse                           : Ok
  35: Thread map                                 : Ok
  36: LLVM search and compile                    :
  36.1: Basic BPF llvm compile                    : Ok
  36.2: kbuild searching                          : Ok
  36.3: Compile source for BPF prologue generation: Ok
  36.4: Compile source for BPF relocation         : Ok
  37: Session topology                           : Ok
  38: BPF filter                                 :
  38.1: Basic BPF filtering                      : Ok
  38.2: BPF pinning                              : Ok
  38.3: BPF prologue generation                  : Ok
  38.4: BPF relocation checker                   : Ok
  39: Synthesize thread map                      : Ok
  40: Remove thread map                          : Ok
  41: Synthesize cpu map                         : Ok
  42: Synthesize stat config                     : Ok
  43: Synthesize stat                            : Ok
  44: Synthesize stat round                      : Ok
  45: Synthesize attr update                     : Ok
  46: Event times                                : Ok
  47: Read backward ring buffer                  : Ok
  48: Print cpu map                              : Ok
  49: Probe SDT events                           : Ok
  50: is_printable_array                         : Ok
  51: Print bitmap                               : Ok
  52: perf hooks                                 : Ok
  53: builtin clang support                      : Skip (not compiled in)
  54: unit_number__scnprintf                     : Ok
  55: x86 rdpmc                                  : Ok
  56: Convert perf time to TSC                   : Ok
  57: DWARF unwind                               : Ok
  58: x86 instruction decoder - new instructions : Ok
  59: Intel cqm nmi context read                 : Skip
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_no_newt_O: make NO_NEWT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                 make_perf_o_O: make perf.o
              make_no_libbpf_O: make NO_LIBBPF=1
             make_util_map_o_O: make util/map.o
              make_clean_all_O: make clean all
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_install_O: make install
                  make_debug_O: make DEBUG=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_static_O: make LDFLAGS=-static
                   make_tags_O: make tags
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
                   make_help_O: make help
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_demangle_O: make NO_DEMANGLE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_pure_O: make
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                    make_doc_O: make doc
            make_install_bin_O: make install-bin
           make_no_libunwind_O: make NO_LIBUNWIND=1
         make_install_prefix_O: make install prefix=/tmp/krava
               make_no_slang_O: make NO_SLANG=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libnuma_O: make NO_LIBNUMA=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
