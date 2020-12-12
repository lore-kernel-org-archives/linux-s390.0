Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:39 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] s390/irq: Use irq_desc_kstat_cpu() in show_msi_interrupt()
In-Reply-To: <20201210194043.769108348@linutronix.de>
References: <20201210194043.769108348@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791905.3364.9957041212616902271.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7a0a6b22431b36549151df8f30cec4f667a018fc
Gitweb:        https://git.kernel.org/tip/7a0a6b22431b36549151df8f30cec4f667a018fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

s390/irq: Use irq_desc_kstat_cpu() in show_msi_interrupt()

The irq descriptor is already there, no need to look it up again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20201210194043.769108348@linutronix.de

---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 3514420..d9cd898 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -124,7 +124,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	seq_printf(p, "%3d: ", irq);
 	for_each_online_cpu(cpu)
-		seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
+		seq_printf(p, "%10u ", irq_desc_kstat_irq(desc, cpu));
 
 	if (desc->irq_data.chip)
 		seq_printf(p, " %8s", desc->irq_data.chip->name);
