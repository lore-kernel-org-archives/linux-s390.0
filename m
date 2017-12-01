From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 0/5] bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT
 program type
Date: Fri,  1 Dec 2017 15:19:03 +0100
Message-ID: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

Perf tool bpf selftests revealed a broken uapi for s390 and arm64.
With the BPF_PROG_TYPE_PERF_EVENT program type the bpf_perf_event
structure exports the pt_regs structure for all architectures.

This fails for s390 and arm64 because pt_regs are not part of the
user api and kept in-kernel only.  To mitigate the broken uapi,
introduce a wrapper that exports pt_regs in an asm-generic way.
For arm64, export the exising user_pt_regs structure.  For s390,
introduce a user_pt_regs structure that exports the beginning of
pt_regs.

Note that user_pt_regs must export from the beginning of pt_regs
as BPF_PROG_TYPE_PERF_EVENT program type is not the only type for
running BPF programs.

Some more background:
	For the bpf_perf_event, there is a uapi definition that is
	passed to the BPF program.  For other "probe" points like
	trace points, kprobes, and uprobes, there is no uapi and the
	BPF program is always passed pt_regs (which is OK as the BPF
	program runs in the kernel context).  The perf tool can attach
	BPF programs to all of these "probe" points and, optionally,
	can create a BPF prologue to access particular arguments
	(passed as registers).  For this, it uses DWARF/CFI
	information to obtain the register and calls a perf-arch
	backend function, regs_query_register_offset().  This function
	returns the index into (user_)pt_regs for a particular
	register.  Then, perf creates a BPF prologue that accesses
	this register based on the passed stucture from the "probe"
	point.

Part of this series, are also updates to the testing and bpf selftest
to deal with asm-specifics.  To complete the bpf support in perf, the
the regs_query_register_offset function is added for s390 to support
BPF prologue creation.

Hendrik Brueckner (5):
  bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
  s390/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program
    type
  arm64/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program
    type
  selftests/bpf: sync kernel headers and introduce arch support in
    Makefile
  perf s390: add regs_query_register_offset()

 arch/arm64/include/asm/perf_event.h                |   2 +
 arch/arm64/include/uapi/asm/bpf_perf_event.h       |   9 +
 arch/s390/include/asm/perf_event.h                 |   1 +
 arch/s390/include/asm/ptrace.h                     |  11 +-
 arch/s390/include/uapi/asm/bpf_perf_event.h        |   9 +
 arch/s390/include/uapi/asm/ptrace.h                |  11 +
 include/linux/perf_event.h                         |   6 +-
 include/uapi/asm-generic/bpf_perf_event.h          |   9 +
 include/uapi/linux/bpf_perf_event.h                |   5 +-
 kernel/events/core.c                               |   2 +-
 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h |   9 +
 tools/arch/s390/include/uapi/asm/bpf_perf_event.h  |   9 +
 tools/arch/s390/include/uapi/asm/ptrace.h          | 471 +++++++++++++++++++++
 tools/include/uapi/asm-generic/bpf_perf_event.h    |   9 +
 tools/include/uapi/linux/bpf_perf_event.h          |   6 +-
 tools/perf/arch/s390/Makefile                      |   1 +
 tools/perf/arch/s390/util/dwarf-regs.c             |  32 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/testing/selftests/bpf/Makefile               |  14 +-
 19 files changed, 602 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/s390/include/uapi/asm/bpf_perf_event.h
 create mode 100644 include/uapi/asm-generic/bpf_perf_event.h
 create mode 100644 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
 create mode 100644 tools/arch/s390/include/uapi/asm/bpf_perf_event.h
 create mode 100644 tools/arch/s390/include/uapi/asm/ptrace.h
 create mode 100644 tools/include/uapi/asm-generic/bpf_perf_event.h

-- 
1.8.3.1
