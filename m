Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbgISP2s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 19 Sep 2020 11:28:48 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 1/4] s390/pci: stash version in the zpci_dev
Date: Sat, 19 Sep 2020 11:28:35 -0400
Message-Id: <1600529318-8996-2-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation for passing the info on to vfio-pci devices, stash the
supported PCI version for the target device in the zpci_dev.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci.h | 1 +
 arch/s390/pci/pci_clp.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 99b92c3..882e233 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -179,6 +179,7 @@ struct zpci_dev {
 	atomic64_t mapped_pages;
 	atomic64_t unmapped_pages;
 
+	u8		version;
 	enum pci_bus_speed max_bus_speed;
 
 	struct dentry	*debugfs_dev;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 7e735f4..48bf316 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -102,6 +102,7 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
 	zdev->msi_addr = response->msia;
 	zdev->max_msi = response->noi;
 	zdev->fmb_update = response->mui;
+	zdev->version = response->version;
 
 	switch (response->version) {
 	case 1:
-- 
1.8.3.1
