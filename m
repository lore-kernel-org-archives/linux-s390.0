Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:34 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] xen/events: Implement irq distribution
In-Reply-To: <20201210194045.457218278@linutronix.de>
References: <20201210194045.457218278@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791448.3364.2400431156679652798.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     93b6adbf0420a7bd84167a4feb289cc2c1b4efca
Gitweb:        https://git.kernel.org/tip/93b6adbf0420a7bd84167a4feb289cc2c1b4efca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:07 +01:00

xen/events: Implement irq distribution

Keep track of the assignments of event channels to CPUs and select the
online CPU with the least assigned channels in the affinity mask which is
handed to irq_chip::irq_set_affinity() from the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20201210194045.457218278@linutronix.de

---
 drivers/xen/events/events_base.c | 76 +++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index b352440..a803033 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -96,6 +96,7 @@ struct irq_info {
 	struct list_head eoi_list;
 	short refcnt;
 	u8 spurious_cnt;
+	u8 is_accounted;
 	enum xen_irq_type type; /* type */
 	unsigned irq;
 	evtchn_port_t evtchn;   /* event channel */
@@ -161,6 +162,9 @@ static DEFINE_PER_CPU(int [NR_VIRQS], virq_to_irq) = {[0 ... NR_VIRQS-1] = -1};
 /* IRQ <-> IPI mapping */
 static DEFINE_PER_CPU(int [XEN_NR_IPIS], ipi_to_irq) = {[0 ... XEN_NR_IPIS-1] = -1};
 
+/* Event channel distribution data */
+static atomic_t channels_on_cpu[NR_CPUS];
+
 static int **evtchn_to_irq;
 #ifdef CONFIG_X86
 static unsigned long *pirq_eoi_map;
@@ -257,6 +261,32 @@ static void set_info_for_irq(unsigned int irq, struct irq_info *info)
 		irq_set_chip_data(irq, info);
 }
 
+/* Per CPU channel accounting */
+static void channels_on_cpu_dec(struct irq_info *info)
+{
+	if (!info->is_accounted)
+		return;
+
+	info->is_accounted = 0;
+
+	if (WARN_ON_ONCE(info->cpu >= nr_cpu_ids))
+		return;
+
+	WARN_ON_ONCE(!atomic_add_unless(&channels_on_cpu[info->cpu], -1 , 0));
+}
+
+static void channels_on_cpu_inc(struct irq_info *info)
+{
+	if (WARN_ON_ONCE(info->cpu >= nr_cpu_ids))
+		return;
+
+	if (WARN_ON_ONCE(!atomic_add_unless(&channels_on_cpu[info->cpu], 1,
+					    INT_MAX)))
+		return;
+
+	info->is_accounted = 1;
+}
+
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
 				     unsigned irq,
@@ -339,6 +369,7 @@ static void xen_irq_info_cleanup(struct irq_info *info)
 {
 	set_evtchn_to_irq(info->evtchn, -1);
 	info->evtchn = 0;
+	channels_on_cpu_dec(info);
 }
 
 /*
@@ -449,7 +480,9 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
 
 	xen_evtchn_port_bind_to_cpu(evtchn, cpu, info->cpu);
 
+	channels_on_cpu_dec(info);
 	info->cpu = cpu;
+	channels_on_cpu_inc(info);
 }
 
 /**
@@ -622,11 +655,6 @@ static void xen_irq_init(unsigned irq)
 {
 	struct irq_info *info;
 
-#ifdef CONFIG_SMP
-	/* By default all event channels notify CPU#0. */
-	cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(0));
-#endif
-
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL)
 		panic("Unable to allocate metadata for IRQ%d\n", irq);
@@ -1697,10 +1725,38 @@ static int xen_rebind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int tcpu)
 	return 0;
 }
 
+/*
+ * Find the CPU within @dest mask which has the least number of channels
+ * assigned. This is not precise as the per cpu counts can be modified
+ * concurrently.
+ */
+static unsigned int select_target_cpu(const struct cpumask *dest)
+{
+	unsigned int cpu, best_cpu = UINT_MAX, minch = UINT_MAX;
+
+	for_each_cpu_and(cpu, dest, cpu_online_mask) {
+		unsigned int curch = atomic_read(&channels_on_cpu[cpu]);
+
+		if (curch < minch) {
+			minch = curch;
+			best_cpu = cpu;
+		}
+	}
+
+	/*
+	 * Catch the unlikely case that dest contains no online CPUs. Can't
+	 * recurse.
+	 */
+	if (best_cpu == UINT_MAX)
+		return select_target_cpu(cpu_online_mask);
+
+	return best_cpu;
+}
+
 static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 			    bool force)
 {
-	unsigned tcpu = cpumask_first_and(dest, cpu_online_mask);
+	unsigned int tcpu = select_target_cpu(dest);
 	int ret;
 
 	ret = xen_rebind_evtchn_to_cpu(evtchn_from_irq(data->irq), tcpu);
@@ -1928,8 +1984,12 @@ void xen_irq_resume(void)
 	xen_evtchn_resume();
 
 	/* No IRQ <-> event-channel mappings. */
-	list_for_each_entry(info, &xen_irq_list_head, list)
-		info->evtchn = 0; /* zap event-channel binding */
+	list_for_each_entry(info, &xen_irq_list_head, list) {
+		/* Zap event-channel binding */
+		info->evtchn = 0;
+		/* Adjust accounting */
+		channels_on_cpu_dec(info);
+	}
 
 	clear_evtchn_to_irq_all();
 
