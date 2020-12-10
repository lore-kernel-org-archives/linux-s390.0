Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393443AbgLJTm7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Dec 2020 14:42:59 -0500
Message-Id: <20201210194042.703779349@linutronix.de>
Date: Thu, 10 Dec 2020 20:25:38 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/30] genirq: Move status flag checks to core
References: <20201210192536.118432146@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
List-ID: <linux-s390.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

These checks are used by modules and prevent the removal of the export of
irq_to_desc(). Move the accessor into the core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdesc.h |   17 +++++------------
 kernel/irq/manage.c     |   17 +++++++++++++++++
 2 files changed, 22 insertions(+), 12 deletions(-)

--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -223,28 +223,21 @@ irq_set_chip_handler_name_locked(struct
 	data->chip = chip;
 }
 
+bool irq_check_status_bit(unsigned int irq, unsigned int bitmask);
+
 static inline bool irq_balancing_disabled(unsigned int irq)
 {
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
+	return irq_check_status_bit(irq, IRQ_NO_BALANCING_MASK);
 }
 
 static inline bool irq_is_percpu(unsigned int irq)
 {
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	return desc->status_use_accessors & IRQ_PER_CPU;
+	return irq_check_status_bit(irq, IRQ_PER_CPU);
 }
 
 static inline bool irq_is_percpu_devid(unsigned int irq)
 {
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	return desc->status_use_accessors & IRQ_PER_CPU_DEVID;
+	return irq_check_status_bit(irq, IRQ_PER_CPU_DEVID);
 }
 
 static inline void
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2769,3 +2769,23 @@ bool irq_has_action(unsigned int irq)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_has_action);
+
+/**
+ * irq_check_status_bit - Check whether bits in the irq descriptor status are set
+ * @irq:	The linux irq number
+ * @bitmask:	The bitmask to evaluate
+ *
+ * Returns: True if one of the bits in @bitmask is set
+ */
+bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
+{
+	struct irq_desc *desc;
+	bool res = false;
+
+	rcu_read_lock();
+	desc = irq_to_desc(irq);
+	if (desc)
+		res = !!(desc->status_use_accessors & bitmask);
+	rcu_read_unlock();
+	return res;
+}
