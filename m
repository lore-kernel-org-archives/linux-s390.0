From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 1/5] bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date: Fri,  1 Dec 2017 15:19:04 +0100
Message-ID: <1512137948-31729-2-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Commit 0515e5999a466dfe ("bpf: introduce BPF_PROG_TYPE_PERF_EVENT
program type") introduced the bpf_perf_event_data structure which
exports the pt_regs structure.  This is OK for multiple architectures
but fail for s390 and arm64 which do not export pt_regs.  Programs
using them, for example, the bpf selftest fail to compile on these
architectures.

For s390, exporting the pt_regs is not an option because s390 wants
to allow changes to it.  For arm64, there is a user_pt_regs structure
that covers parts of the pt_regs structure for use by user space.

To solve the broken uapi for s390 and arm64, introduce an abstract
type for pt_regs and add an asm/bpf_perf_event.h file that concretes
the type.  An asm-generic header file covers the architectures that
export pt_regs today.

The arch-specific enablement for s390 and arm64 follows in separate
commits.

Reported-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Fixes: 0515e5999a466dfe ("bpf: introduce BPF_PROG_TYPE_PERF_EVENT program type")
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-and-tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/perf_event.h                | 6 +++++-
 include/uapi/asm-generic/bpf_perf_event.h | 9 +++++++++
 include/uapi/linux/bpf_perf_event.h       | 5 ++---
 kernel/events/core.c                      | 2 +-
 4 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/asm-generic/bpf_perf_event.h

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2c9c87d..7546822 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -15,6 +15,7 @@
 #define _LINUX_PERF_EVENT_H
 
 #include <uapi/linux/perf_event.h>
+#include <uapi/linux/bpf_perf_event.h>
 
 /*
  * Kernel-internal data types and definitions:
@@ -787,7 +788,7 @@ struct perf_output_handle {
 };
 
 struct bpf_perf_event_data_kern {
-	struct pt_regs *regs;
+	bpf_user_pt_regs_t *regs;
 	struct perf_sample_data *data;
 	struct perf_event *event;
 };
@@ -1177,6 +1178,9 @@ extern void perf_tp_event(u16 event_type, u64 count, void *record,
 		(user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
 # define perf_instruction_pointer(regs)	instruction_pointer(regs)
 #endif
+#ifndef perf_arch_bpf_user_pt_regs
+# define perf_arch_bpf_user_pt_regs(regs) regs
+#endif
 
 static inline bool has_branch_stack(struct perf_event *event)
 {
diff --git a/include/uapi/asm-generic/bpf_perf_event.h b/include/uapi/asm-generic/bpf_perf_event.h
new file mode 100644
index 0000000..53815d2
--- /dev/null
+++ b/include/uapi/asm-generic/bpf_perf_event.h
@@ -0,0 +1,9 @@
+#ifndef _UAPI__ASM_GENERIC_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_GENERIC_BPF_PERF_EVENT_H__
+
+#include <linux/ptrace.h>
+
+/* Export kernel pt_regs structure */
+typedef struct pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_GENERIC_BPF_PERF_EVENT_H__ */
diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
index af549d4..8f95303 100644
--- a/include/uapi/linux/bpf_perf_event.h
+++ b/include/uapi/linux/bpf_perf_event.h
@@ -8,11 +8,10 @@
 #ifndef _UAPI__LINUX_BPF_PERF_EVENT_H__
 #define _UAPI__LINUX_BPF_PERF_EVENT_H__
 
-#include <linux/types.h>
-#include <linux/ptrace.h>
+#include <asm/bpf_perf_event.h>
 
 struct bpf_perf_event_data {
-	struct pt_regs regs;
+	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 16beab4..ba957b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7987,11 +7987,11 @@ static void bpf_overflow_handler(struct perf_event *event,
 {
 	struct bpf_perf_event_data_kern ctx = {
 		.data = data,
-		.regs = regs,
 		.event = event,
 	};
 	int ret = 0;
 
+	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
 	preempt_disable();
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
-- 
1.8.3.1
