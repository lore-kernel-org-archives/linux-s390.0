Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51984 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFQBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Aug 2019 12:01:50 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] s390/pci: PCI_IOV_RESOURCES loop refactoring in zpci_map_resources
Date: Tue,  6 Aug 2019 19:01:37 +0300
Message-Id: <20190806160137.29275-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This patch alters the for loop iteration scheme in zpci_map_resources
to make it more usual. Thus, the patch generalizes the style for
PCI_IOV_RESOURCES iteration and improves readability.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/s390/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b0e3b9a0e488..c7fea9bea8cb 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -431,13 +431,13 @@ static void zpci_map_resources(struct pci_dev *pdev)
 	}
 
 #ifdef CONFIG_PCI_IOV
-	i = PCI_IOV_RESOURCES;
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		int bar = i + PCI_IOV_RESOURCES;
 
-	for (; i < PCI_SRIOV_NUM_BARS + PCI_IOV_RESOURCES; i++) {
-		len = pci_resource_len(pdev, i);
+		len = pci_resource_len(pdev, bar);
 		if (!len)
 			continue;
-		pdev->resource[i].parent = &iov_res;
+		pdev->resource[bar].parent = &iov_res;
 	}
 #endif
 }
-- 
2.21.0
