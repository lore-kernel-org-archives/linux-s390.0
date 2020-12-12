Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:41 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] genirq: Annotate irq stats data races
In-Reply-To: <20201210194043.067097663@linutronix.de>
References: <20201210194043.067097663@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792105.3364.9820233761878732243.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fb4f676fc901cb547226efb3e69ffeaeefa124be
Gitweb:        https://git.kernel.org/tip/fb4f676fc901cb547226efb3e69ffeaeefa124be
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

genirq: Annotate irq stats data races

Both the per cpu stats and the accumulated count are accessed lockless and
can be concurrently modified. That's intentional and the stats are a rough
estimate anyway. Annotate them with data_race().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194043.067097663@linutronix.de

---
 kernel/irq/irqdesc.c | 4 ++--
 kernel/irq/proc.c    | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f309869..d28f69e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -943,10 +943,10 @@ unsigned int kstat_irqs(unsigned int irq)
 	if (!irq_settings_is_per_cpu_devid(desc) &&
 	    !irq_settings_is_per_cpu(desc) &&
 	    !irq_is_nmi(desc))
-	    return desc->tot_count;
+		return data_race(desc->tot_count);
 
 	for_each_possible_cpu(cpu)
-		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
+		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
 	return sum;
 }
 
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 72513ed..9813878 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -488,9 +488,10 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs)
+	if (desc->kstat_irqs) {
 		for_each_online_cpu(j)
-			any_count |= *per_cpu_ptr(desc->kstat_irqs, j);
+			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
+	}
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
 		goto outsparse;
