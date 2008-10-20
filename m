Return-Path: <travis@sgi.com>
Message-Id: <20081020170322.363319000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:39 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 20/35] cpumask: cpumask_of(): cpumask_of_cpu() which returns a
	pointer.
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

This deprecates cpumask_of_cpu(), which returns a cpumask_t
(cpumask_of() returns a const pointer, instead).

From: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- linux-2.6.28.orig/include/linux/cpumask.h
+++ linux-2.6.28/include/linux/cpumask.h
@@ -52,8 +52,7 @@
  * void cpumask_copy(dmask, smask)	dmask = smask
  *
  * size_t cpumask_size()		Length of cpumask in bytes.
- * cpumask_t cpumask_of_cpu(cpu)	Return cpumask with bit 'cpu' set
- *					(can be used as an lvalue)
+ * const struct cpumask *cpumask_of(cpu) Return cpumask with bit 'cpu' set
  * CPU_MASK_ALL				Initializer - all bits set
  * CPU_MASK_NONE			Initializer - no bits set
  * unsigned long *cpumask_bits(mask)	Array of unsigned long's in mask
@@ -176,6 +175,7 @@ extern cpumask_t _unused_cpumask_arg_;
 #define next_cpu_nr(n, src)		next_cpu(n, src)
 #define cpus_weight_nr(cpumask)		cpus_weight(cpumask)
 #define for_each_cpu_mask_nr(cpu, mask)	for_each_cpu_mask(cpu, mask)
+#define cpumask_of_cpu(cpu) (*cpumask_of(cpu))
 /* End deprecated region. */
 
 #if NR_CPUS <= BITS_PER_LONG
@@ -382,21 +382,13 @@ static inline void cpumask_copy(struct c
 extern const unsigned long
 	cpu_bit_bitmap[BITS_PER_LONG+1][BITS_TO_LONGS(NR_CPUS)];
 
-static inline const cpumask_t *get_cpu_mask(unsigned int cpu)
+static inline const struct cpumask *cpumask_of(unsigned int cpu)
 {
 	const unsigned long *p = cpu_bit_bitmap[1 + cpu % BITS_PER_LONG];
 	p -= cpu / BITS_PER_LONG;
-	return (const cpumask_t *)p;
+	return (const struct cpumask *)p;
 }
 
-/*
- * In cases where we take the address of the cpumask immediately,
- * gcc optimizes it out (it's a constant) and there's no huge stack
- * variable created:
- */
-#define cpumask_of_cpu(cpu) (*get_cpu_mask(cpu))
-
-
 #define CPU_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(NR_CPUS)
 
 #if NR_CPUS <= BITS_PER_LONG

-- 
