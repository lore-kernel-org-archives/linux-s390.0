Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 0/6] bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date: Mon,  4 Dec 2017 10:56:43 +0100
Message-Id: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
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

Changelog v1 -> v2:
- Correct kbuild test bot issues by including
  asm-generic/bpf_perf_event.h for archictectures that do not have
  their own asm version.
- Added patch to clean-up whitespace and coding style issues in s390
  asm/ptrace.h (#4/6) as suggested by Alexei.


Hendrik Brueckner (6):
  bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
  s390/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program
    type
  arm64/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program
    type
  s390/uapi: correct whitespace & coding style in asm/ptrace.h
  selftests/bpf: sync kernel headers and introduce arch support in
    Makefile
  perf s390: add regs_query_register_offset()

 arch/alpha/include/uapi/asm/Kbuild                 |   2 +
 arch/arc/include/uapi/asm/Kbuild                   |   1 +
 arch/arm/include/uapi/asm/Kbuild                   |   1 +
 arch/arm64/include/asm/perf_event.h                |   2 +
 arch/arm64/include/uapi/asm/bpf_perf_event.h       |   9 +
 arch/blackfin/include/uapi/asm/Kbuild              |   1 +
 arch/c6x/include/uapi/asm/Kbuild                   |   1 +
 arch/cris/include/uapi/asm/Kbuild                  |   1 +
 arch/frv/include/uapi/asm/Kbuild                   |   2 +
 arch/h8300/include/uapi/asm/Kbuild                 |   1 +
 arch/hexagon/include/uapi/asm/Kbuild               |   1 +
 arch/ia64/include/uapi/asm/Kbuild                  |   1 +
 arch/m32r/include/uapi/asm/Kbuild                  |   1 +
 arch/m68k/include/uapi/asm/Kbuild                  |   1 +
 arch/metag/include/uapi/asm/Kbuild                 |   1 +
 arch/microblaze/include/uapi/asm/Kbuild            |   1 +
 arch/mips/include/uapi/asm/Kbuild                  |   1 +
 arch/mn10300/include/uapi/asm/Kbuild               |   1 +
 arch/nios2/include/uapi/asm/Kbuild                 |   1 +
 arch/openrisc/include/uapi/asm/Kbuild              |   1 +
 arch/parisc/include/uapi/asm/Kbuild                |   1 +
 arch/powerpc/include/uapi/asm/Kbuild               |   1 +
 arch/riscv/include/uapi/asm/Kbuild                 |   1 +
 arch/s390/include/asm/perf_event.h                 |   1 +
 arch/s390/include/asm/ptrace.h                     |  11 +-
 arch/s390/include/uapi/asm/bpf_perf_event.h        |   9 +
 arch/s390/include/uapi/asm/ptrace.h                | 125 +++---
 arch/score/include/uapi/asm/Kbuild                 |   1 +
 arch/sh/include/uapi/asm/Kbuild                    |   1 +
 arch/sparc/include/uapi/asm/Kbuild                 |   1 +
 arch/tile/include/uapi/asm/Kbuild                  |   1 +
 arch/unicore32/include/uapi/asm/Kbuild             |   1 +
 arch/x86/include/uapi/asm/Kbuild                   |   1 +
 arch/xtensa/include/uapi/asm/Kbuild                |   1 +
 include/linux/perf_event.h                         |   6 +-
 include/uapi/asm-generic/bpf_perf_event.h          |   9 +
 include/uapi/linux/bpf_perf_event.h                |   5 +-
 kernel/events/core.c                               |   2 +-
 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h |   9 +
 tools/arch/s390/include/uapi/asm/bpf_perf_event.h  |   9 +
 tools/arch/s390/include/uapi/asm/ptrace.h          | 457 +++++++++++++++++++++
 tools/include/uapi/asm-generic/bpf_perf_event.h    |   9 +
 tools/include/uapi/linux/bpf_perf_event.h          |   6 +-
 tools/perf/arch/s390/Makefile                      |   1 +
 tools/perf/arch/s390/util/dwarf-regs.c             |  32 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/testing/selftests/bpf/Makefile               |  14 +-
 47 files changed, 668 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/s390/include/uapi/asm/bpf_perf_event.h
 create mode 100644 include/uapi/asm-generic/bpf_perf_event.h
 create mode 100644 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
 create mode 100644 tools/arch/s390/include/uapi/asm/bpf_perf_event.h
 create mode 100644 tools/arch/s390/include/uapi/asm/ptrace.h
 create mode 100644 tools/include/uapi/asm-generic/bpf_perf_event.h

-- 
1.8.3.1
