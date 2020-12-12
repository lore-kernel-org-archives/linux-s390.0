Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:40 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] parisc/irq: Simplify irq count output for /proc/interrupts
In-Reply-To: <20201210194043.172893840@linutronix.de>
References: <20201210194043.172893840@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792076.3364.15318766316290964513.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-parisc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     89c1ca3058ced5cc8176de7b668b9d0ff08f8f4b
Gitweb:        https://git.kernel.org/tip/89c1ca3058ced5cc8176de7b668b9d0ff08f8f4b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

parisc/irq: Simplify irq count output for /proc/interrupts

The SMP variant works perfectly fine on UP as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-parisc@vger.kernel.org
Link: https://lore.kernel.org/r/20201210194043.172893840@linutronix.de

---
 arch/parisc/kernel/irq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index e76c866..15c6207 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -216,12 +216,9 @@ int show_interrupts(struct seq_file *p, void *v)
 		if (!action)
 			goto skip;
 		seq_printf(p, "%3d: ", i);
-#ifdef CONFIG_SMP
+
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-#else
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#endif
 
 		seq_printf(p, " %14s", irq_desc_get_chip(desc)->name);
 #ifndef PARISC_IRQ_CR16_COUNTS
