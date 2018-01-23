From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/43] perf/core improvements and changes
Date: Tue, 23 Jan 2018 10:12:08 -0300
Message-ID: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Petlan <mpetlan@redhat.com>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Tor Jeremiassen <tor@ti.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit a72594ca5c70ef4a94fab8ad541beda0d0a94139:

  Merge tag 'perf-core-for-mingo-4.16-20180117' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-01-17 17:20:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20180123

for you to fetch changes up to 0d916ef4ce35ee5ff6255d3f0622faccab696d3f:

  perf trace beauty flock: Move to separate object file (2018-01-23 09:51:52 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Introduce an errno code to string facility to allow tools such as
  'perf trace' to support multi-arch perf.data decoding/beautifying,
  uses errno header files copied from the kernel, this allows
  removing the need for audit-libs in arches generating its syscall
  tables from the kernel sources, so far x86 and s/390 (Hendrik Brueckner)

- Intel-PT/BTS sample synthesizing fixes (Adrian Hunter)

- Intel vendor event JSON updates for the Broadwell, BroadwellDE,
  BroadwellX, Goldmont, Haswell, HaswellX, IvyBridge, IvyBridge, IvyTown,
  IvyTown, Silvermont, Skylake and SkylakeX architectures. (Andi Kleen)

- Use ui__error() to have --field error handling messages not to
  disappear due to TUI exit cleanup (Arnaldo Carvalho de Melo)

- Don't warn about unavailability of builtin clang in 'perf trace', just
  continue fallbacking to using the external toolchain (Arnaldo Carvalho de Melo)

- Move conditional O_CLOEXEC define to util.h to keep the build
  working on older distros where that is not available now that
  this define will be used in more source files (Arnaldo Carvalho de Melo)

- Using O_CLOEXEC in do_open() to avoid having too many open files when
  using 'perf script' from the 'perf report' TUI scripts browser (Wang YanQing)

- Add 'perf trace --print-sample' to help in debugging the printing
  of timestamp calculations, for instance (Arnaldo Carvalho de Melo)

- Do not print from time delta for interrupted syscall lines in 'perf
  trace' (those ending with '...') just print the total syscall duration
  at raw_syscalls:sys_exit time (Arnaldo Carvalho de Melo)

- Beautify FUTEX_BITSET_MATCH_ANY in the futex syscall in 'perf trace'
  (Arnaldo Carvalho de Melo)

- Display EXTRA features for 'make VF=1' build (Jiri Olsa)

- Add support for CoreSight trace decoding by making the perf tools
  use the external openCSD (Mathieu Poirier, Tor Jeremiassen)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      perf intel-pt/bts: Do not swap when synthesizing samples
      perf evsel: Ensure reserved member of PERF_SAMPLE_CPU is zero in perf_event__synthesize_sample()
      perf tools: Get rid of unused 'swapped' parameter from perf_event__synthesize_sample()

Andi Kleen (13):
      perf vendor events intel: Update Broadwell events to V22
      perf vendor events intel: Update BroadwellX events to V13
      perf vendor events intel: Update Goldmont events to V12
      perf vendor events intel: Update Haswell events to V27
      perf vendor events intel: Update HaswellX events to V19
      perf vendor events intel: Update IvyBridge events to V20
      perf vendor events intel: Update IvyTown events to V20
      perf vendor events intel: Update Silvermont events to V14
      perf vendor events intel: Update Skylake events to V36
      perf vendor events intel: Update SkylakeX events to V1.06
      perf vendor events intel: Update BroadwellDE events to V7
      perf vendor events intel: Update IvyBridge files to V20
      perf vendor events intel: Update IvyTown files to V20

Arnaldo Carvalho de Melo (9):
      perf tools: Use ui__error() for reporting --fields errors
      perf bpf: Don't warn about unavailability of builtin clang, just fallback
      perf tools: Move conditional O_CLOEXEC to util.h
      perf bpf: Remove misplaced __maybe_unused attribute
      perf trace: Add --print-sample
      perf trace: Do not print from time delta for interrupted syscall lines
      perf trace beauty futex: Beautify FUTEX_BITSET_MATCH_ANY
      perf evlist: Remove fcntl.h from evlist.h
      perf trace beauty flock: Move to separate object file

Hendrik Brueckner (5):
      tools include arch: Grab a copy of errno.h for arch's supported by perf
      tools include asm-generic: Grab errno.h and errno-base.h
      perf util: Introduce architecture specific errno/name mapping
      perf trace: Obtain errno strings by using arch_syscalls__strerrno()
      perf trace: Remove audit-libs dependency if syscall tables are present

Jiri Olsa (1):
      perf build: Display EXTRA features for VF=1 build

Mathieu Poirier (9):
      perf report: Fix regression when decoding intel_pt traces
      perf tools: Integrating the CoreSight decoding library
      perf tools: Add initial entry point for decoder CoreSight traces
      perf tools: Add decoder mechanic to support dumping trace data
      perf tools: Add support for decoding CoreSight trace data
      perf tools: Add functionality to communicate with the openCSD decoder
      pert tools: Add queue management functionality
      perf tools: Add full support for CoreSight trace decoding
      perf tools: Add mechanic to synthesise CoreSight trace packets

Tor Jeremiassen (2):
      perf tools: Add processing of coresight metadata
      MAINTAINERS: Adding entry for CoreSight trace decoding

Wang YanQing (1):
      perf symbols: Using O_CLOEXEC in do_open

 MAINTAINERS                                        |    3 +-
 tools/arch/alpha/include/uapi/asm/errno.h          |  128 +
 tools/arch/mips/include/asm/errno.h                |   17 +
 tools/arch/mips/include/uapi/asm/errno.h           |  130 +
 tools/arch/parisc/include/uapi/asm/errno.h         |  128 +
 tools/arch/powerpc/include/uapi/asm/errno.h        |   10 +
 tools/arch/sparc/include/uapi/asm/errno.h          |  118 +
 tools/arch/x86/include/uapi/asm/errno.h            |    1 +
 tools/build/Makefile.feature                       |    3 +-
 tools/build/feature/Makefile                       |    7 +-
 tools/build/feature/test-all.c                     |    5 +
 tools/build/feature/test-libopencsd.c              |    8 +
 tools/include/uapi/asm-generic/errno-base.h        |   40 +
 tools/include/uapi/asm-generic/errno.h             |  123 +
 tools/perf/Build                                   |    4 +-
 tools/perf/Documentation/perf-trace.txt            |    4 +
 tools/perf/Makefile.config                         |   49 +-
 tools/perf/Makefile.perf                           |   15 +-
 tools/perf/builtin-help.c                          |    2 +-
 tools/perf/builtin-inject.c                        |    3 +-
 tools/perf/builtin-kvm.c                           |    3 +
 tools/perf/builtin-script.c                        |    1 +
 tools/perf/builtin-trace.c                         |   57 +-
 tools/perf/check-headers.sh                        |    9 +
 tools/perf/perf.c                                  |    4 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |  555 ++-
 .../arch/x86/broadwell/floating-point.json         |  108 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |  138 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json |  210 +-
 .../perf/pmu-events/arch/x86/broadwell/other.json  |   20 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    | 1216 +++---
 .../arch/x86/broadwell/virtual-memory.json         |  150 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |  389 +-
 .../arch/x86/broadwellde/floating-point.json       |  108 +-
 .../pmu-events/arch/x86/broadwellde/frontend.json  |  138 +-
 .../pmu-events/arch/x86/broadwellde/memory.json    |    9 +-
 .../pmu-events/arch/x86/broadwellde/other.json     |   20 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  | 1214 +++---
 .../arch/x86/broadwellde/virtual-memory.json       |  150 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |  383 +-
 .../arch/x86/broadwellx/floating-point.json        |  108 +-
 .../pmu-events/arch/x86/broadwellx/frontend.json   |  138 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |   40 +-
 .../perf/pmu-events/arch/x86/broadwellx/other.json |   20 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   | 1214 +++---
 .../arch/x86/broadwellx/virtual-memory.json        |  150 +-
 tools/perf/pmu-events/arch/x86/goldmont/cache.json | 1244 +++++-
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |  280 +-
 tools/perf/pmu-events/arch/x86/goldmont/other.json |   54 +-
 .../pmu-events/arch/x86/goldmont/pipeline.json     |  506 +--
 .../arch/x86/goldmont/virtual-memory.json          |   60 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |  365 +-
 .../arch/x86/haswell/floating-point.json           |   20 +-
 .../perf/pmu-events/arch/x86/haswell/frontend.json |  132 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |   21 +
 tools/perf/pmu-events/arch/x86/haswell/other.json  |   20 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json | 1131 ++---
 .../arch/x86/haswell/virtual-memory.json           |  212 +-
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |  377 +-
 .../arch/x86/haswellx/floating-point.json          |   20 +-
 .../pmu-events/arch/x86/haswellx/frontend.json     |  132 +-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |   28 +
 tools/perf/pmu-events/arch/x86/haswellx/other.json |   20 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     | 1133 ++---
 .../arch/x86/haswellx/virtual-memory.json          |  212 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |  243 +-
 .../pmu-events/arch/x86/ivybridge/frontend.json    |  122 +-
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |   24 +-
 .../perf/pmu-events/arch/x86/ivybridge/other.json  |   20 +-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |  822 ++--
 .../arch/x86/ivybridge/virtual-memory.json         |   60 +-
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |  236 +-
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |  122 +-
 tools/perf/pmu-events/arch/x86/ivytown/memory.json |   24 +-
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |   20 +-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |  822 ++--
 .../arch/x86/ivytown/virtual-memory.json           |   60 +-
 .../perf/pmu-events/arch/x86/silvermont/cache.json |    3 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json  | 4390 +++-----------------
 .../arch/x86/skylake/floating-point.json           |    5 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |  232 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json | 2118 +---------
 tools/perf/pmu-events/arch/x86/skylake/other.json  |   40 +-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |  973 ++---
 .../arch/x86/skylake/virtual-memory.json           |  262 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  257 +-
 .../arch/x86/skylakex/floating-point.json          |    3 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |   48 +-
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  231 +-
 tools/perf/pmu-events/arch/x86/skylakex/other.json |   94 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   44 +-
 .../arch/x86/skylakex/virtual-memory.json          |   42 +-
 tools/perf/tests/bpf.c                             |    1 +
 tools/perf/tests/openat-syscall-tp-fields.c        |    3 +
 tools/perf/tests/sample-parsing.c                  |    2 +-
 tools/perf/trace/beauty/Build                      |    1 +
 tools/perf/trace/beauty/arch_errno_names.c         |    1 +
 tools/perf/trace/beauty/arch_errno_names.sh        |  100 +
 tools/perf/trace/beauty/beauty.h                   |    5 +
 tools/perf/trace/beauty/flock.c                    |   10 +-
 tools/perf/trace/beauty/futex_val3.c               |   18 +
 tools/perf/util/Build                              |    8 +-
 tools/perf/util/auxtrace.c                         |    2 +
 tools/perf/util/bpf-loader.c                       |    4 +-
 tools/perf/util/cgroup.c                           |    3 +
 tools/perf/util/cs-etm-decoder/Build               |    1 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  513 +++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |  105 +
 tools/perf/util/cs-etm.c                           | 1023 +++++
 tools/perf/util/cs-etm.h                           |   18 +
 tools/perf/util/data.c                             |   10 -
 tools/perf/util/dso.c                              |    2 +-
 tools/perf/util/event.h                            |    3 +-
 tools/perf/util/evlist.c                           |    1 +
 tools/perf/util/evlist.h                           |    1 -
 tools/perf/util/evsel.c                            |   29 +-
 tools/perf/util/generate-cmdlist.sh                |    2 +-
 tools/perf/util/intel-bts.c                        |    6 +-
 tools/perf/util/intel-pt.c                         |   11 +-
 tools/perf/util/parse-events.c                     |    3 +
 tools/perf/util/session.c                          |    4 +-
 tools/perf/util/sort.c                             |    4 +-
 tools/perf/util/util.h                             |   10 +
 123 files changed, 13093 insertions(+), 13445 deletions(-)
 create mode 100644 tools/arch/alpha/include/uapi/asm/errno.h
 create mode 100644 tools/arch/mips/include/asm/errno.h
 create mode 100644 tools/arch/mips/include/uapi/asm/errno.h
 create mode 100644 tools/arch/parisc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/powerpc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/sparc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/x86/include/uapi/asm/errno.h
 create mode 100644 tools/build/feature/test-libopencsd.c
 create mode 100644 tools/include/uapi/asm-generic/errno-base.h
 create mode 100644 tools/include/uapi/asm-generic/errno.h
 create mode 100644 tools/perf/trace/beauty/arch_errno_names.c
 create mode 100755 tools/perf/trace/beauty/arch_errno_names.sh
 create mode 100644 tools/perf/trace/beauty/futex_val3.c
 create mode 100644 tools/perf/util/cs-etm-decoder/Build
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
 create mode 100644 tools/perf/util/cs-etm.c

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support.  Where clang is available, it is also used to build
perf with/without libelf.

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

  Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  # dm
   1 38.79 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 44.58 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 41.40 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 46.64 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 34.47 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6 40.70 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7 25.65 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8 27.56 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 21.13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10 31.99 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  11 38.15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  12 33.32 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  13 37.71 debian:8                      : Ok   gcc (Debian 4.9.2-10) 4.9.2
  14 60.08 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  15 62.63 debian:experimental           : Ok   gcc (Debian 7.2.0-18) 7.2.0
  16 37.77 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17 37.06 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 33.62 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  19 38.22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  20 37.05 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  21 38.35 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  22 38.36 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 37.95 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 40.11 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25 34.08 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26 73.39 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27 84.80 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28 84.80 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29 80.10 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-4)
  30 40.33 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  31 39.89 mageia:5                      : Ok   gcc (GCC) 4.9.2
  32 41.18 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  33 38.36 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  34 40.05 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  35 38.82 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  36 86.97 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.2.1 20171020 [gcc-7-branch revision 253932]
  37 34.19 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  38 38.07 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  39 30.03 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  40 35.72 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  41 31.12 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  42 57.70 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  43 31.06 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 30.38 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45 31.23 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 30.35 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  47 30.64 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 30.60 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49 61.48 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  50 62.85 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  51 63.53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  52 65.02 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-18ubuntu2) 7.2.0
  # 

  # uname -a
  Linux jouet 4.15.0-rc9+ #7 SMP Mon Jan 22 18:16:36 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
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
  21: Number of exit events of a simple workload            : Ok
  22: Software clock events period values                   : Ok
  23: Object code reading                                   : Ok
  24: Sample parsing                                        : Ok
  25: Use a dummy software event to keep tracking           : Ok
  26: Parse with no sample_id_all bit set                   : Ok
  27: Filter hist entries                                   : Ok
  28: Lookup mmap thread                                    : Ok
  29: Share thread mg                                       : Ok
  30: Sort output of hist entries                           : Ok
  31: Cumulate child hist entries                           : Ok
  32: Track with sched_switch                               : Ok
  33: Filter fds with revents mask in a fdarray             : Ok
  34: Add fd to a fdarray, making it autogrow               : Ok
  35: kmod_path__parse                                      : Ok
  36: Thread map                                            : Ok
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              : Ok
  37.2: kbuild searching                                    : Ok
  37.3: Compile source for BPF prologue generation          : Ok
  37.4: Compile source for BPF relocation                   : Ok
  38: Session topology                                      : Ok
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  40: Synthesize thread map                                 : Ok
  41: Remove thread map                                     : Ok
  42: Synthesize cpu map                                    : Ok
  43: Synthesize stat config                                : Ok
  44: Synthesize stat                                       : Ok
  45: Synthesize stat round                                 : Ok
  46: Synthesize attr update                                : Ok
  47: Event times                                           : Ok
  48: Read backward ring buffer                             : Ok
  49: Print cpu map                                         : Ok
  50: Probe SDT events                                      : Ok
  51: is_printable_array                                    : Ok
  52: Print bitmap                                          : Ok
  53: perf hooks                                            : Ok
  54: builtin clang support                                 : Skip (not compiled in)
  55: unit_number__scnprintf                                : Ok
  56: x86 rdpmc                                             : Ok
  57: Convert perf time to TSC                              : Ok
  58: DWARF unwind                                          : Ok
  59: x86 instruction decoder - new instructions            : Ok
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  # 

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_libbionic_O: make NO_LIBBIONIC=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
               make_no_slang_O: make NO_SLANG=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_no_newt_O: make NO_NEWT=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                 make_static_O: make LDFLAGS=-static
         make_install_prefix_O: make install prefix=/tmp/krava
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_pure_O: make
                    make_doc_O: make doc
             make_util_map_o_O: make util/map.o
           make_no_backtrace_O: make NO_BACKTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
              make_no_libbpf_O: make NO_LIBBPF=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_no_libelf_O: make NO_LIBELF=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                  make_debug_O: make DEBUG=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_clean_all_O: make clean all
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_gtk2_O: make NO_GTK2=1
            make_install_bin_O: make install-bin
                make_install_O: make install
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_tags_O: make tags
                 make_perf_o_O: make perf.o
           make_no_libpython_O: make NO_LIBPYTHON=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
