From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/43] perf/core improvements and changes
Date: Wed, 24 Jan 2018 12:15:19 +0100
Message-ID: <20180124111519.qvy54qczpdoj7mln@gmail.com>
References: <20180123131251.28197-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Petlan <mpetlan@redhat.com>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Tor Jeremiassen <tor@ti.com>, Wang Nan <wangnan0@huawei.com>Wang
List-ID: <linux-s390.vger.kernel.org>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit a72594ca5c70ef4a94fab8ad541beda0d0a94139:
> 
>   Merge tag 'perf-core-for-mingo-4.16-20180117' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-01-17 17:20:24 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20180123
> 
> for you to fetch changes up to 0d916ef4ce35ee5ff6255d3f0622faccab696d3f:
> 
>   perf trace beauty flock: Move to separate object file (2018-01-23 09:51:52 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Introduce an errno code to string facility to allow tools such as
>   'perf trace' to support multi-arch perf.data decoding/beautifying,
>   uses errno header files copied from the kernel, this allows
>   removing the need for audit-libs in arches generating its syscall
>   tables from the kernel sources, so far x86 and s/390 (Hendrik Brueckner)
> 
> - Intel-PT/BTS sample synthesizing fixes (Adrian Hunter)
> 
> - Intel vendor event JSON updates for the Broadwell, BroadwellDE,
>   BroadwellX, Goldmont, Haswell, HaswellX, IvyBridge, IvyBridge, IvyTown,
>   IvyTown, Silvermont, Skylake and SkylakeX architectures. (Andi Kleen)
> 
> - Use ui__error() to have --field error handling messages not to
>   disappear due to TUI exit cleanup (Arnaldo Carvalho de Melo)
> 
> - Don't warn about unavailability of builtin clang in 'perf trace', just
>   continue fallbacking to using the external toolchain (Arnaldo Carvalho de Melo)
> 
> - Move conditional O_CLOEXEC define to util.h to keep the build
>   working on older distros where that is not available now that
>   this define will be used in more source files (Arnaldo Carvalho de Melo)
> 
> - Using O_CLOEXEC in do_open() to avoid having too many open files when
>   using 'perf script' from the 'perf report' TUI scripts browser (Wang YanQing)
> 
> - Add 'perf trace --print-sample' to help in debugging the printing
>   of timestamp calculations, for instance (Arnaldo Carvalho de Melo)
> 
> - Do not print from time delta for interrupted syscall lines in 'perf
>   trace' (those ending with '...') just print the total syscall duration
>   at raw_syscalls:sys_exit time (Arnaldo Carvalho de Melo)
> 
> - Beautify FUTEX_BITSET_MATCH_ANY in the futex syscall in 'perf trace'
>   (Arnaldo Carvalho de Melo)
> 
> - Display EXTRA features for 'make VF=1' build (Jiri Olsa)
> 
> - Add support for CoreSight trace decoding by making the perf tools
>   use the external openCSD (Mathieu Poirier, Tor Jeremiassen)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (3):
>       perf intel-pt/bts: Do not swap when synthesizing samples
>       perf evsel: Ensure reserved member of PERF_SAMPLE_CPU is zero in perf_event__synthesize_sample()
>       perf tools: Get rid of unused 'swapped' parameter from perf_event__synthesize_sample()
> 
> Andi Kleen (13):
>       perf vendor events intel: Update Broadwell events to V22
>       perf vendor events intel: Update BroadwellX events to V13
>       perf vendor events intel: Update Goldmont events to V12
>       perf vendor events intel: Update Haswell events to V27
>       perf vendor events intel: Update HaswellX events to V19
>       perf vendor events intel: Update IvyBridge events to V20
>       perf vendor events intel: Update IvyTown events to V20
>       perf vendor events intel: Update Silvermont events to V14
>       perf vendor events intel: Update Skylake events to V36
>       perf vendor events intel: Update SkylakeX events to V1.06
>       perf vendor events intel: Update BroadwellDE events to V7
>       perf vendor events intel: Update IvyBridge files to V20
>       perf vendor events intel: Update IvyTown files to V20
> 
> Arnaldo Carvalho de Melo (9):
>       perf tools: Use ui__error() for reporting --fields errors
>       perf bpf: Don't warn about unavailability of builtin clang, just fallback
>       perf tools: Move conditional O_CLOEXEC to util.h
>       perf bpf: Remove misplaced __maybe_unused attribute
>       perf trace: Add --print-sample
>       perf trace: Do not print from time delta for interrupted syscall lines
>       perf trace beauty futex: Beautify FUTEX_BITSET_MATCH_ANY
>       perf evlist: Remove fcntl.h from evlist.h
>       perf trace beauty flock: Move to separate object file
> 
> Hendrik Brueckner (5):
>       tools include arch: Grab a copy of errno.h for arch's supported by perf
>       tools include asm-generic: Grab errno.h and errno-base.h
>       perf util: Introduce architecture specific errno/name mapping
>       perf trace: Obtain errno strings by using arch_syscalls__strerrno()
>       perf trace: Remove audit-libs dependency if syscall tables are present
> 
> Jiri Olsa (1):
>       perf build: Display EXTRA features for VF=1 build
> 
> Mathieu Poirier (9):
>       perf report: Fix regression when decoding intel_pt traces
>       perf tools: Integrating the CoreSight decoding library
>       perf tools: Add initial entry point for decoder CoreSight traces
>       perf tools: Add decoder mechanic to support dumping trace data
>       perf tools: Add support for decoding CoreSight trace data
>       perf tools: Add functionality to communicate with the openCSD decoder
>       pert tools: Add queue management functionality
>       perf tools: Add full support for CoreSight trace decoding
>       perf tools: Add mechanic to synthesise CoreSight trace packets
> 
> Tor Jeremiassen (2):
>       perf tools: Add processing of coresight metadata
>       MAINTAINERS: Adding entry for CoreSight trace decoding
> 
> Wang YanQing (1):
>       perf symbols: Using O_CLOEXEC in do_open
> 
>  MAINTAINERS                                        |    3 +-
>  tools/arch/alpha/include/uapi/asm/errno.h          |  128 +
>  tools/arch/mips/include/asm/errno.h                |   17 +
>  tools/arch/mips/include/uapi/asm/errno.h           |  130 +
>  tools/arch/parisc/include/uapi/asm/errno.h         |  128 +
>  tools/arch/powerpc/include/uapi/asm/errno.h        |   10 +
>  tools/arch/sparc/include/uapi/asm/errno.h          |  118 +
>  tools/arch/x86/include/uapi/asm/errno.h            |    1 +
>  tools/build/Makefile.feature                       |    3 +-
>  tools/build/feature/Makefile                       |    7 +-
>  tools/build/feature/test-all.c                     |    5 +
>  tools/build/feature/test-libopencsd.c              |    8 +
>  tools/include/uapi/asm-generic/errno-base.h        |   40 +
>  tools/include/uapi/asm-generic/errno.h             |  123 +
>  tools/perf/Build                                   |    4 +-
>  tools/perf/Documentation/perf-trace.txt            |    4 +
>  tools/perf/Makefile.config                         |   49 +-
>  tools/perf/Makefile.perf                           |   15 +-
>  tools/perf/builtin-help.c                          |    2 +-
>  tools/perf/builtin-inject.c                        |    3 +-
>  tools/perf/builtin-kvm.c                           |    3 +
>  tools/perf/builtin-script.c                        |    1 +
>  tools/perf/builtin-trace.c                         |   57 +-
>  tools/perf/check-headers.sh                        |    9 +
>  tools/perf/perf.c                                  |    4 +-
>  .../perf/pmu-events/arch/x86/broadwell/cache.json  |  555 ++-
>  .../arch/x86/broadwell/floating-point.json         |  108 +-
>  .../pmu-events/arch/x86/broadwell/frontend.json    |  138 +-
>  .../perf/pmu-events/arch/x86/broadwell/memory.json |  210 +-
>  .../perf/pmu-events/arch/x86/broadwell/other.json  |   20 +-
>  .../pmu-events/arch/x86/broadwell/pipeline.json    | 1216 +++---
>  .../arch/x86/broadwell/virtual-memory.json         |  150 +-
>  .../pmu-events/arch/x86/broadwellde/cache.json     |  389 +-
>  .../arch/x86/broadwellde/floating-point.json       |  108 +-
>  .../pmu-events/arch/x86/broadwellde/frontend.json  |  138 +-
>  .../pmu-events/arch/x86/broadwellde/memory.json    |    9 +-
>  .../pmu-events/arch/x86/broadwellde/other.json     |   20 +-
>  .../pmu-events/arch/x86/broadwellde/pipeline.json  | 1214 +++---
>  .../arch/x86/broadwellde/virtual-memory.json       |  150 +-
>  .../perf/pmu-events/arch/x86/broadwellx/cache.json |  383 +-
>  .../arch/x86/broadwellx/floating-point.json        |  108 +-
>  .../pmu-events/arch/x86/broadwellx/frontend.json   |  138 +-
>  .../pmu-events/arch/x86/broadwellx/memory.json     |   40 +-
>  .../perf/pmu-events/arch/x86/broadwellx/other.json |   20 +-
>  .../pmu-events/arch/x86/broadwellx/pipeline.json   | 1214 +++---
>  .../arch/x86/broadwellx/virtual-memory.json        |  150 +-
>  tools/perf/pmu-events/arch/x86/goldmont/cache.json | 1244 +++++-
>  .../perf/pmu-events/arch/x86/goldmont/memory.json  |  280 +-
>  tools/perf/pmu-events/arch/x86/goldmont/other.json |   54 +-
>  .../pmu-events/arch/x86/goldmont/pipeline.json     |  506 +--
>  .../arch/x86/goldmont/virtual-memory.json          |   60 +-
>  tools/perf/pmu-events/arch/x86/haswell/cache.json  |  365 +-
>  .../arch/x86/haswell/floating-point.json           |   20 +-
>  .../perf/pmu-events/arch/x86/haswell/frontend.json |  132 +-
>  tools/perf/pmu-events/arch/x86/haswell/memory.json |   21 +
>  tools/perf/pmu-events/arch/x86/haswell/other.json  |   20 +-
>  .../perf/pmu-events/arch/x86/haswell/pipeline.json | 1131 ++---
>  .../arch/x86/haswell/virtual-memory.json           |  212 +-
>  tools/perf/pmu-events/arch/x86/haswellx/cache.json |  377 +-
>  .../arch/x86/haswellx/floating-point.json          |   20 +-
>  .../pmu-events/arch/x86/haswellx/frontend.json     |  132 +-
>  .../perf/pmu-events/arch/x86/haswellx/memory.json  |   28 +
>  tools/perf/pmu-events/arch/x86/haswellx/other.json |   20 +-
>  .../pmu-events/arch/x86/haswellx/pipeline.json     | 1133 ++---
>  .../arch/x86/haswellx/virtual-memory.json          |  212 +-
>  .../perf/pmu-events/arch/x86/ivybridge/cache.json  |  243 +-
>  .../pmu-events/arch/x86/ivybridge/frontend.json    |  122 +-
>  .../perf/pmu-events/arch/x86/ivybridge/memory.json |   24 +-
>  .../perf/pmu-events/arch/x86/ivybridge/other.json  |   20 +-
>  .../pmu-events/arch/x86/ivybridge/pipeline.json    |  822 ++--
>  .../arch/x86/ivybridge/virtual-memory.json         |   60 +-
>  tools/perf/pmu-events/arch/x86/ivytown/cache.json  |  236 +-
>  .../perf/pmu-events/arch/x86/ivytown/frontend.json |  122 +-
>  tools/perf/pmu-events/arch/x86/ivytown/memory.json |   24 +-
>  tools/perf/pmu-events/arch/x86/ivytown/other.json  |   20 +-
>  .../perf/pmu-events/arch/x86/ivytown/pipeline.json |  822 ++--
>  .../arch/x86/ivytown/virtual-memory.json           |   60 +-
>  .../perf/pmu-events/arch/x86/silvermont/cache.json |    3 +-
>  tools/perf/pmu-events/arch/x86/skylake/cache.json  | 4390 +++-----------------
>  .../arch/x86/skylake/floating-point.json           |    5 +-
>  .../perf/pmu-events/arch/x86/skylake/frontend.json |  232 +-
>  tools/perf/pmu-events/arch/x86/skylake/memory.json | 2118 +---------
>  tools/perf/pmu-events/arch/x86/skylake/other.json  |   40 +-
>  .../perf/pmu-events/arch/x86/skylake/pipeline.json |  973 ++---
>  .../arch/x86/skylake/virtual-memory.json           |  262 +-
>  tools/perf/pmu-events/arch/x86/skylakex/cache.json |  257 +-
>  .../arch/x86/skylakex/floating-point.json          |    3 +-
>  .../pmu-events/arch/x86/skylakex/frontend.json     |   48 +-
>  .../perf/pmu-events/arch/x86/skylakex/memory.json  |  231 +-
>  tools/perf/pmu-events/arch/x86/skylakex/other.json |   94 +-
>  .../pmu-events/arch/x86/skylakex/pipeline.json     |   44 +-
>  .../arch/x86/skylakex/virtual-memory.json          |   42 +-
>  tools/perf/tests/bpf.c                             |    1 +
>  tools/perf/tests/openat-syscall-tp-fields.c        |    3 +
>  tools/perf/tests/sample-parsing.c                  |    2 +-
>  tools/perf/trace/beauty/Build                      |    1 +
>  tools/perf/trace/beauty/arch_errno_names.c         |    1 +
>  tools/perf/trace/beauty/arch_errno_names.sh        |  100 +
>  tools/perf/trace/beauty/beauty.h                   |    5 +
>  tools/perf/trace/beauty/flock.c                    |   10 +-
>  tools/perf/trace/beauty/futex_val3.c               |   18 +
>  tools/perf/util/Build                              |    8 +-
>  tools/perf/util/auxtrace.c                         |    2 +
>  tools/perf/util/bpf-loader.c                       |    4 +-
>  tools/perf/util/cgroup.c                           |    3 +
>  tools/perf/util/cs-etm-decoder/Build               |    1 +
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  513 +++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |  105 +
>  tools/perf/util/cs-etm.c                           | 1023 +++++
>  tools/perf/util/cs-etm.h                           |   18 +
>  tools/perf/util/data.c                             |   10 -
>  tools/perf/util/dso.c                              |    2 +-
>  tools/perf/util/event.h                            |    3 +-
>  tools/perf/util/evlist.c                           |    1 +
>  tools/perf/util/evlist.h                           |    1 -
>  tools/perf/util/evsel.c                            |   29 +-
>  tools/perf/util/generate-cmdlist.sh                |    2 +-
>  tools/perf/util/intel-bts.c                        |    6 +-
>  tools/perf/util/intel-pt.c                         |   11 +-
>  tools/perf/util/parse-events.c                     |    3 +
>  tools/perf/util/session.c                          |    4 +-
>  tools/perf/util/sort.c                             |    4 +-
>  tools/perf/util/util.h                             |   10 +
>  123 files changed, 13093 insertions(+), 13445 deletions(-)
>  create mode 100644 tools/arch/alpha/include/uapi/asm/errno.h
>  create mode 100644 tools/arch/mips/include/asm/errno.h
>  create mode 100644 tools/arch/mips/include/uapi/asm/errno.h
>  create mode 100644 tools/arch/parisc/include/uapi/asm/errno.h
>  create mode 100644 tools/arch/powerpc/include/uapi/asm/errno.h
>  create mode 100644 tools/arch/sparc/include/uapi/asm/errno.h
>  create mode 100644 tools/arch/x86/include/uapi/asm/errno.h
>  create mode 100644 tools/build/feature/test-libopencsd.c
>  create mode 100644 tools/include/uapi/asm-generic/errno-base.h
>  create mode 100644 tools/include/uapi/asm-generic/errno.h
>  create mode 100644 tools/perf/trace/beauty/arch_errno_names.c
>  create mode 100755 tools/perf/trace/beauty/arch_errno_names.sh
>  create mode 100644 tools/perf/trace/beauty/futex_val3.c
>  create mode 100644 tools/perf/util/cs-etm-decoder/Build
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>  create mode 100644 tools/perf/util/cs-etm.c

Pulled, thanks a lot Arnaldo!

	Ingo
