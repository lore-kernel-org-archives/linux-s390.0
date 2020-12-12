Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:35 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] xen/events: Only force affinity mask for percpu interrupts
In-Reply-To: <20201210194045.250321315@linutronix.de>
References: <20201210194045.250321315@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791504.3364.5223639342920487711.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f61b8351facda691f1564097074976b30e987a81
Gitweb:        https://git.kernel.org/tip/f61b8351facda691f1564097074976b30e987a81
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

xen/events: Only force affinity mask for percpu interrupts

All event channel setups bind the interrupt on CPU0 or the target CPU for
percpu interrupts and overwrite the affinity mask with the corresponding
cpumask. That does not make sense.

The XEN implementation of irqchip::irq_set_affinity() already picks a
single target CPU out of the affinity mask and the actual target is stored
in the effective CPU mask, so destroying the user chosen affinity mask
which might contain more than one CPU is wrong.

Change the implementation so that the channel is bound to CPU0 at the XEN
level and leave the affinity mask alone. At startup of the interrupt
affinity will be assigned out of the affinity mask and the XEN binding will
be updated. Only keep the enforcement for real percpu interrupts.

On resume the overwrite is not required either because info->cpu and the
affinity mask are still the same as at the time of suspend. Same for
rebind_evtchn_irq().

This also prepares for proper interrupt spreading.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20201210194045.250321315@linutronix.de

---
 drivers/xen/events/events_base.c | 48 +++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index eaba42a..679b2cb 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -433,15 +433,20 @@ static bool pirq_needs_eoi_flag(unsigned irq)
 	return info->u.pirq.flags & PIRQ_NEEDS_EOI;
 }
 
-static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu)
+static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
+			       bool force_affinity)
 {
 	int irq = get_evtchn_to_irq(evtchn);
 	struct irq_info *info = info_for_irq(irq);
 
 	BUG_ON(irq == -1);
-#ifdef CONFIG_SMP
-	cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
-#endif
+
+	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
+		cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
+		cpumask_copy(irq_get_effective_affinity_mask(irq),
+			     cpumask_of(cpu));
+	}
+
 	xen_evtchn_port_bind_to_cpu(evtchn, cpu, info->cpu);
 
 	info->cpu = cpu;
@@ -788,7 +793,7 @@ static unsigned int __startup_pirq(unsigned int irq)
 		goto err;
 
 	info->evtchn = evtchn;
-	bind_evtchn_to_cpu(evtchn, 0);
+	bind_evtchn_to_cpu(evtchn, 0, false);
 
 	rc = xen_evtchn_port_setup(evtchn);
 	if (rc)
@@ -1107,8 +1112,14 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip)
 			irq = ret;
 			goto out;
 		}
-		/* New interdomain events are bound to VCPU 0. */
-		bind_evtchn_to_cpu(evtchn, 0);
+		/*
+		 * New interdomain events are initially bound to vCPU0 This
+		 * is required to setup the event channel in the first
+		 * place and also important for UP guests because the
+		 * affinity setting is not invoked on them so nothing would
+		 * bind the channel.
+		 */
+		bind_evtchn_to_cpu(evtchn, 0, false);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
@@ -1156,7 +1167,11 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 			irq = ret;
 			goto out;
 		}
-		bind_evtchn_to_cpu(evtchn, cpu);
+		/*
+		 * Force the affinity mask to the target CPU so proc shows
+		 * the correct target.
+		 */
+		bind_evtchn_to_cpu(evtchn, cpu, true);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_IPI);
@@ -1269,7 +1284,11 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 			goto out;
 		}
 
-		bind_evtchn_to_cpu(evtchn, cpu);
+		/*
+		 * Force the affinity mask for percpu interrupts so proc
+		 * shows the correct target.
+		 */
+		bind_evtchn_to_cpu(evtchn, cpu, percpu);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_VIRQ);
@@ -1634,8 +1653,7 @@ void rebind_evtchn_irq(evtchn_port_t evtchn, int irq)
 
 	mutex_unlock(&irq_mapping_update_lock);
 
-        bind_evtchn_to_cpu(evtchn, info->cpu);
-	irq_set_affinity(irq, cpumask_of(info->cpu));
+	bind_evtchn_to_cpu(evtchn, info->cpu, false);
 
 	/* Unmask the event channel. */
 	enable_irq(irq);
@@ -1669,7 +1687,7 @@ static int xen_rebind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int tcpu)
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
 	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
-		bind_evtchn_to_cpu(evtchn, tcpu);
+		bind_evtchn_to_cpu(evtchn, tcpu, false);
 
 	if (!masked)
 		unmask_evtchn(evtchn);
@@ -1798,7 +1816,8 @@ static void restore_cpu_virqs(unsigned int cpu)
 
 		/* Record the new mapping. */
 		(void)xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
-		bind_evtchn_to_cpu(evtchn, cpu);
+		/* The affinity mask is still valid */
+		bind_evtchn_to_cpu(evtchn, cpu, false);
 	}
 }
 
@@ -1823,7 +1842,8 @@ static void restore_cpu_ipis(unsigned int cpu)
 
 		/* Record the new mapping. */
 		(void)xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
-		bind_evtchn_to_cpu(evtchn, cpu);
+		/* The affinity mask is still valid */
+		bind_evtchn_to_cpu(evtchn, cpu, false);
 	}
 }
 
