Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Jun 2020 22:51:45 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200611125144.GA2506@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

As it stands if you include printk.h it will fail to compile
because it requires definitions from ratelimit.h.  However, simply
including ratelimit.h from printk.h does not work due to inclusion
loops involving sched.h and kernel.h.

This patch solves this by moving bits from ratelimit.h into a new
header file which can then be included by printk.h without any
worries about header loops.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
new file mode 100644
index 000000000000..b676aa419eef
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
diff --git a/include/linux/printk.h b/include/linux/printk.h
index e061635e0409..1cd862cfd2f4 100644
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
index 8ddf79e9207a..b17e0cd0a30c 100644
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
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
