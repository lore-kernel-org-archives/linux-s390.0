From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:16:54 +0000
Subject: [strace PATCH 07/12] tests: check s390_guarded_storage system call decoder
Message-Id: <20180118061654.GA29086@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* configure.ac (AC_CHECK_HEADERS): Add asm/guarded_storage.h.
* tests/s390_guarded_storage-v.c: New file.
* tests/s390_guarded_storage.c: Likewise.
* tests/.gitignore: Add s390_guarded_storage, s390_guarded_storage-v.
* tests/pure_executables.list: Likewise.
* tests/gen_tests.in (s390_guarded_storage, s390_guarded_storage-v):
New tests.
---
 configure.ac                   |   1 +
 tests/.gitignore               |   2 +
 tests/gen_tests.in             |   4 +-
 tests/pure_executables.list    |   2 +
 tests/s390_guarded_storage-v.c |   2 +
 tests/s390_guarded_storage.c   | 229 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 tests/s390_guarded_storage-v.c
 create mode 100644 tests/s390_guarded_storage.c

diff --git a/configure.ac b/configure.ac
index 63595ce..fc164c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -392,6 +392,7 @@ AC_CHECK_MEMBERS(m4_normalize([
 
 AC_CHECK_HEADERS(m4_normalize([
 	asm/cachectl.h
+	asm/guarded_storage.h
 	asm/sysmips.h
 	bluetooth/bluetooth.h
 	elf.h
diff --git a/tests/.gitignore b/tests/.gitignore
index 19aa493..379d8c1 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -357,6 +357,8 @@ rt_sigsuspend
 rt_sigtimedwait
 rt_tgsigqueueinfo
 run_expect_termsig
+s390_guarded_storage
+s390_guarded_storage-v
 s390_sthyi
 s390_sthyi-v
 sched_get_priority_mxx
diff --git a/tests/gen_tests.in b/tests/gen_tests.in
index 968f6e4..5a9e4ed 100644
--- a/tests/gen_tests.in
+++ b/tests/gen_tests.in
@@ -303,8 +303,10 @@ rt_sigreturn	-esignal='!USR1'
 rt_sigsuspend	-a20 -esignal=none
 rt_sigtimedwait	-a38
 rt_tgsigqueueinfo	-esignal=none
+s390_guarded_storage	-a32
+s390_guarded_storage-v	-e trace=s390_guarded_storage -a32 -v
 s390_sthyi	-a47
-s390_sthyi-v	-e trace=s390_sthyi -a47
+s390_sthyi-v	-e trace=s390_sthyi -a47 -v
 sched	test_trace_expr times -e/sched
 sched_get_priority_mxx	-a33 -e trace=sched_get_priority_min,sched_get_priority_max
 sched_rr_get_interval	-a31
diff --git a/tests/pure_executables.list b/tests/pure_executables.list
index d8b997d..dc43a93 100755
--- a/tests/pure_executables.list
+++ b/tests/pure_executables.list
@@ -296,6 +296,8 @@ rt_sigreturn
 rt_sigsuspend
 rt_sigtimedwait
 rt_tgsigqueueinfo
+s390_guarded_storage
+s390_guarded_storage-v
 s390_sthyi
 s390_sthyi-v
 sched_get_priority_mxx
diff --git a/tests/s390_guarded_storage-v.c b/tests/s390_guarded_storage-v.c
new file mode 100644
index 0000000..05afd9f
--- /dev/null
+++ b/tests/s390_guarded_storage-v.c
@@ -0,0 +1,2 @@
+#define VERBOSE 1
+#include "s390_guarded_storage.c"
diff --git a/tests/s390_guarded_storage.c b/tests/s390_guarded_storage.c
new file mode 100644
index 0000000..ab67c15
--- /dev/null
+++ b/tests/s390_guarded_storage.c
@@ -0,0 +1,229 @@
+/*
+ * Check decoding of s390_guarded_storage syscall.
+ *
+ * Copyright (c) 2018 The strace developers.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote products
+ *    derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "tests.h"
+#include <asm/unistd.h>
+
+#if defined __NR_s390_guarded_storage && defined HAVE_ASM_GUARDED_STORAGE_H
+
+# include <inttypes.h>
+# include <stdbool.h>
+# include <stdint.h>
+# include <stdio.h>
+# include <unistd.h>
+
+# include <asm/guarded_storage.h>
+
+# ifndef VERBOSE
+#  define VERBOSE 0
+# endif
+
+static void
+gs_no_arg(kernel_ulong_t val, const char *val_str)
+{
+	static const kernel_ulong_t bogus_addr =
+		(kernel_ulong_t) 0xcaffeedadeadbed5ULL;
+	static const kernel_ulong_t bogus_cmd_mask =
+		(kernel_ulong_t) 0xbadc0ded00000000ULL;
+	long rc;
+
+	rc = syscall(__NR_s390_guarded_storage, val | bogus_cmd_mask,
+		     bogus_addr);
+	printf("s390_guarded_storage(%s) = %s\n", val_str, sprintrc(rc));
+}
+
+static void
+gs_print_epl(uint64_t addr, bool valid, const char *str)
+{
+	if (!valid) {
+		if (str)
+			printf("%s", str);
+		else
+			printf("%#" PRIx64, addr);
+
+		return;
+	}
+
+	struct gs_epl *gsepl = (struct gs_epl *) (uintptr_t) addr;
+
+	printf("[{");
+
+# if VERBOSE
+	if (gsepl->pad1)
+		printf("pad1=%#02x, ", gsepl->pad1);
+
+	printf("gs_eam=%#02x /* extended addressing mode: %u, "
+	       "basic addressing mode: %u */"
+	       ", gs_eci=%#02x /* CPU in TX: %u, CPU in CX: %u, "
+	       "instruction: %s */"
+	       ", gs_eai=%#02x /* DAT: %u, address space indication: %u, "
+	       "AR number: %u */, ",
+	       gsepl->gs_eam, gsepl->e, gsepl->b,
+	       gsepl->gs_eci, gsepl->tx, gsepl->cx,
+	       gsepl->in ? "LLGFGS": "LGG",
+	       gsepl->gs_eai, gsepl->t, gsepl->as, gsepl->ar);
+
+	if (gsepl->pad2)
+		printf("pad2=%#08x, ", gsepl->pad2);
+# endif /* VERBOSE */
+
+	printf("gs_eha=%#llx, ", (unsigned long long) gsepl->gs_eha);
+
+# if VERBOSE
+	printf("gs_eia=%#llx, gs_eoa=%#llx, gs_eir=%#llx, gs_era=%#llx",
+	       (unsigned long long) gsepl->gs_eia,
+	       (unsigned long long) gsepl->gs_eoa,
+	       (unsigned long long) gsepl->gs_eir,
+	       (unsigned long long) gsepl->gs_era);
+# else /* !VERBOSE */
+	printf("...");
+# endif /* VERBOSE */
+
+	printf("}]");
+}
+
+static void
+gs_set_cb(kernel_ulong_t addr, bool valid, bool epl_valid,
+	  const char *bc_str, const char *epl_str)
+{
+	static const kernel_ulong_t bogus_cmd_mask =
+		(kernel_ulong_t) 0xda7a105700000000ULL;
+
+	long rc;
+
+	printf("s390_guarded_storage(GS_SET_BC_CB, ");
+
+	if (valid) {
+		struct gs_cb *gscb = (struct gs_cb *) (uintptr_t) addr;
+
+		printf("{");
+
+		if (gscb->reserved)
+			printf("reserved=%#016llx, ",
+			       (unsigned long long) gscb->reserved);
+
+		printf("gsd=%#16llx",
+		       (unsigned long long) gscb->gsd);
+# if VERBOSE
+		printf(" /* GS origin: ");
+
+		unsigned int gsc = gscb->gsd & 0x3F;
+		unsigned int gls = (gscb->gsd >> 8) & 7;
+		bool gsc_valid = gsc >= 25 && gsc <= 56;
+
+		if (gsc_valid) {
+			uint64_t gls = gscb->gsd >> gsc;
+			int field_size = 2 + (67 - gsc) / 4;
+
+			printf("%#0*" PRIx64, field_size, gls);
+		} else {
+			printf("[invalid]");
+		}
+
+		printf(", guard load shift: %u, GS characteristic: %u */",
+		       gls, gsc);
+# endif /* VERBOSE */
+
+		printf(", gssm=%#016llx, gs_epl_a=",
+		       (unsigned long long) gscb->gssm);
+
+		gs_print_epl(gscb->gs_epl_a, epl_valid, epl_str);
+
+		printf("}");
+	} else {
+		if (bc_str)
+			printf("%s", bc_str);
+		else
+			printf("%#llx", (unsigned long long) addr);
+	}
+
+	rc = syscall(__NR_s390_guarded_storage,
+		     GS_SET_BC_CB | bogus_cmd_mask, addr);
+	printf(") = %s\n", sprintrc(rc));
+}
+
+int
+main(void)
+{
+	static const kernel_ulong_t bogus_cmd =
+		(kernel_ulong_t) 0xdeafbeefdeadc0deULL;
+	static const kernel_ulong_t bogus_addr =
+		(kernel_ulong_t) 0xfacefeedac0ffeedULL;
+
+	struct gs_cb *gscb = tail_alloc(sizeof(*gscb));
+	struct gs_epl *gsepl = tail_alloc(sizeof(*gsepl));
+
+	long rc;
+
+	rc = syscall(__NR_s390_guarded_storage, 5, 0);
+	printf("s390_guarded_storage(0x5 /* GS_??? */, NULL) = %s\n",
+	       sprintrc(rc));
+
+	rc = syscall(__NR_s390_guarded_storage, bogus_cmd, bogus_addr);
+	printf("s390_guarded_storage(%#x /* GS_??? */, %#lx) = %s\n",
+	       (unsigned) bogus_cmd, (unsigned long) bogus_addr, sprintrc(rc));
+
+	gs_no_arg(ARG_STR(GS_BROADCAST));
+	gs_no_arg(ARG_STR(GS_CLEAR_BC_CB));
+	gs_no_arg(ARG_STR(GS_DISABLE));
+	gs_no_arg(ARG_STR(GS_ENABLE));
+
+	fill_memory(gscb, sizeof(*gscb));
+	fill_memory_ex(gsepl, sizeof(*gsepl), 0xA5, 0x5A);
+
+	gs_set_cb(0, false, false, "NULL", NULL);
+	gs_set_cb((uintptr_t) (gscb + 1), false, false, NULL, NULL);
+
+	gscb->gs_epl_a = 0;
+	gs_set_cb((uintptr_t) gscb, true, false, NULL, "NULL");
+
+	fill_memory_ex(gscb, sizeof(*gscb), 0x5A, 0xA5);
+	gscb->gs_epl_a = (uintptr_t) (gsepl + 1) |
+		 (sizeof(kernel_ulong_t) < sizeof(uint64_t) ?
+			0xc0debad000000000ULL : 0);
+	gs_set_cb((uintptr_t) gscb, true, false, NULL, NULL);
+
+	fill_memory_ex(gscb, sizeof(*gscb), 0xA7, 0xA5);
+	gscb->gs_epl_a = (uintptr_t) gsepl;
+	gs_set_cb((uintptr_t) gscb, true, true, NULL, NULL);
+
+	fill_memory_ex(gscb, sizeof(*gscb), 0x55, 0xAA);
+	fill_memory_ex(gsepl, sizeof(*gsepl), 0x5A, 0xA5);
+	gscb->gs_epl_a = (uintptr_t) gsepl;
+	gs_set_cb((uintptr_t) gscb, true, true, NULL, NULL);
+
+	puts("+++ exited with 0 +++");
+	return 0;
+}
+
+#else
+
+SKIP_MAIN_UNDEFINED("__NR_s390_guarded_storage && HAVE_ASM_GUARDED_STORAGE_H")
+
+#endif
-- 
2.1.4
