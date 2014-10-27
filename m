Return-Path: <linux-pci-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()
Date: Mon, 27 Oct 2014 10:44:38 +0800
Message-ID: <1414377878-23497-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now only s390/MSI use default_msi_mask_irq() and
default_msix_mask_irq(), replace them with the common
msi mask irq functions __msi_mask_irq() and __msix_mask_irq().
Remove default_msi_mask_irq() and default_msix_mask_irq().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: linux-s390@vger.kernel.org
---
 arch/s390/pci/pci.c |    4 ++--
 include/linux/msi.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2fa7b14..552b990 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -448,9 +448,9 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	/* Release MSI interrupts */
 	list_for_each_entry(msi, &pdev->msi_list, list) {
 		if (msi->msi_attrib.is_msix)
-			default_msix_mask_irq(msi, 1);
+			__msix_mask_irq(msi, 1);
 		else
-			default_msi_mask_irq(msi, 1, 1);
+			__msi_mask_irq(msi, 1, 1);
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f6630a5..efad127 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -64,8 +64,6 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
-#define default_msi_mask_irq  __msi_mask_irq
-#define default_msix_mask_irq  __msix_mask_irq
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.1
