Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404279AbgLJTnF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Dec 2020 14:43:05 -0500
Message-Id: <20201210194043.268774449@linutronix.de>
Date: Thu, 10 Dec 2020 20:25:43 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/30] genirq: Make kstat_irqs() static
References: <20201210192536.118432146@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
List-ID: <linux-s390.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

No more users outside the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/kernel_stat.h |    1 -
 kernel/irq/irqdesc.c        |   19 ++++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -67,7 +67,6 @@ static inline unsigned int kstat_softirq
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
-extern unsigned int kstat_irqs(unsigned int irq);
 extern unsigned int kstat_irqs_usr(unsigned int irq);
 
 /*
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -924,15 +924,7 @@ static bool irq_is_nmi(struct irq_desc *
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
@@ -951,13 +943,14 @@ unsigned int kstat_irqs(unsigned int irq
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
