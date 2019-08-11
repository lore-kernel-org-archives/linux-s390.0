Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45433 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfHKPIc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 11 Aug 2019 11:08:32 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH 1/7] PCI: Add define for the number of standard PCI BARs
Date: Sun, 11 Aug 2019 18:07:56 +0300
Message-Id: <20190811150802.2418-2-efremov@linux.com>
In-Reply-To: <20190811150802.2418-1-efremov@linux.com>
References: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Code that iterates over all standard PCI BARs typically uses
PCI_STD_RESOURCE_END. However, it requires the "unusual" loop condition
"i <= PCI_STD_RESOURCE_END" rather than something more standard like
"i < PCI_STD_NUM_BARS".

This patch adds the definition PCI_STD_NUM_BARS which is equivalent to
"PCI_STD_RESOURCE_END + 1" and updates loop conditions to use it.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/quirks.c          | 2 +-
 include/linux/pci.h           | 2 +-
 include/uapi/linux/pci_regs.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 208aacf39329..02bdf3a0231e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -475,7 +475,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
 {
 	int i;
 
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct resource *r = &dev->resource[i];
 
 		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..7b9590d5dc2d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -76,7 +76,7 @@ enum pci_mmap_state {
 enum {
 	/* #0-5: standard PCI resources */
 	PCI_STD_RESOURCES,
-	PCI_STD_RESOURCE_END = 5,
+	PCI_STD_RESOURCE_END = PCI_STD_RESOURCES + PCI_STD_NUM_BARS - 1,
 
 	/* #6: expansion ROM resource */
 	PCI_ROM_RESOURCE,
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..68b571d491eb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -34,6 +34,7 @@
  * of which the first 64 bytes are standardized as follows:
  */
 #define PCI_STD_HEADER_SIZEOF	64
+#define PCI_STD_NUM_BARS	6	/* Number of standard BARs */
 #define PCI_VENDOR_ID		0x00	/* 16 bits */
 #define PCI_DEVICE_ID		0x02	/* 16 bits */
 #define PCI_COMMAND		0x04	/* 16 bits */
-- 
2.21.0
