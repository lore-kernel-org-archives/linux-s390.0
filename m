Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 3/6] arm64/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date: Mon,  4 Dec 2017 10:56:46 +0100
In-Reply-To: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
Message-Id: <1512381409-19775-4-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Correct the broken uapi for the BPF_PROG_TYPE_PERF_EVENT program type
by exporting the user_pt_regs structure instead of the pt_regs structure
that is in-kernel only.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 arch/arm64/include/asm/perf_event.h          | 2 ++
 arch/arm64/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/arm64/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 8d5cbec..f9ccc36 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -18,6 +18,7 @@
 #define __ASM_PERF_EVENT_H
 
 #include <asm/stack_pointer.h>
+#include <asm/ptrace.h>
 
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
@@ -79,6 +80,7 @@
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
+#define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 #endif
 
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
diff --git a/arch/arm64/include/uapi/asm/bpf_perf_event.h b/arch/arm64/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 0000000..b551b74
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
-- 
1.8.3.1
