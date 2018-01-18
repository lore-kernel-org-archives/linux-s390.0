From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:17:00 +0000
Subject: [strace PATCH 09/12] tests: check s390_runtime_instr system call decoder
Message-Id: <20180118061700.GA29176@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* tests/s390_runtime_instr.c: New file.
* tests/.gitignore: Add s390_runtime_instr.
* tests/pure_executables.list: Likewise.
* tests/gen_tests.in (s390_runtime_instr): New test.
---
 tests/.gitignore            |  1 +
 tests/gen_tests.in          |  1 +
 tests/pure_executables.list |  1 +
 tests/s390_runtime_instr.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 tests/s390_runtime_instr.c

diff --git a/tests/.gitignore b/tests/.gitignore
index 379d8c1..eaa1141 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -359,6 +359,7 @@ rt_tgsigqueueinfo
 run_expect_termsig
 s390_guarded_storage
 s390_guarded_storage-v
+s390_runtime_instr
 s390_sthyi
 s390_sthyi-v
 sched_get_priority_mxx
diff --git a/tests/gen_tests.in b/tests/gen_tests.in
index 5a9e4ed..a6dea9f 100644
--- a/tests/gen_tests.in
+++ b/tests/gen_tests.in
@@ -305,6 +305,7 @@ rt_sigtimedwait	-a38
 rt_tgsigqueueinfo	-esignal=none
 s390_guarded_storage	-a32
 s390_guarded_storage-v	-e trace=s390_guarded_storage -a32 -v
+s390_runtime_instr	-a50
 s390_sthyi	-a47
 s390_sthyi-v	-e trace=s390_sthyi -a47 -v
 sched	test_trace_expr times -e/sched
diff --git a/tests/pure_executables.list b/tests/pure_executables.list
index dc43a93..9c61da2 100755
--- a/tests/pure_executables.list
+++ b/tests/pure_executables.list
@@ -298,6 +298,7 @@ rt_sigtimedwait
 rt_tgsigqueueinfo
 s390_guarded_storage
 s390_guarded_storage-v
+s390_runtime_instr
 s390_sthyi
 s390_sthyi-v
 sched_get_priority_mxx
diff --git a/tests/s390_runtime_instr.c b/tests/s390_runtime_instr.c
new file mode 100644
index 0000000..861bbd4
--- /dev/null
+++ b/tests/s390_runtime_instr.c
@@ -0,0 +1,99 @@
+/*
+ * Check decoding of s390_runtime_instr syscall.
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
+#if defined __NR_s390_runtime_instr
+
+# include <errno.h>
+# include <signal.h>
+# include <stdio.h>
+# include <unistd.h>
+
+int
+main(void)
+{
+	static struct {
+		kernel_ulong_t cmd;
+		const char * cmd_str;
+	} cmd_args[] = {
+		{ 0, "???" },
+		{ 4, "???" },
+		{ (kernel_ulong_t) 0xdeafbeefdeadc0deULL, "???" },
+		{ 2, "STOP",  },
+	};
+
+	static struct {
+		kernel_ulong_t sig;
+		const char * sig_str;
+	} start_sig_args[] = {
+		{ 0, "SIG_0" },
+		{ (kernel_ulong_t) 0xfacefeedac0ffeedULL, NULL },
+		{ ARG_STR(SIGALRM) },
+		{ 33, "SIGRT_1" },
+		{ 63, "SIGRT_31" },
+	};
+
+	unsigned int i;
+	long rc;
+
+	for (i = 0; i < ARRAY_SIZE(cmd_args); i++) {
+		rc = syscall(__NR_s390_runtime_instr, cmd_args[i].cmd, 0xdead);
+		printf("s390_runtime_instr(%d /* S390_RUNTIME_INSTR_%s */) = "
+		       "%s\n",
+		       (int) cmd_args[i].cmd, cmd_args[i].cmd_str,
+		       sprintrc(rc));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(start_sig_args); i++) {
+		long saved_errno;
+
+		rc = syscall(__NR_s390_runtime_instr, 1, start_sig_args[i].sig);
+		saved_errno = errno;
+		printf("s390_runtime_instr(1 /* S390_RUNTIME_INSTR_START */, ");
+
+		if (start_sig_args[i].sig_str)
+			printf("%s", start_sig_args[i].sig_str);
+		else
+			printf("%d", (int) start_sig_args[i].sig);
+
+		errno = saved_errno;
+		printf(") = %s\n", sprintrc(rc));
+	}
+
+	puts("+++ exited with 0 +++");
+	return 0;
+}
+
+#else
+
+SKIP_MAIN_UNDEFINED("__NR_s390_runtime_instr")
+
+#endif
-- 
2.1.4
