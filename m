Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20201210194043.362094758@linutronix.de>
Date: Thu, 10 Dec 2020 20:25:44 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/30] genirq: Provide kstat_irqdesc_cpu()
References: <20201210192536.118432146@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
List-ID: <linux-s390.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Most users of kstat_irqs_cpu() have the irq descriptor already. No point in
calling into the core code and looking it up once more.

Use it in per_cpu_count_show() to start with.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdesc.h |    6 ++++++
 kernel/irq/irqdesc.c    |    4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -113,6 +113,12 @@ static inline void irq_unlock_sparse(voi
 extern struct irq_desc irq_desc[NR_IRQS];
 #endif
 
+static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
+					      unsigned int cpu)
+{
+	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+}
+
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
 {
 	return container_of(data->common, struct irq_desc, irq_common_data);
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -147,12 +147,12 @@ static ssize_t per_cpu_count_show(struct
 				  struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	int cpu, irq = desc->irq_data.irq;
 	ssize_t ret = 0;
 	char *p = "";
+	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		unsigned int c = kstat_irqs_cpu(irq, cpu);
+		unsigned int c = irq_desc_kstat_cpu(desc, cpu);
 
 		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
 		p = ",";
