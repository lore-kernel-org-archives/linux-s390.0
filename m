Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729155AbgAaPCS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:02:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VExagd021213
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xv7deqsc3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:16 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:14 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 02/12] s390: PCI: fix IOMMU region init
Date: Fri, 31 Jan 2020 16:01:57 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-3-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Matthew Rosato <mjrosato@linux.ibm.com>

The fix in dbe9cf606c shrinks the IOMMU memory region to a size
that seems reasonable on the surface, however is actually too
small as it is based against a 0-mapped address space.  This
causes breakage with small guests as they can overrun the IOMMU window.

Let's go back to the prior method of initializing iommu for now.

Fixes: dbe9cf606c ("s390x/pci: Set the iommu region size mpcifc request")
Cc: qemu-stable@nongnu.org
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Tested-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Reported-by: Stefan Zimmerman <stzi@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-Id: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 963a41c7f532..2d2f4a7c419c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -695,10 +695,15 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
 
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
 {
+    /*
+     * The iommu region is initialized against a 0-mapped address space,
+     * so the smallest IOMMU region we can define runs from 0 to the end
+     * of the PCI address space.
+     */
     char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
     memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
-                             name, iommu->pal - iommu->pba + 1);
+                             name, iommu->pal + 1);
     iommu->enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
     g_free(name);
-- 
2.21.0
