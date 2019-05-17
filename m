Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 3/4] s390: iommu: Adding get attributes for s390_iommu
Date: Fri, 17 May 2019 18:16:49 +0200
In-Reply-To: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1558109810-18683-4-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

We add the "get attributes" callback to the S390 iommu operations
to retrieve the S390 specific attributes through the call of zPCI
dedicated CLP functions.

The caller can use the following attributes and retrieve:
DOMAIN_ATTR_ZPCI_FN_SIZE: the size of the Z-PCI function attributes
DOMAIN_ATTR_ZPCI_GRP_SIZE: the size of the Z-PCI function group attributes
DOMAIN_ATTR_ZPCI_FN: the Z-PCI function attributes
DOMAIN_ATTR_ZPCI_GRP: the Z-PCI function group attributes

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h      |  4 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 22d4db3..98082f0 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -363,6 +363,82 @@ void zpci_destroy_iommu(struct zpci_dev *zdev)
 	iommu_device_sysfs_remove(&zdev->iommu_dev);
 }
 
+struct zpci_dev *get_zpci(struct s390_domain *s390_domain)
+{
+	struct s390_domain_device *domain_device;
+
+	domain_device = list_first_entry(&s390_domain->devices,
+					 struct s390_domain_device, list);
+	if (!domain_device)
+		return NULL;
+	return domain_device->zdev;
+}
+
+static int s390_domain_get_fn(struct iommu_domain *domain, void *data)
+{
+	struct zpci_dev *zdev;
+	struct clp_req_rsp_query_pci *rrb;
+	int rc;
+
+	zdev = get_zpci(to_s390_domain(domain));
+	if (!zdev)
+		return -ENODEV;
+	rrb = (struct clp_req_rsp_query_pci *)
+	      __get_free_pages(GFP_KERNEL, get_order(CLP_BLK_SIZE));
+	if (!rrb)
+		return -ENOMEM;
+	rc = zdev_query_pci_fn(zdev, rrb);
+
+	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
+		memcpy(data, &rrb->response, sizeof(struct clp_rsp_query_pci));
+	else
+		rc = -EIO;
+	free_pages((unsigned long) rrb, get_order(CLP_BLK_SIZE));
+	return rc;
+}
+
+static int s390_domain_get_grp(struct iommu_domain *domain, void *data)
+{
+	struct zpci_dev *zdev;
+	struct clp_req_rsp_query_pci_grp *rrb;
+	int rc;
+
+	zdev = get_zpci(to_s390_domain(domain));
+	if (!zdev)
+		return -ENODEV;
+	rrb = (struct clp_req_rsp_query_pci_grp *)
+	      __get_free_pages(GFP_KERNEL, get_order(CLP_BLK_SIZE));
+	if (!rrb)
+		return -ENOMEM;
+
+	rc = zdev_query_pci_fngrp(zdev, rrb);
+	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
+		memcpy(data, &rrb->response,
+		       sizeof(struct clp_rsp_query_pci_grp));
+	else
+		rc = -EIO;
+
+	free_pages((unsigned long) rrb, get_order(CLP_BLK_SIZE));
+	return rc;
+}
+
+static int s390_domain_get_attr(struct iommu_domain *domain,
+				enum iommu_attr attr, void *data)
+{
+	switch (attr) {
+	case DOMAIN_ATTR_ZPCI_FN_SIZE:
+		return sizeof(struct clp_rsp_query_pci);
+	case DOMAIN_ATTR_ZPCI_GRP_SIZE:
+		return sizeof(struct clp_rsp_query_pci_grp);
+	case DOMAIN_ATTR_ZPCI_FN:
+		return s390_domain_get_fn(domain, data);
+	case DOMAIN_ATTR_ZPCI_GRP:
+		return s390_domain_get_grp(domain, data);
+	default:
+		return -ENODEV;
+	}
+}
+
 static const struct iommu_ops s390_iommu_ops = {
 	.capable = s390_iommu_capable,
 	.domain_alloc = s390_domain_alloc,
@@ -376,6 +452,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.remove_device = s390_iommu_remove_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.domain_get_attr = s390_domain_get_attr,
 };
 
 static int __init s390_iommu_init(void)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ffbbc7e..ebdcac4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -125,6 +125,10 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_ZPCI_FN_SIZE,
+	DOMAIN_ATTR_ZPCI_GRP_SIZE,
+	DOMAIN_ATTR_ZPCI_FN,
+	DOMAIN_ATTR_ZPCI_GRP,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4
