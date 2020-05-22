Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbgEVSjw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 May 2020 14:39:52 -0400
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
Date: Fri, 22 May 2020 20:39:22 +0200
Message-Id: <20200522183922.5253-1-ptesarik@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>

After disabling a function, the original handle is logged instead of
the disabled handle.

Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/s390/pci/pci_clp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index ea794ae755ae..179bcecefdee 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
 
 int clp_disable_fh(struct zpci_dev *zdev)
 {
-	u32 fh = zdev->fh;
 	int rc;
 
 	if (!zdev_enabled(zdev))
 		return 0;
 
 	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
-	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
+	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
 	return rc;
 }
 
-- 
2.26.1
