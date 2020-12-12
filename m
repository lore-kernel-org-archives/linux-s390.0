Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:40 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] genirq: Make kstat_irqs() static
In-Reply-To: <20201210194043.268774449@linutronix.de>
References: <20201210194043.268774449@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792041.3364.7294928960882791899.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     63ca4e066a62afce8ebaf75ebd4c6ef67f7bb5ee
Gitweb:        https://git.kernel.org/tip/63ca4e066a62afce8ebaf75ebd4c6ef67f7bb5ee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

genirq: Make kstat_irqs() static

No more users outside the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194043.268774449@linutronix.de

---
 include/linux/kernel_stat.h |  1 -
 kernel/irq/irqdesc.c        | 19 ++++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 89f0745..44ae1a7 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -67,7 +67,6 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
-extern unsigned int kstat_irqs(unsigned int irq);
 extern unsigned int kstat_irqs_usr(unsigned int irq);
 
 /*
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d28f69e..1f7325f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -924,15 +924,7 @@ static bool irq_is_nmi(struct irq_desc *desc)
 	return desc->istate & IRQS_NMI;
 }
 
-/**
- * kstat_irqs - Get the statistics for an interrupt
- * @irq:	The interrupt number
- *
- * Returns the sum of interrupt counts on all cpus since boot for
- * @irq. The caller must ensure that the interrupt is not removed
- * concurrently.
- */
-unsigned int kstat_irqs(unsigned int irq)
+static unsigned int kstat_irqs(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned int sum = 0;
@@ -951,13 +943,14 @@ unsigned int kstat_irqs(unsigned int irq)
 }
 
 /**
- * kstat_irqs_usr - Get the statistics for an interrupt
+ * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number
  *
  * Returns the sum of interrupt counts on all cpus since boot for @irq.
- * Contrary to kstat_irqs() this can be called from any context.
- * It uses rcu since a concurrent removal of an interrupt descriptor is
- * observing an rcu grace period before delayed_free_desc()/irq_kobj_release().
+ *
+ * It uses rcu to protect the access since a concurrent removal of an
+ * interrupt descriptor is observing an rcu grace period before
+ * delayed_free_desc()/irq_kobj_release().
  */
 unsigned int kstat_irqs_usr(unsigned int irq)
 {
