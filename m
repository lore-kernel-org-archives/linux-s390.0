Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfHKPIk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 11 Aug 2019 11:08:40 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH 2/7] s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
Date: Sun, 11 Aug 2019 18:07:57 +0300
Message-Id: <20190811150802.2418-3-efremov@linux.com>
In-Reply-To: <20190811150802.2418-1-efremov@linux.com>
References: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

This patch replaces local define PCI_BAR_COUNT with global
PCI_STD_NUM_BARS.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/s390/include/asm/pci.h     |  5 +----
 arch/s390/include/asm/pci_clp.h |  6 +++---
 arch/s390/pci/pci.c             | 16 ++++++++--------
 arch/s390/pci/pci_clp.c         |  6 +++---
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index a2399eff84ca..3a06c264ea53 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -2,9 +2,6 @@
 #ifndef __ASM_S390_PCI_H
 #define __ASM_S390_PCI_H
 
-/* must be set before including pci_clp.h */
-#define PCI_BAR_COUNT	6
-
 #include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/iommu.h>
@@ -138,7 +135,7 @@ struct zpci_dev {
 
 	char res_name[16];
 	bool mio_capable;
-	struct zpci_bar_struct bars[PCI_BAR_COUNT];
+	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
 
 	u64		start_dma;	/* Start of available DMA addresses */
 	u64		end_dma;	/* End of available DMA addresses */
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index 50359172cc48..bd2cb4ea7d93 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -77,7 +77,7 @@ struct mio_info {
 	struct {
 		u64 wb;
 		u64 wt;
-	} addr[PCI_BAR_COUNT];
+	} addr[PCI_STD_NUM_BARS];
 	u32 reserved[6];
 } __packed;
 
@@ -98,9 +98,9 @@ struct clp_rsp_query_pci {
 	u16 util_str_avail	:  1;	/* utility string available? */
 	u16 pfgid		:  8;	/* pci function group id */
 	u32 fid;			/* pci function id */
-	u8 bar_size[PCI_BAR_COUNT];
+	u8 bar_size[PCI_STD_NUM_BARS];
 	u16 pchid;
-	__le32 bar[PCI_BAR_COUNT];
+	__le32 bar[PCI_STD_NUM_BARS];
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
 	u32			: 16;
 	u8 fmb_len;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b0e3b9a0e488..c57ccac25c02 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -43,7 +43,7 @@ static DECLARE_BITMAP(zpci_domain, ZPCI_NR_DEVICES);
 static DEFINE_SPINLOCK(zpci_domain_lock);
 
 #define ZPCI_IOMAP_ENTRIES						\
-	min(((unsigned long) ZPCI_NR_DEVICES * PCI_BAR_COUNT / 2),	\
+	min(((unsigned long) ZPCI_NR_DEVICES * PCI_STD_NUM_BARS / 2),	\
 	    ZPCI_IOMAP_MAX_ENTRIES)
 
 static DEFINE_SPINLOCK(zpci_iomap_lock);
@@ -294,7 +294,7 @@ static void __iomem *pci_iomap_range_mio(struct pci_dev *pdev, int bar,
 void __iomem *pci_iomap_range(struct pci_dev *pdev, int bar,
 			      unsigned long offset, unsigned long max)
 {
-	if (!pci_resource_len(pdev, bar) || bar >= PCI_BAR_COUNT)
+	if (!pci_resource_len(pdev, bar) || bar >= PCI_STD_NUM_BARS)
 		return NULL;
 
 	if (static_branch_likely(&have_mio))
@@ -324,7 +324,7 @@ static void __iomem *pci_iomap_wc_range_mio(struct pci_dev *pdev, int bar,
 void __iomem *pci_iomap_wc_range(struct pci_dev *pdev, int bar,
 				 unsigned long offset, unsigned long max)
 {
-	if (!pci_resource_len(pdev, bar) || bar >= PCI_BAR_COUNT)
+	if (!pci_resource_len(pdev, bar) || bar >= PCI_STD_NUM_BARS)
 		return NULL;
 
 	if (static_branch_likely(&have_mio))
@@ -416,7 +416,7 @@ static void zpci_map_resources(struct pci_dev *pdev)
 	resource_size_t len;
 	int i;
 
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		len = pci_resource_len(pdev, i);
 		if (!len)
 			continue;
@@ -451,7 +451,7 @@ static void zpci_unmap_resources(struct pci_dev *pdev)
 	if (zpci_use_mio(zdev))
 		return;
 
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		len = pci_resource_len(pdev, i);
 		if (!len)
 			continue;
@@ -514,7 +514,7 @@ static int zpci_setup_bus_resources(struct zpci_dev *zdev,
 	snprintf(zdev->res_name, sizeof(zdev->res_name),
 		 "PCI Bus %04x:%02x", zdev->domain, ZPCI_BUS_NR);
 
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (!zdev->bars[i].size)
 			continue;
 		entry = zpci_alloc_iomap(zdev);
@@ -551,7 +551,7 @@ static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
 {
 	int i;
 
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (!zdev->bars[i].size || !zdev->bars[i].res)
 			continue;
 
@@ -573,7 +573,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 	pdev->dev.dma_ops = &s390_pci_dma_ops;
 	zpci_map_resources(pdev);
 
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		res = &pdev->resource[i];
 		if (res->parent || !res->flags)
 			continue;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 9bdff4defef1..8b729b5f2972 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -145,7 +145,7 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 {
 	int i;
 
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		zdev->bars[i].val = le32_to_cpu(response->bar[i]);
 		zdev->bars[i].size = response->bar_size[i];
 	}
@@ -164,8 +164,8 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 		       sizeof(zdev->util_str));
 	}
 	zdev->mio_capable = response->mio_addr_avail;
-	for (i = 0; i < PCI_BAR_COUNT; i++) {
-		if (!(response->mio.valid & (1 << (PCI_BAR_COUNT - i - 1))))
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (!(response->mio.valid & (1 << (PCI_STD_NUM_BARS - i - 1))))
 			continue;
 
 		zdev->bars[i].mio_wb = (void __iomem *) response->mio.addr[i].wb;
-- 
2.21.0
