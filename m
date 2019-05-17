Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement VFIO_IOMMU_INFO_CAPABILITIES
Date: Fri, 17 May 2019 18:16:50 +0200
In-Reply-To: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

We implement the capability interface for VFIO_IOMMU_GET_INFO.

When calling the ioctl, the user must specify
VFIO_IOMMU_INFO_CAPABILITIES to retrieve the capabilities and
must check in the answer if capabilities are supported.

The iommu get_attr callback will be used to retrieve the specific
attributes and fill the capabilities.

Currently two Z-PCI specific capabilities will be queried and
filled by the underlying Z specific s390_iommu:
VFIO_IOMMU_INFO_CAP_QFN for the PCI query function attributes
and
VFIO_IOMMU_INFO_CAP_QGRP for the PCI query function group.

Other architectures may add new capabilities in the same way
after enhancing the architecture specific IOMMU driver.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_type1.c | 122 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d0f731c..9435647 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1658,6 +1658,97 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int vfio_iommu_type1_zpci_fn(struct iommu_domain *domain,
+				    struct vfio_info_cap *caps, size_t size)
+{
+	struct vfio_iommu_type1_info_pcifn *info_fn;
+	int ret;
+
+	info_fn = kzalloc(size, GFP_KERNEL);
+	if (!info_fn)
+		return -ENOMEM;
+
+	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_ZPCI_FN,
+				    &info_fn->response);
+	if (ret < 0)
+		goto free_fn;
+
+	info_fn->header.id = VFIO_IOMMU_INFO_CAP_QFN;
+	ret = vfio_info_add_capability(caps, &info_fn->header, size);
+
+free_fn:
+	kfree(info_fn);
+	return ret;
+}
+
+static int vfio_iommu_type1_zpci_grp(struct iommu_domain *domain,
+				     struct vfio_info_cap *caps,
+				     size_t grp_size)
+{
+	struct vfio_iommu_type1_info_pcifg *info_grp;
+	int ret;
+
+	info_grp = kzalloc(grp_size, GFP_KERNEL);
+	if (!info_grp)
+		return -ENOMEM;
+
+	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_ZPCI_GRP,
+				    (void *) &info_grp->response);
+	if (ret < 0)
+		goto free_grp;
+	info_grp->header.id = VFIO_IOMMU_INFO_CAP_QGRP;
+	ret = vfio_info_add_capability(caps, &info_grp->header, grp_size);
+
+free_grp:
+	kfree(info_grp);
+	return ret;
+}
+
+int vfio_iommu_type1_caps(struct vfio_iommu *iommu, struct vfio_info_cap *caps,
+			  size_t size)
+{
+	struct vfio_domain *d;
+	unsigned long total_size, fn_size, grp_size;
+	int ret;
+
+	d = list_first_entry(&iommu->domain_list, struct vfio_domain, next);
+	if (!d)
+		return -ENODEV;
+
+	/* First compute the size the user must provide */
+	total_size = 0;
+	fn_size = iommu_domain_get_attr(d->domain,
+					DOMAIN_ATTR_ZPCI_FN_SIZE, NULL);
+	if (fn_size > 0) {
+		fn_size +=  sizeof(struct vfio_info_cap_header);
+		total_size += fn_size;
+	}
+
+	grp_size = iommu_domain_get_attr(d->domain,
+					 DOMAIN_ATTR_ZPCI_GRP_SIZE, NULL);
+	if (grp_size > 0) {
+		grp_size +=  sizeof(struct vfio_info_cap_header);
+		total_size += grp_size;
+	}
+
+	if (total_size > size) {
+		/* Tell caller to call us with a greater buffer */
+		caps->size = total_size;
+		return 0;
+	}
+
+	if (fn_size) {
+		ret = vfio_iommu_type1_zpci_fn(d->domain, caps, fn_size);
+		if (ret)
+			return ret;
+	}
+
+	if (grp_size)
+		ret = vfio_iommu_type1_zpci_grp(d->domain, caps, grp_size);
+
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1679,6 +1770,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		}
 	} else if (cmd == VFIO_IOMMU_GET_INFO) {
 		struct vfio_iommu_type1_info info;
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		int ret;
 
 		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
 
@@ -1688,7 +1781,34 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.flags = VFIO_IOMMU_INFO_PGSIZES;
+		if (info.flags & VFIO_IOMMU_INFO_CAPABILITIES) {
+			minsz = offsetofend(struct vfio_iommu_type1_info,
+					    cap_offset);
+			if (info.argsz < minsz)
+				return -EINVAL;
+			ret = vfio_iommu_type1_caps(iommu, &caps,
+						    info.argsz - sizeof(info));
+			if (ret)
+				return ret;
+		}
+		if (caps.size) {
+			if (info.argsz < sizeof(info) + caps.size) {
+				info.argsz = sizeof(info) + caps.size;
+				info.cap_offset = 0;
+			} else {
+				if (copy_to_user((void __user *)arg +
+						 sizeof(info), caps.buf,
+						 caps.size)) {
+					kfree(caps.buf);
+					return -EFAULT;
+				}
+
+				info.cap_offset = sizeof(info);
+			}
+			kfree(caps.buf);
+		}
+
+		info.flags |= VFIO_IOMMU_INFO_PGSIZES;
 
 		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
-- 
2.7.4
