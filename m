Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 1/6] bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date: Mon,  4 Dec 2017 10:56:44 +0100
In-Reply-To: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
Message-Id: <1512381409-19775-2-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
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
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/alpha/include/uapi/asm/Kbuild        | 2 ++
 arch/arc/include/uapi/asm/Kbuild          | 1 +
 arch/arm/include/uapi/asm/Kbuild          | 1 +
 arch/blackfin/include/uapi/asm/Kbuild     | 1 +
 arch/c6x/include/uapi/asm/Kbuild          | 1 +
 arch/cris/include/uapi/asm/Kbuild         | 1 +
 arch/frv/include/uapi/asm/Kbuild          | 2 ++
 arch/h8300/include/uapi/asm/Kbuild        | 1 +
 arch/hexagon/include/uapi/asm/Kbuild      | 1 +
 arch/ia64/include/uapi/asm/Kbuild         | 1 +
 arch/m32r/include/uapi/asm/Kbuild         | 1 +
 arch/m68k/include/uapi/asm/Kbuild         | 1 +
 arch/metag/include/uapi/asm/Kbuild        | 1 +
 arch/microblaze/include/uapi/asm/Kbuild   | 1 +
 arch/mips/include/uapi/asm/Kbuild         | 1 +
 arch/mn10300/include/uapi/asm/Kbuild      | 1 +
 arch/nios2/include/uapi/asm/Kbuild        | 1 +
 arch/openrisc/include/uapi/asm/Kbuild     | 1 +
 arch/parisc/include/uapi/asm/Kbuild       | 1 +
 arch/powerpc/include/uapi/asm/Kbuild      | 1 +
 arch/riscv/include/uapi/asm/Kbuild        | 1 +
 arch/score/include/uapi/asm/Kbuild        | 1 +
 arch/sh/include/uapi/asm/Kbuild           | 1 +
 arch/sparc/include/uapi/asm/Kbuild        | 1 +
 arch/tile/include/uapi/asm/Kbuild         | 1 +
 arch/unicore32/include/uapi/asm/Kbuild    | 1 +
 arch/x86/include/uapi/asm/Kbuild          | 1 +
 arch/xtensa/include/uapi/asm/Kbuild       | 1 +
 include/linux/perf_event.h                | 6 +++++-
 include/uapi/asm-generic/bpf_perf_event.h | 9 +++++++++
 include/uapi/linux/bpf_perf_event.h       | 5 ++---
 kernel/events/core.c                      | 2 +-
 32 files changed, 47 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/asm-generic/bpf_perf_event.h

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index b15bf6b..14a2e9a 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -1,2 +1,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += bpf_perf_event.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index fa6d0ff..170b5db 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 4d53de3..4d1cc18 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -7,6 +7,7 @@ generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
 
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += ioctl.h
 generic-y += ipcbuf.h
diff --git a/arch/blackfin/include/uapi/asm/Kbuild b/arch/blackfin/include/uapi/asm/Kbuild
index aa624b4..2240b38 100644
--- a/arch/blackfin/include/uapi/asm/Kbuild
+++ b/arch/blackfin/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += ioctl.h
 generic-y += ipcbuf.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 67ee896..26644e1 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/cris/include/uapi/asm/Kbuild b/arch/cris/include/uapi/asm/Kbuild
index 3687b54..3470c6e 100644
--- a/arch/cris/include/uapi/asm/Kbuild
+++ b/arch/cris/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/frv/include/uapi/asm/Kbuild b/arch/frv/include/uapi/asm/Kbuild
index b15bf6b..14a2e9a 100644
--- a/arch/frv/include/uapi/asm/Kbuild
+++ b/arch/frv/include/uapi/asm/Kbuild
@@ -1,2 +1,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += bpf_perf_event.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 187aed8..2f65f78 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index cb5df3a..41a176d 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 13a97aa..f5c6967 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
diff --git a/arch/m32r/include/uapi/asm/Kbuild b/arch/m32r/include/uapi/asm/Kbuild
index 1c44d3b..451bf60 100644
--- a/arch/m32r/include/uapi/asm/Kbuild
+++ b/arch/m32r/include/uapi/asm/Kbuild
@@ -1,5 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
 generic-y += siginfo.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 3717b64..c2e26a4 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += ioctl.h
 generic-y += ipcbuf.h
diff --git a/arch/metag/include/uapi/asm/Kbuild b/arch/metag/include/uapi/asm/Kbuild
index 6ac763d..f9eaf07 100644
--- a/arch/metag/include/uapi/asm/Kbuild
+++ b/arch/metag/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 06609ca..2c6a6bf 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index a0266fe..7a4becd 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generic-y += ipcbuf.h
diff --git a/arch/mn10300/include/uapi/asm/Kbuild b/arch/mn10300/include/uapi/asm/Kbuild
index c94ee54..81271d3 100644
--- a/arch/mn10300/include/uapi/asm/Kbuild
+++ b/arch/mn10300/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y	+= bpf_perf_event.h
 generic-y	+= siginfo.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index ffca24d..13a3d77 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 62286db..130c16c 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index 196d2a4..286ef5a 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
+generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
 generic-y += param.h
 generic-y += poll.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 0d960ef..1a6ed59 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -1,6 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 5ded96b..7e91f48 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += setup.h
 generic-y += unistd.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/score/include/uapi/asm/Kbuild b/arch/score/include/uapi/asm/Kbuild
index c94ee54..81271d3 100644
--- a/arch/score/include/uapi/asm/Kbuild
+++ b/arch/score/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y	+= bpf_perf_event.h
 generic-y	+= siginfo.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index e285313..ba4d39c 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index 2178c78..4680ba2 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generic-y += types.h
diff --git a/arch/tile/include/uapi/asm/Kbuild b/arch/tile/include/uapi/asm/Kbuild
index 5711de0..cc43961 100644
--- a/arch/tile/include/uapi/asm/Kbuild
+++ b/arch/tile/include/uapi/asm/Kbuild
@@ -1,6 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 759a714..8611ef9 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index da1489c..1e901e4 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -1,6 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bpf_perf_event.h
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index a5bcdfb..837d4dd 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bitsperlong.h
+generic-y += bpf_perf_event.h
 generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
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
