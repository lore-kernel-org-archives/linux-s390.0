Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] arch: fix 'unexpected IRQ trap at vector' warnings
Date: Mon,  7 Dec 2020 15:31:46 +0100
Message-Id: <20201207143146.30021-1-info@metux.net>
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org

All archs, except Alpha, print out the irq number in hex, but the message
looks like it was a decimal number, which is quite confusing. Fixing this
by adding "0x" prefix.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/arm/include/asm/hw_irq.h      | 2 +-
 arch/parisc/include/asm/hardirq.h  | 2 +-
 arch/powerpc/include/asm/hardirq.h | 2 +-
 arch/s390/include/asm/hardirq.h    | 2 +-
 arch/um/include/asm/hardirq.h      | 2 +-
 arch/x86/kernel/irq.c              | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
index cecc13214ef1..2749f19271d9 100644
--- a/arch/arm/include/asm/hw_irq.h
+++ b/arch/arm/include/asm/hw_irq.h
@@ -9,7 +9,7 @@ static inline void ack_bad_irq(int irq)
 {
 	extern unsigned long irq_err_count;
 	irq_err_count++;
-	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
+	pr_crit("unexpected IRQ trap at vector 0x%02x\n", irq);
 }
 
 #define ARCH_IRQ_INIT_FLAGS	(IRQ_NOREQUEST | IRQ_NOPROBE)
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 7f7039516e53..c3348af88d3f 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -35,6 +35,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 #define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
-#define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
+#define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector 0x%02x\n", irq)
 
 #endif /* _PARISC_HARDIRQ_H */
diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f133b5930ae1..ec8cf3cf6e49 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -29,7 +29,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_CRIT "unexpected IRQ trap at vector 0x%02x\n", irq);
 }
 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6c0674..aaaec5cdd4fe 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -23,7 +23,7 @@
 
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_CRIT "unexpected IRQ trap at vector 0x%02x\n", irq);
 }
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index b426796d26fd..2a2e6eae034b 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -15,7 +15,7 @@ typedef struct {
 #ifndef ack_bad_irq
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_CRIT "unexpected IRQ trap at vector 0x%02x\n", irq);
 }
 #endif
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c5dd50369e2f..957c716f2df7 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -37,7 +37,7 @@ atomic_t irq_err_count;
 void ack_bad_irq(unsigned int irq)
 {
 	if (printk_ratelimit())
-		pr_err("unexpected IRQ trap at vector %02x\n", irq);
+		pr_err("unexpected IRQ trap at vector 0x%02x\n", irq);
 
 	/*
 	 * Currently unexpected vectors happen only on SMP and APIC.
-- 
2.11.0
