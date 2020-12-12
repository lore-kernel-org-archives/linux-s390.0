Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:42 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] genirq: Move irq_has_action() into core code
In-Reply-To: <20201210194042.548936472@linutronix.de>
References: <20201210194042.548936472@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792214.3364.6390594905664664886.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     db123744af5d237048f23ede05cc7ef0dc48db01
Gitweb:        https://git.kernel.org/tip/db123744af5d237048f23ede05cc7ef0dc48db01
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:02 +01:00

genirq: Move irq_has_action() into core code

This function uses irq_to_desc() and is going to be used by modules to
replace the open coded irq_to_desc() (ab)usage. The final goal is to remove
the export of irq_to_desc() so driver cannot fiddle with it anymore.

Move it into the core code and fixup the usage sites to include the proper
header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194042.548936472@linutronix.de

---
 arch/alpha/kernel/sys_jensen.c |  2 +-
 arch/x86/kernel/topology.c     |  1 +
 include/linux/interrupt.h      |  1 +
 include/linux/irqdesc.h        |  7 +------
 kernel/irq/manage.c            | 17 +++++++++++++++++
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
index 0a2ab6c..e5d870f 100644
--- a/arch/alpha/kernel/sys_jensen.c
+++ b/arch/alpha/kernel/sys_jensen.c
@@ -7,7 +7,7 @@
  *
  * Code supporting the Jensen.
  */
-
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/mm.h>
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 0a2ec80..f5477ea 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -25,6 +25,7 @@
  *
  * Send feedback to <colpatch@us.ibm.com>
  */
+#include <linux/interrupt.h>
 #include <linux/nodemask.h>
 #include <linux/export.h>
 #include <linux/mmzone.h>
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee8299e..e7c9726 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -232,6 +232,7 @@ extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
 # define local_irq_enable_in_hardirq()	local_irq_enable()
 #endif
 
+bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
 extern void disable_irq(unsigned int irq);
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 5745491..385a4fa 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -179,12 +179,7 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 /* Test to see if a driver has successfully requested an irq */
 static inline int irq_desc_has_action(struct irq_desc *desc)
 {
-	return desc->action != NULL;
-}
-
-static inline int irq_has_action(unsigned int irq)
-{
-	return irq_desc_has_action(irq_to_desc(irq));
+	return desc && desc->action != NULL;
 }
 
 /**
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e04..1767515 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2752,3 +2752,20 @@ out_unlock:
 	return err;
 }
 EXPORT_SYMBOL_GPL(irq_set_irqchip_state);
+
+/**
+ * irq_has_action - Check whether an interrupt is requested
+ * @irq:	The linux irq number
+ *
+ * Returns: A snapshot of the current state
+ */
+bool irq_has_action(unsigned int irq)
+{
+	bool res;
+
+	rcu_read_lock();
+	res = irq_desc_has_action(irq_to_desc(irq));
+	rcu_read_unlock();
+	return res;
+}
+EXPORT_SYMBOL_GPL(irq_has_action);
