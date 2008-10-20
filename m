Return-Path: <travis@sgi.com>
Message-Id: <20081020170320.007751000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:22 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 03/35] cpumask: add for_each_cpu_mask_and function
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

Add for_each_cpu_mask_and() function to eliminate need for a common use
of a temporary cpumask_t variable.  When the following procedure is being
used:

    funcproto(const cpumask_t *mask, ...)
    {
	cpumask_t temp;

	cpus_and(temp, mask, cpu_online_map);
	for_each_cpu_mask(cpu, temp)
		...
It then becomes:

    funcproto(cpumask_t *mask, ...)
    {
	for_each_cpu_mask_and(cpu, *mask, cpu_online_map)
		...

... eliminating the need for the temp cpumask.


Applies to linux-2.6.tip/master.

Signed-off-by: Mike Travis <travis@sgi.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/cpumask.h |   33 ++++++++++++++++++++++++---------
 lib/cpumask.c           |    9 +++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)

--- test-compile.orig/include/linux/cpumask.h
+++ test-compile/include/linux/cpumask.h
@@ -109,6 +109,7 @@
  *
  * for_each_cpu_mask(cpu, mask)		for-loop cpu over mask using NR_CPUS
  * for_each_cpu_mask_nr(cpu, mask)	for-loop cpu over mask using nr_cpu_ids
+ * for_each_cpu_mask_and(cpu, mask, and) for-loop cpu over (mask & and).
  *
  * int num_online_cpus()		Number of online CPUs
  * int num_possible_cpus()		Number of all possible CPUs
@@ -400,29 +401,41 @@ static inline void __cpus_fold(cpumask_t
 
 #if NR_CPUS == 1
 
-#define nr_cpu_ids		1
-#define first_cpu(src)		({ (void)(src); 0; })
-#define next_cpu(n, src)	({ (void)(src); 1; })
-#define any_online_cpu(mask)	0
-#define for_each_cpu_mask(cpu, mask)	\
+#define nr_cpu_ids			1
+#define first_cpu(src)			({ (void)(src); 0; })
+#define next_cpu(n, src)		({ (void)(src); 1; })
+#define cpumask_next_and(n, srcp, andp)	({ (void)(srcp), (void)(andp); 1; })
+#define any_online_cpu(mask)		0
+
+#define for_each_cpu_mask(cpu, mask)		\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
+#define for_each_cpu_mask_and(cpu, mask, and)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
 
 #else /* NR_CPUS > 1 */
 
 extern int nr_cpu_ids;
 int __first_cpu(const cpumask_t *srcp);
 int __next_cpu(int n, const cpumask_t *srcp);
+int cpumask_next_and(int n, const cpumask_t *srcp, const cpumask_t *andp);
 int __any_online_cpu(const cpumask_t *mask);
 
 #define first_cpu(src)		__first_cpu(&(src))
 #define next_cpu(n, src)	__next_cpu((n), &(src))
 #define any_online_cpu(mask) __any_online_cpu(&(mask))
+
 #define for_each_cpu_mask(cpu, mask)			\
 	for ((cpu) = -1;				\
 		(cpu) = next_cpu((cpu), (mask)),	\
-		(cpu) < NR_CPUS; )
+		(cpu) < NR_CPUS;)
+#define for_each_cpu_mask_and(cpu, mask, and)				\
+	for ((cpu) = -1;						\
+		(cpu) = cpumask_next_and((cpu), &(mask), &(and)),	\
+		(cpu) < nr_cpu_ids;)
 #endif
 
+#define cpumask_first_and(mask, and) cpumask_next_and(-1, (mask), (and))
+
 #if NR_CPUS <= 64
 
 #define next_cpu_nr(n, src)		next_cpu(n, src)
@@ -432,12 +445,14 @@ int __any_online_cpu(const cpumask_t *ma
 #else /* NR_CPUS > 64 */
 
 int __next_cpu_nr(int n, const cpumask_t *srcp);
-#define next_cpu_nr(n, src)	__next_cpu_nr((n), &(src))
-#define cpus_weight_nr(cpumask)	__cpus_weight(&(cpumask), nr_cpu_ids)
+
+#define next_cpu_nr(n, src)		__next_cpu_nr((n), &(src))
+#define cpus_weight_nr(cpumask)		__cpus_weight(&(cpumask), nr_cpu_ids)
+
 #define for_each_cpu_mask_nr(cpu, mask)			\
 	for ((cpu) = -1;				\
 		(cpu) = next_cpu_nr((cpu), (mask)),	\
-		(cpu) < nr_cpu_ids; )
+		(cpu) < nr_cpu_ids;)
 
 #endif /* NR_CPUS > 64 */
 
--- test-compile.orig/lib/cpumask.c
+++ test-compile/lib/cpumask.c
@@ -15,6 +15,15 @@ int __next_cpu(int n, const cpumask_t *s
 }
 EXPORT_SYMBOL(__next_cpu);
 
+int cpumask_next_and(int n, const cpumask_t *srcp, const cpumask_t *andp)
+{
+	while ((n = next_cpu_nr(n, *srcp)) < nr_cpu_ids)
+		if (cpu_isset(n, *andp))
+			break;
+	return n;
+}
+EXPORT_SYMBOL(cpumask_next_and);
+
 #if NR_CPUS > 64
 int __next_cpu_nr(int n, const cpumask_t *srcp)
 {

-- 
