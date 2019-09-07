Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4170 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392970AbfIGAOH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Sep 2019 20:14:07 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v4 2/4] s390: pci: Define the maxstbl CLP response entry
Date: Fri,  6 Sep 2019 20:13:49 -0400
Message-Id: <1567815231-17940-3-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: sebott@linux.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, robin.murphy@arm.com, gor@linux.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com

From: Pierre Morel <pmorel@linux.ibm.com>

This entry is already defined in QEMU but not in Linux.
We need this to export this entry to QEMU through a VFIO
device region.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/pci_clp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index 5035917..03fc2f0 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -132,7 +132,7 @@ struct clp_rsp_query_pci_grp {
 	u8			:  6;
 	u8 frame		:  1;
 	u8 refresh		:  1;	/* TLB refresh mode */
-	u16 reserved2;
+	u16 maxstbl;
 	u16 mui;
 	u16			: 16;
 	u16 maxfaal;
-- 
1.8.3.1
