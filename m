Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:41 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] genirq: Move irq_set_lockdep_class() to core
In-Reply-To: <20201210194042.860029489@linutronix.de>
References: <20201210194042.860029489@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792160.3364.6971604740060856051.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a07d244f00de679c66643e89eba6e1baa62d3517
Gitweb:        https://git.kernel.org/tip/a07d244f00de679c66643e89eba6e1baa62d3517
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:02 +01:00

genirq: Move irq_set_lockdep_class() to core

irq_set_lockdep_class() is used from modules and requires irq_to_desc() to
be exported. Move it into the core code which lifts another requirement for
the export.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194042.860029489@linutronix.de

---
 include/linux/irqdesc.h | 10 ++++------
 kernel/irq/irqdesc.c    | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 308d7db..4a1d016 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -240,16 +240,14 @@ static inline bool irq_is_percpu_devid(unsigned int irq)
 	return irq_check_status_bit(irq, IRQ_PER_CPU_DEVID);
 }
 
+void __irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
+			     struct lock_class_key *request_class);
 static inline void
 irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 		      struct lock_class_key *request_class)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc) {
-		lockdep_set_class(&desc->lock, lock_class);
-		lockdep_set_class(&desc->request_mutex, request_class);
-	}
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		__irq_set_lockdep_class(irq, lock_class, request_class);
 }
 
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index e810eb9..f309869 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -968,3 +968,17 @@ unsigned int kstat_irqs_usr(unsigned int irq)
 	rcu_read_unlock();
 	return sum;
 }
+
+#ifdef CONFIG_LOCKDEP
+void __irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
+			     struct lock_class_key *request_class)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (desc) {
+		lockdep_set_class(&desc->lock, lock_class);
+		lockdep_set_class(&desc->request_mutex, request_class);
+	}
+}
+EXPORT_SYMBOL_GPL(irq_set_lockdep_class);
+#endif
