Return-Path: <travis@sgi.com>
Message-Id: <20081020170320.986214000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:29 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 10/35] cpumask: introduce cpumask_var_t for local cpumask vars
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

We want to move cpumasks off the stack: no local decls, no passing by
copy.  Linus suggested we use the array-or-pointer trick for on-stack
vars; we introduce a new cpumask_var_t for this.

Rather than pick an arbitrary limit, I chose a new config option so
arch maintainers can decide where their threshold is.

From: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |   36 ++++++++++++++++++++++++++++++++++++
 lib/cpumask.c           |   31 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

--- test-compile.orig/include/linux/cpumask.h
+++ test-compile/include/linux/cpumask.h
@@ -485,6 +485,42 @@ int __next_cpu_nr(int n, const cpumask_t
 #endif /* NR_CPUS > 64 */
 
 /*
+ * cpumask_var_t: struct cpumask for stack usage.
+ *
+ * Oh, the wicked games we play!  In order to make kernel coding a
+ * little more difficult, we typedef cpumask_var_t to an array or a
+ * pointer: doing &mask on an array is a noop, so it still works.
+ *
+ * ie.
+ *	cpumask_var_t tmpmask;
+ *	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+ *		return -ENOMEM;
+ *
+ *	  ... use 'tmpmask' like a normal struct cpumask * ...
+ *
+ *	free_cpumask_var(tmpmask);
+ */
+#ifdef CONFIG_CPUMASK_OFFSTACK
+typedef struct cpumask *cpumask_var_t;
+
+bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags);
+void free_cpumask_var(cpumask_var_t mask);
+
+#else
+typedef struct cpumask cpumask_var_t[1];
+
+static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	return true;
+}
+
+static inline void free_cpumask_var(cpumask_var_t mask)
+{
+}
+
+#endif /* CONFIG_CPUMASK_OFFSTACK */
+
+/*
  * The following particular system cpumasks and operations manage
  * possible, present, active and online cpus.  Each of them is a fixed size
  * bitmap of size NR_CPUS.
--- test-compile.orig/lib/cpumask.c
+++ test-compile/lib/cpumask.c
@@ -43,3 +43,34 @@ int __any_online_cpu(const cpumask_t *ma
 	return cpu;
 }
 EXPORT_SYMBOL(__any_online_cpu);
+
+/* These are not inline because of header tangles. */
+#ifdef CONFIG_CPUMASK_OFFSTACK
+bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	if (likely(slab_is_available()))
+		*mask = kmalloc(BITS_TO_LONGS(nr_cpu_ids)*sizeof(long), flags);
+	else {
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+		printk(KERN_ERR
+			"=> alloc_cpumask_var: kmalloc not available!\n");
+		dump_stack();
+#endif
+		*mask = NULL;
+	}
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+	if (!*mask) {
+		printk(KERN_ERR "=> alloc_cpumask_var: failed!\n");
+		dump_stack();
+	}
+#endif
+	return *mask != NULL;
+}
+EXPORT_SYMBOL(alloc_cpumask_var);
+
+void free_cpumask_var(cpumask_var_t mask)
+{
+	kfree(mask);
+}
+EXPORT_SYMBOL(free_cpumask_var);
+#endif

-- 
