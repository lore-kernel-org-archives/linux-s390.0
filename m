Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 3/4] s390/pci: Get hardware-reported max store block length
Date: Tue, 19 Jan 2021 15:02:29 -0500
Message-Id: <1611086550-32765-4-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

We'll need to know this information for vfio passthrough.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/pci.h     | 1 +
 arch/s390/include/asm/pci_clp.h | 3 ++-
 arch/s390/pci/pci_clp.c         | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index f16ffba..04f1f48 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -181,6 +181,7 @@ struct zpci_dev {
 	atomic64_t mapped_pages;
 	atomic64_t unmapped_pages;
 
+	u16		maxstbl;
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
 
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index 9fb7cbf..ddd1604 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -155,7 +155,8 @@ struct clp_rsp_query_pci_grp {
 	u8			:  1;
 	u8 frame		:  1;
 	u8 refresh		:  1;	/* TLB refresh mode */
-	u16 reserved2;
+	u16			:  3;
+	u16 maxstbl		: 13;
 	u16 mui;
 	u16			: 16;
 	u16 maxfaal;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 630f8fc..99b64fe 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -104,6 +104,7 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
 	zdev->fmb_update = response->mui;
 	zdev->version = response->version;
 	zdev->relaxed_align = response->relaxed_align;
+	zdev->maxstbl = response->maxstbl;
 
 	switch (response->version) {
 	case 1:
-- 
1.8.3.1
