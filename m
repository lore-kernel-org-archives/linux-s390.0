Return-Path: <travis@sgi.com>
Message-Id: <20081020170321.535939000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:33 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 14/35] cpumask: make nr_cpu_ids valid in all configurations.
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>
Cc: davej@codemonkey.org.uk, Jeremy Fitzhardinge <jeremy@goop.org>, Jes Sorensen <jes@sgi.com>, IA64 <linux-ia64@vger.kernel.org>, S390 <linux-s390@vger.kernel.org>, peterz@infradead.org, Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>, PowerPC <linuxppc-dev@ozlabs.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yhlu.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, SPARC <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

nr_cpu_ids is the (badly named) runtime limit on possible CPU numbers;
ie. the variable version of NR_CPUS.

This makes is valid in all configs, including UP.

From: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |   10 ++++++++--
 init/main.c             |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

--- test-compile.orig/include/linux/cpumask.h
+++ test-compile/include/linux/cpumask.h
@@ -195,6 +195,14 @@ extern cpumask_t _unused_cpumask_arg_;
 #define cpus_addr(src) ((src).bits)
 /* End deprecated region. */
 
+#if NR_CPUS <= BITS_PER_LONG
+/* Constant is usually more efficient than a variable for small NR_CPUS */
+#define nr_cpu_ids NR_CPUS
+#else
+/* Starts at NR_CPUS until we know better. */
+extern int nr_cpu_ids;
+#endif /* NR_CPUS > BITS_PER_LONG */
+
 static inline void cpumask_set_cpu(int cpu, volatile struct cpumask *dstp)
 {
 	set_bit(cpu, dstp->bits);
@@ -434,7 +442,6 @@ extern cpumask_t cpu_mask_all;
 
 #if NR_CPUS == 1
 
-#define nr_cpu_ids			1
 #define first_cpu(src)			({ (void)(src); 0; })
 #define next_cpu(n, src)		({ (void)(src); 1; })
 #define cpumask_next_and(n, srcp, andp)	({ (void)(srcp), (void)(andp); 1; })
@@ -447,7 +454,6 @@ extern cpumask_t cpu_mask_all;
 
 #else /* NR_CPUS > 1 */
 
-extern int nr_cpu_ids;
 int __first_cpu(const cpumask_t *srcp);
 int __next_cpu(int n, const cpumask_t *srcp);
 int cpumask_next_and(int n, const cpumask_t *srcp, const cpumask_t *andp);
--- test-compile.orig/init/main.c
+++ test-compile/init/main.c
@@ -373,6 +373,8 @@ EXPORT_SYMBOL(cpu_mask_all);
 #endif
 
 /* Setup number of possible processor ids */
+/* nr_cpu_ids is a real variable for large NR_CPUS. */
+#ifndef nr_cpu_ids
 int nr_cpu_ids __read_mostly = NR_CPUS;
 EXPORT_SYMBOL(nr_cpu_ids);
 
@@ -386,6 +388,11 @@ void __init setup_nr_cpu_ids(void)
 
 	nr_cpu_ids = highest_cpu + 1;
 }
+#else
+void __init setup_nr_cpu_ids(void)
+{
+}
+#endif /* ... nr_cpu_ids is a constant. */
 
 #ifndef CONFIG_HAVE_SETUP_PER_CPU_AREA
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;

-- 
