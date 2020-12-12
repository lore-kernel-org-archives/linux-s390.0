Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:37 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] NTB/msi: Use irq_has_action()
In-Reply-To: <20201210194044.255887860@linutronix.de>
References: <20201210194044.255887860@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791774.3364.1858222479021315707.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d53c576bd3d4787b3d7d0d814b28ae67099d84a1
Gitweb:        https://git.kernel.org/tip/d53c576bd3d4787b3d7d0d814b28ae67099d84a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

NTB/msi: Use irq_has_action()

Use the proper core function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Link: https://lore.kernel.org/r/20201210194044.255887860@linutronix.de

---
 drivers/ntb/msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 0a5e884..3f05cfb 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -282,15 +282,13 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 				  struct ntb_msi_desc *msi_desc)
 {
 	struct msi_desc *entry;
-	struct irq_desc *desc;
 	int ret;
 
 	if (!ntb->msi)
 		return -EINVAL;
 
 	for_each_pci_msi_entry(entry, ntb->pdev) {
-		desc = irq_to_desc(entry->irq);
-		if (desc->action)
+		if (irq_has_action(entry->irq))
 			continue;
 
 		ret = devm_request_threaded_irq(&ntb->dev, entry->irq, handler,
