Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 17 Jun 2020 17:17:21 +1000
Subject: [v3 PATCH 2/2] printk: Make linux/printk.h self-contained
References: <20200617071524.GA3055@gondor.apana.org.au>
Message-Id: <E1jlSK1-0003hL-J3@fornost.hmeau.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

As it stands if you include printk.h by itself it will fail to
compile because it requires definitions from ratelimit.h.  However,
simply including ratelimit.h from printk.h does not work due to
inclusion loops involving sched.h and kernel.h.

This patch solves this by moving bits from ratelimit.h into a new
header file which can then be included by printk.h without any
worries about header loops.

The build bot then revealed some intriguing failures arising out
of this patch.  On s390 there is an inclusion loop with asm/bug.h
and linux/kernel.h that triggers a compile failure, because kernel.h
will cause asm-generic/bug.h to be included before s390's own
asm/bug.h has finished processing.  This has been fixed by not
including kernel.h in arch/s390/include/asm/bug.h.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

 arch/s390/include/asm/bug.h     |    2 -
 include/linux/printk.h          |    1 
 include/linux/ratelimit.h       |   36 ---------------------------------
 include/linux/ratelimit_types.h |   43 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 7725f8006fdfb..0b25f28351edc 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_S390_BUG_H
 #define _ASM_S390_BUG_H
 
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 
 #ifdef CONFIG_BUG
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index fc8f03c545430..34c1a7be3e014 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -7,6 +7,7 @@
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
 #include <linux/cache.h>
+#include <linux/ratelimit_types.h>
 
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index 8ddf79e9207a9..b17e0cd0a30cf 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -2,41 +2,10 @@
 #ifndef _LINUX_RATELIMIT_H
 #define _LINUX_RATELIMIT_H
 
-#include <linux/param.h>
+#include <linux/ratelimit_types.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 
-#define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
-#define DEFAULT_RATELIMIT_BURST		10
-
-/* issue num suppressed message on exit */
-#define RATELIMIT_MSG_ON_RELEASE	BIT(0)
-
-struct ratelimit_state {
-	raw_spinlock_t	lock;		/* protect the state */
-
-	int		interval;
-	int		burst;
-	int		printed;
-	int		missed;
-	unsigned long	begin;
-	unsigned long	flags;
-};
-
-#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {		\
-		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
-		.interval	= interval_init,			\
-		.burst		= burst_init,				\
-	}
-
-#define RATELIMIT_STATE_INIT_DISABLED					\
-	RATELIMIT_STATE_INIT(ratelimit_state, 0, DEFAULT_RATELIMIT_BURST)
-
-#define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)		\
-									\
-	struct ratelimit_state name =					\
-		RATELIMIT_STATE_INIT(name, interval_init, burst_init)	\
-
 static inline void ratelimit_state_init(struct ratelimit_state *rs,
 					int interval, int burst)
 {
@@ -73,9 +42,6 @@ ratelimit_set_flags(struct ratelimit_state *rs, unsigned long flags)
 
 extern struct ratelimit_state printk_ratelimit_state;
 
-extern int ___ratelimit(struct ratelimit_state *rs, const char *func);
-#define __ratelimit(state) ___ratelimit(state, __func__)
-
 #ifdef CONFIG_PRINTK
 
 #define WARN_ON_RATELIMIT(condition, state)	({		\
diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
new file mode 100644
index 0000000000000..b676aa419eef8
--- /dev/null
+++ b/include/linux/ratelimit_types.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RATELIMIT_TYPES_H
+#define _LINUX_RATELIMIT_TYPES_H
+
+#include <linux/bits.h>
+#include <linux/param.h>
+#include <linux/spinlock_types.h>
+
+#define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
+#define DEFAULT_RATELIMIT_BURST		10
+
+/* issue num suppressed message on exit */
+#define RATELIMIT_MSG_ON_RELEASE	BIT(0)
+
+struct ratelimit_state {
+	raw_spinlock_t	lock;		/* protect the state */
+
+	int		interval;
+	int		burst;
+	int		printed;
+	int		missed;
+	unsigned long	begin;
+	unsigned long	flags;
+};
+
+#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {		\
+		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
+		.interval	= interval_init,			\
+		.burst		= burst_init,				\
+	}
+
+#define RATELIMIT_STATE_INIT_DISABLED					\
+	RATELIMIT_STATE_INIT(ratelimit_state, 0, DEFAULT_RATELIMIT_BURST)
+
+#define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)		\
+									\
+	struct ratelimit_state name =					\
+		RATELIMIT_STATE_INIT(name, interval_init, burst_init)	\
+
+extern int ___ratelimit(struct ratelimit_state *rs, const char *func);
+#define __ratelimit(state) ___ratelimit(state, __func__)
+
+#endif /* _LINUX_RATELIMIT_TYPES_H */
