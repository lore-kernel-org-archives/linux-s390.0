Return-Path: <travis@sgi.com>
Message-Id: <20081020170323.466127000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:47 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 28/35] cpumask: accessors to manipulate
	possible/present/online/active maps
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

Since we are moving to const cpumask pointers for the maps, we need a
way to legitimately access them.  Simple accessors work well.

From: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |    9 +++++++++
 kernel/cpu.c            |   42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

--- linux-2.6.28.orig/include/linux/cpumask.h
+++ linux-2.6.28/include/linux/cpumask.h
@@ -604,6 +604,15 @@ extern cpumask_t cpu_active_map;
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
 
+/* Wrappers to manipulate otherwise-constant masks. */
+void set_cpu_possible(unsigned int cpu, bool possible);
+void set_cpu_present(unsigned int cpu, bool present);
+void set_cpu_online(unsigned int cpu, bool online);
+void set_cpu_active(unsigned int cpu, bool active);
+void init_cpu_present(const struct cpumask *src);
+void init_cpu_possible(const struct cpumask *src);
+void init_cpu_online(const struct cpumask *src);
+
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
 
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), &cpu_possible_map)
--- linux-2.6.28.orig/kernel/cpu.c
+++ linux-2.6.28/kernel/cpu.c
@@ -490,7 +490,6 @@ void notify_cpu_starting(unsigned int cp
 #define MASK_DECLARE_8(x)	MASK_DECLARE_4(x), MASK_DECLARE_4(x+4)
 
 const unsigned long cpu_bit_bitmap[BITS_PER_LONG+1][BITS_TO_LONGS(NR_CPUS)] = {
-
 	MASK_DECLARE_8(0),	MASK_DECLARE_8(8),
 	MASK_DECLARE_8(16),	MASK_DECLARE_8(24),
 #if BITS_PER_LONG > 32
@@ -499,3 +498,44 @@ const unsigned long cpu_bit_bitmap[BITS_
 #endif
 };
 EXPORT_SYMBOL_GPL(cpu_bit_bitmap);
+
+void set_cpu_possible(unsigned int cpu, bool possible)
+{
+	if (possible)
+		cpumask_set_cpu(cpu, &cpu_possible_map);
+	else
+		cpumask_clear_cpu(cpu, &cpu_possible_map);
+}
+void set_cpu_present(unsigned int cpu, bool present)
+{
+	if (present)
+		cpumask_set_cpu(cpu, &cpu_present_map);
+	else
+		cpumask_clear_cpu(cpu, &cpu_present_map);
+}
+void set_cpu_online(unsigned int cpu, bool online)
+{
+	if (online)
+		cpumask_set_cpu(cpu, &cpu_online_map);
+	else
+		cpumask_clear_cpu(cpu, &cpu_online_map);
+}
+void set_cpu_active(unsigned int cpu, bool active)
+{
+	if (active)
+		cpumask_set_cpu(cpu, &cpu_active_map);
+	else
+		cpumask_clear_cpu(cpu, &cpu_active_map);
+}
+void init_cpu_present(const struct cpumask *src)
+{
+	cpumask_copy(&cpu_present_map, src);
+}
+void init_cpu_possible(const struct cpumask *src)
+{
+	cpumask_copy(&cpu_possible_map, src);
+}
+void init_cpu_online(const struct cpumask *src)
+{
+	cpumask_copy(&cpu_online_map, src);
+}

-- 
