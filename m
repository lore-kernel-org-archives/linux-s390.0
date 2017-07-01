Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 1 Jul 2017 10:41:33 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/30] perf/core improvements and fixes
Message-ID: <20170701084133.ij4uvae7affksx2f@gmail.com>
References: <20170630222514.11832-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170630222514.11832-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, linux-s390@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 8e70e8409102a37ab066bd91007b75fd5d113931:
> 
>   Merge tag 'perf-core-for-mingo-4.13-20170621' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-06-21 20:11:53 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170630
> 
> for you to fetch changes up to 644e0840ad4615e032d67adec6ee60f821b669fe:
> 
>   perf auxtrace: Add CPU filter support (2017-06-30 11:50:55 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> Intel PT:
> 
> - Support "ptwrite" instructio, a way to stuff 32 or 64 bit values into
>   the Intel PT trace (Adrian Hunter)
> 
> - Support power events in Intel PT to report changes to C-state (Adrian
>   Hunter)
> 
> - Synthesize Intel PT events as PERF_RECORD_SAMPLE records with a
>   perf_event_attr.type (PERF_TYPE_SYNTH) just after the range used by the
>   kernel, i.e. right after what is allocated for PMUs, at INT_MAX + 1U,
>   attr.config will have the identification for the synthesized event and
>   the PERF_SAMPLE_RAW payload will have its fields (Adrian Hunter)
> 
> Infrastructure:
> 
> - Remove warning() and error(), using instead pr_warning() and
>   pr_error(), consolidating error reporting (Arnaldo Carvalho de Melo)
> 
> - Add platform dependency to 'perf test 15' (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (19):
>       x86/insn: perf tools: Add new ptwrite instruction
>       perf script: Add 'synth' event type for synthesized events
>       tools include: Add byte-swapping macros to kernel.h
>       perf auxtrace: Add itrace option to output ptwrite events
>       perf auxtrace: Add itrace option to output power events
>       perf script: Add 'synth' field for synthesized event payloads
>       perf script: Add synthesized Intel PT power and ptwrite events
>       perf intel-pt: Factor out common code synthesizing event samples
>       perf intel-pt: Remove unused instructions_sample_period
>       perf intel-pt: Join needlessly wrapped lines
>       perf intel-pt: Tidy Intel PT evsel lookup into separate function
>       perf intel-pt: Tidy messages into called function intel_pt_synth_event()
>       perf intel-pt: Factor out intel_pt_set_event_name()
>       perf intel-pt: Move code in intel_pt_synth_events() to simplify attr setting
>       perf intel-pt: Synthesize new power and "ptwrite" events
>       perf intel-pt: Add example script for power events and PTWRITE
>       perf intel-pt: Update documentation to include new ptwrite and power events
>       perf intel-pt: Do not use TSC packets for calculating CPU cycles to TSC
>       perf auxtrace: Add CPU filter support
> 
> Arnaldo Carvalho de Melo (9):
>       perf help: Introduce exec_failed() to avoid code duplication
>       perf help: Elliminate dup code for reporting
>       perf help: Use pr_warning()
>       perf config: Use pr_warning()
>       perf event-parse: Use pr_warning()
>       perf tools: Remove warning()
>       perf tools: Replace error() with pr_err()
>       perf config: Do not die when parsing u64 or int config values
>       perf tools: Kill die()
> 
> Colin Ian King (1):
>       perf jit: fix typo: "incalid" -> "invalid"
> 
> Thomas Richter (1):
>       perf tests: Add platform dependency to test 15
> 
>  arch/x86/lib/x86-opcode-map.txt                    |   2 +-
>  tools/include/linux/kernel.h                       |  35 +-
>  tools/objtool/arch/x86/insn/x86-opcode-map.txt     |   2 +-
>  tools/perf/Documentation/intel-pt.txt              |  42 +-
>  tools/perf/Documentation/itrace.txt                |   8 +-
>  tools/perf/Documentation/perf-script.txt           |   6 +-
>  tools/perf/arch/x86/tests/insn-x86-dat-32.c        |  12 +
>  tools/perf/arch/x86/tests/insn-x86-dat-64.c        |  30 +
>  tools/perf/arch/x86/tests/insn-x86-dat-src.c       |  30 +
>  tools/perf/builtin-c2c.c                           |   4 +-
>  tools/perf/builtin-diff.c                          |   5 +-
>  tools/perf/builtin-help.c                          |  48 +-
>  tools/perf/builtin-kmem.c                          |   4 +-
>  tools/perf/builtin-record.c                        |   4 +-
>  tools/perf/builtin-report.c                        |   8 +-
>  tools/perf/builtin-sched.c                         |   2 +-
>  tools/perf/builtin-script.c                        | 205 ++++++-
>  tools/perf/builtin-stat.c                          |   4 +-
>  tools/perf/builtin-top.c                           |   2 +-
>  tools/perf/jvmti/jvmti_agent.c                     |   2 +-
>  .../perf/scripts/python/bin/intel-pt-events-record |  13 +
>  .../perf/scripts/python/bin/intel-pt-events-report |   3 +
>  tools/perf/scripts/python/intel-pt-events.py       | 128 +++++
>  tools/perf/tests/attr.c                            |  10 +-
>  tools/perf/tests/attr.py                           |  48 ++
>  tools/perf/tests/parse-events.c                    |  13 -
>  tools/perf/util/auxtrace.c                         |  18 +
>  tools/perf/util/auxtrace.h                         |   6 +
>  tools/perf/util/config.c                           |  43 +-
>  tools/perf/util/config.h                           |   4 +-
>  tools/perf/util/data-convert-bt.c                  |   6 +-
>  tools/perf/util/event.h                            | 121 ++++
>  tools/perf/util/help-unknown-cmd.c                 |   2 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  14 +
>  .../perf/util/intel-pt-decoder/x86-opcode-map.txt  |   2 +-
>  tools/perf/util/intel-pt.c                         | 623 +++++++++++++++------
>  tools/perf/util/sort.c                             |  22 +-
>  tools/perf/util/trace-event-parse.c                |   4 +-
>  tools/perf/util/usage.c                            |  58 --
>  tools/perf/util/util.h                             |   4 -
>  40 files changed, 1228 insertions(+), 369 deletions(-)
>  create mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
>  create mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
>  create mode 100644 tools/perf/scripts/python/intel-pt-events.py

Pulled, thanks a lot Arnaldo!

	Ingo
