Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:41 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide irq_get_effective_affinity()
In-Reply-To: <20201210194042.967177918@linutronix.de>
References: <20201210194042.967177918@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792133.3364.14572344639030307980.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     276b1e6e6fecc2f138c72519705dabc8bd01ffa9
Gitweb:        https://git.kernel.org/tip/276b1e6e6fecc2f138c72519705dabc8bd01ffa9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:02 +01:00

genirq: Provide irq_get_effective_affinity()

Provide an accessor to the effective interrupt affinity mask. Going to be
used to replace open coded fiddling with the irq descriptor.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194042.967177918@linutronix.de

---
 include/linux/irq.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 79ce314..2385b81 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -907,6 +907,13 @@ struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
 }
 #endif
 
+static inline struct cpumask *irq_get_effective_affinity_mask(unsigned int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	return d ? irq_data_get_effective_affinity_mask(d) : NULL;
+}
+
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
