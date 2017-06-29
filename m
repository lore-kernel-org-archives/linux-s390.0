From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:35 +0000
Subject: [CRIU][PATCH v2 07/17] s390: Fix clone() syscall parameters for s390
Message-Id: <20170629192445.55580-8-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On s390 the first two paramters are swapped because we use
the CONFIG_CLONE_BACKWARDS2 kernel config option.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/util.c          | 5 +++++
 test/zdtm/lib/test.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/criu/util.c b/criu/util.c
index db484f2..2adc613 100644
--- a/criu/util.c
+++ b/criu/util.c
@@ -1427,5 +1427,10 @@ pid_t fork()
 	 * Two last arguments are swapped on different archs,
 	 * but we don't care as they are zero anyway.
 	 */
+#ifdef __s390x__
+	/* See kernel/fork.c: CONFIG_CLONE_BACKWARDS2 */
+	return (pid_t)syscall(__NR_clone, 0, SIGCHLD, NULL, 0, NULL);
+#else
 	return (pid_t)syscall(__NR_clone, SIGCHLD, 0, 0, 0, 0);
+#endif
 }
diff --git a/test/zdtm/lib/test.c b/test/zdtm/lib/test.c
index 76357da..5f12083 100644
--- a/test/zdtm/lib/test.c
+++ b/test/zdtm/lib/test.c
@@ -292,7 +292,12 @@ pid_t fork()
 	 * Two last arguments are swapped on different archs,
 	 * but we don't care as they are zero anyway.
 	 */
+#ifdef __s390x__
+	/* See kernel/fork.c: CONFIG_CLONE_BACKWARDS2 */
+	return (pid_t)syscall(__NR_clone, 0, SIGCHLD, NULL, 0, NULL);
+#else
 	return (pid_t)syscall(__NR_clone, SIGCHLD, 0, 0, 0, 0);
+#endif
 }
 
 int getpid()
-- 
2.7.4
