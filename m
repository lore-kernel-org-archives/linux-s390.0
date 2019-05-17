Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 1/4] s390: pci: Exporting access to CLP PCI function and PCI group
Date: Fri, 17 May 2019 18:16:47 +0200
In-Reply-To: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1558109810-18683-2-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

For the generic implementation of VFIO PCI we need to retrieve
the hardware configuration for the PCI functions and the
PCI function groups.

We modify the internal function using CLP Query PCI function and
CLP query PCI function group so that they can be called from
outside the S390 architecture PCI code and prefix the two
functions with "zdev" to make clear that they can be called
knowing only the associated zdevice.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  3 ++
 arch/s390/pci/pci_clp.c     | 70 +++++++++++++++++++++++----------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 305befd..e66b246 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -261,4 +261,7 @@ cpumask_of_pcibus(const struct pci_bus *bus)
 
 #endif /* CONFIG_NUMA */
 
+int zdev_query_pci_fngrp(struct zpci_dev *zdev,
+			 struct clp_req_rsp_query_pci_grp *rrb);
+int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb);
 #endif
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 3a36b07..c57f675 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -113,31 +113,16 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
 	}
 }
 
-static int clp_query_pci_fngrp(struct zpci_dev *zdev, u8 pfgid)
+int zdev_query_pci_fngrp(struct zpci_dev *zdev,
+			 struct clp_req_rsp_query_pci_grp *rrb)
 {
-	struct clp_req_rsp_query_pci_grp *rrb;
-	int rc;
-
-	rrb = clp_alloc_block(GFP_KERNEL);
-	if (!rrb)
-		return -ENOMEM;
-
 	memset(rrb, 0, sizeof(*rrb));
 	rrb->request.hdr.len = sizeof(rrb->request);
 	rrb->request.hdr.cmd = CLP_QUERY_PCI_FNGRP;
 	rrb->response.hdr.len = sizeof(rrb->response);
-	rrb->request.pfgid = pfgid;
+	rrb->request.pfgid = zdev->pfgid;
 
-	rc = clp_req(rrb, CLP_LPS_PCI);
-	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
-		clp_store_query_pci_fngrp(zdev, &rrb->response);
-	else {
-		zpci_err("Q PCI FGRP:\n");
-		zpci_err_clp(rrb->response.hdr.rsp, rc);
-		rc = -EIO;
-	}
-	clp_free_block(rrb);
-	return rc;
+	return clp_req(rrb, CLP_LPS_PCI);
 }
 
 static int clp_store_query_pci_fn(struct zpci_dev *zdev,
@@ -174,32 +159,49 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	return 0;
 }
 
-static int clp_query_pci_fn(struct zpci_dev *zdev, u32 fh)
+int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb)
+{
+
+	memset(rrb, 0, sizeof(*rrb));
+	rrb->request.hdr.len = sizeof(rrb->request);
+	rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
+	rrb->response.hdr.len = sizeof(rrb->response);
+	rrb->request.fh = zdev->fh;
+
+	return clp_req(rrb, CLP_LPS_PCI);
+}
+
+static int clp_query_pci(struct zpci_dev *zdev)
 {
 	struct clp_req_rsp_query_pci *rrb;
+	struct clp_req_rsp_query_pci_grp *grrb;
 	int rc;
 
 	rrb = clp_alloc_block(GFP_KERNEL);
 	if (!rrb)
 		return -ENOMEM;
 
-	memset(rrb, 0, sizeof(*rrb));
-	rrb->request.hdr.len = sizeof(rrb->request);
-	rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
-	rrb->response.hdr.len = sizeof(rrb->response);
-	rrb->request.fh = fh;
-
-	rc = clp_req(rrb, CLP_LPS_PCI);
-	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK) {
-		rc = clp_store_query_pci_fn(zdev, &rrb->response);
-		if (rc)
-			goto out;
-		rc = clp_query_pci_fngrp(zdev, rrb->response.pfgid);
-	} else {
+	rc = zdev_query_pci_fn(zdev, rrb);
+	if (rc || rrb->response.hdr.rsp != CLP_RC_OK) {
 		zpci_err("Q PCI FN:\n");
 		zpci_err_clp(rrb->response.hdr.rsp, rc);
 		rc = -EIO;
+		goto out;
 	}
+	rc = clp_store_query_pci_fn(zdev, &rrb->response);
+	if (rc)
+		goto out;
+
+	grrb = (struct clp_req_rsp_query_pci_grp *)rrb;
+	rc = zdev_query_pci_fngrp(zdev, grrb);
+	if (rc || grrb->response.hdr.rsp != CLP_RC_OK) {
+		zpci_err("Q PCI FGRP:\n");
+		zpci_err_clp(grrb->response.hdr.rsp, rc);
+		rc = -EIO;
+		goto out;
+	}
+	clp_store_query_pci_fngrp(zdev, &grrb->response);
+
 out:
 	clp_free_block(rrb);
 	return rc;
@@ -219,7 +221,7 @@ int clp_add_pci_device(u32 fid, u32 fh, int configured)
 	zdev->fid = fid;
 
 	/* Query function properties and update zdev */
-	rc = clp_query_pci_fn(zdev, fh);
+	rc = clp_query_pci(zdev);
 	if (rc)
 		goto error;
 
-- 
2.7.4
