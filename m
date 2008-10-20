Return-Path: <travis@sgi.com>
Message-Id: <20081020170323.335697000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:46 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 27/35] cpumask: to_cpumask()
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

There are times when we really want a static cpumask.  Yet we don't
want to expose the struct cpumask definition, to avoid casual on-stack
usage and assignment.

So this macro allows you to do DECLARE_BITMAP(map, CONFIG_NR_CPUS); then use
to_cpumask() to turn it into a cpumask as needed.

Ugly?  Yes, but as we move to fewer static cpumasks these calls vanish.

From: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux-2.6.28.orig/include/linux/cpumask.h
+++ linux-2.6.28/include/linux/cpumask.h
@@ -57,6 +57,9 @@
  * CPU_MASK_NONE			Initializer - no bits set
  * unsigned long *cpumask_bits(mask)	Array of unsigned long's in mask
  *
+ * struct cpumask *to_cpumask(const unsigned long[])
+ *					Convert a bitmap to a cpumask.
+ *
  * ------------------------------------------------------------------------
  *
  * int cpumask_scnprintf(buf, len, mask) Format cpumask for printing
@@ -362,6 +365,17 @@ static inline void cpumask_copy(struct c
 #define cpumask_any(srcp) cpumask_first(srcp)
 #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
 
+/* Used for static bitmaps of CONFIG_NR_CPUS bits.  Must be a constant to use
+ * as an initializer. */
+#define to_cpumask(bitmap)						\
+	((struct cpumask *)(1 ? (bitmap)				\
+			    : (void *)sizeof(__check_is_bitmap(bitmap))))
+
+static inline int __check_is_bitmap(const unsigned long *bitmap)
+{
+	return 1;
+}
+
 /*
  * Special-case data structure for "single bit set only" constant CPU masks.
  *

-- 
