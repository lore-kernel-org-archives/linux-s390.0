Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 2/6] s390/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date: Mon,  4 Dec 2017 10:56:45 +0100
In-Reply-To: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
Message-Id: <1512381409-19775-3-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

To mitigate and correct the broken uapi for the BPF_PROG_TYPE_PERF_EVENT
program type, introduce a user_pt_regs structure (similar to arm64) that
exports parts from the beginnig of the pt_regs structure.

The export must start with the beginning of the pt_regs structure because
to correctly calculate BPF prologues for perf (regs_query_register_offset()).

For BPF_PROG_TYPE_PERF_EVENT program types, the BPF program is then passed
a user_pt_regs structure.

Note: Depending on future changes to the s390 pt_regs structure, consider
the user_pt_regs structure to be stable for a particular kernel version
only. (Of course, s390 tries to ensure keep it stable as much as possible.)

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-and-tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/s390/include/asm/perf_event.h          |  1 +
 arch/s390/include/asm/ptrace.h              | 11 ++++++++---
 arch/s390/include/uapi/asm/bpf_perf_event.h |  9 +++++++++
 arch/s390/include/uapi/asm/ptrace.h         | 11 +++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index d6c9d1e..b9c0e36 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -40,6 +40,7 @@ extern ssize_t cpumf_events_sysfs_show(struct device *dev,
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs) perf_misc_flags(regs)
+#define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 
 /* Perf pt_regs extension for sample-data-entry indicators */
 struct perf_sf_sde_regs {
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index a3788da..6f70d81 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -74,9 +74,14 @@ enum {
  */
 struct pt_regs 
 {
-	unsigned long args[1];
-	psw_t psw;
-	unsigned long gprs[NUM_GPRS];
+	union {
+		user_pt_regs user_regs;
+		struct {
+			unsigned long args[1];
+			psw_t psw;
+			unsigned long gprs[NUM_GPRS];
+		};
+	};
 	unsigned long orig_gpr2;
 	unsigned int int_code;
 	unsigned int int_parm;
diff --git a/arch/s390/include/uapi/asm/bpf_perf_event.h b/arch/s390/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 0000000..cefe7c7
--- /dev/null
+++ b/arch/s390/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index 0d23c8f..70f7cb2 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -291,6 +291,17 @@
 } s390_regs;
 
 /*
+ * The user_pt_regs structure exports the beginning of
+ * the in-kernel pt_regs structure to user space.
+ */
+typedef struct
+{
+	unsigned long args[1];
+	psw_t psw;
+	unsigned long gprs[NUM_GPRS];
+} user_pt_regs;
+
+/*
  * Now for the user space program event recording (trace) definitions.
  * The following structures are used only for the ptrace interface, don't
  * touch or even look at it if you don't want to modify the user-space
-- 
1.8.3.1
