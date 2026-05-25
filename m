Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD63F58DC;
	Mon, 25 May 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724164; cv=none; b=srDQv4Z8GMg4bcl3iHiIVXfMUPh0H0WeBWtW4vwVYae/AUKZY61+tXYsjcpJTt8wTgMbT9Xu2X9DCInxeEcNCMRxIrdJChphXFaW7tfTXtLB2yE6Ji5e0dsHFwLU8HDc6jaIhHGZJFzxSih/lyC4kDWj/biMBOq1pLdWe10RDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724164; c=relaxed/simple;
	bh=eo0Q5Yc/gSpdt8JUa3nxyM/v/4c+9gWjK0renmzlUkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFtcQuWd3kE2c+pBGuYPxMj+p45meqZSuNejwTZbnMbYbADmPSqsg1X5/x0F/I6rLQELcQ/f6qVsFTzAgtOPn+efxERstIZYtxEr3ydKkplYHYCaj7aKRcAm++8C8X/nELqFRdVQnk/nR/qsuaWy2CorNrEFCLfpVnEZHHe05X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Teh/UsWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Teh/UsWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6741F000E9;
	Mon, 25 May 2026 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724163;
	bh=MeBBSSakKIvm2d5LqQt3MO1L93w0DXhBEkhD5zW8Rrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Teh/UsWjXJl+y/VjQs+IUe1C2QJURdWvjlI9yTG/KEV0d+r3J3ok/siaI0lsE3fax
	 VvjSxb++NK7p5oz9FvQQfww3PCzBUkBhdJzZQPxhLH2Yl1o0CkJojQxkxTQOh5HykV
	 mgpCFnNRk4H5sLTEhLKqRfFUHtSDryvenhjL+Vz5qERm2MFCgp2XjO2qclTAPd2HG+
	 +jkvY78ZhtiyCVM0DjlfDmgHKDMoU3iZFIyX4OktWhgvoeInNnrYpe7f/R3o8nlMS7
	 WBZzb+rb7zZf826QNupi+yMj4ORyyZ1AGl5EoaYTO0m0klEy22TgcpYHLQUbwc8lVd
	 SijOJXjkhosyQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v5 4/5] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Date: Mon, 25 May 2026 21:18:15 +0530
Message-ID: <20260525154816.1029642-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce IOMMU_VDEVICE_TSM_OP to allow userspace to issue TSM bind/unbind
operations for an iommufd vdevice.

The new ioctl:
- looks up the vdevice object from vdevice_id
- resolves the associated KVM VM from the vIOMMU KVM file reference
- dispatches bind/unbind via tsm_bind()/tsm_unbind()

Also add common TSM helpers in tsm-core and wire vdevice teardown to unbind
the device from TSM state.

This provides iommufd plumbing to bind a TDI to a confidential guest through
the TSM layer.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/Makefile          |  2 +
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/tsm.c             | 62 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  4 ++
 drivers/virt/coco/tsm-core.c            | 19 ++++++++
 include/linux/tsm.h                     | 17 +++++++
 include/uapi/linux/iommufd.h            | 26 +++++++++++
 8 files changed, 141 insertions(+)
 create mode 100644 drivers/iommu/iommufd/tsm.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..431089089ee9 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -10,6 +10,8 @@ iommufd-y := \
 	vfio_compat.o \
 	viommu.o
 
+iommufd-$(CONFIG_TSM) += tsm.o
+
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 44eb026c206d..8eea0c2c332b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -699,6 +699,14 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
+#ifdef CONFIG_TSM
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 static inline struct iommufd_vdevice *
 iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..d73e6b391c6f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -432,6 +432,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_tsm_op tsm_op;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
+		 struct iommu_vdevice_tsm_op, vdevice_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
new file mode 100644
index 000000000000..09ee668dbed9
--- /dev/null
+++ b/drivers/iommu/iommufd/tsm.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+
+#include <linux/tsm.h>
+#include "iommufd_private.h"
+
+/**
+ * iommufd_vdevice_tsm_op_ioctl - Handle vdevice TSM operations
+ * @ucmd: user command data for IOMMU_VDEVICE_TSM_OP
+ *
+ * Currently only supports TSM bind/unbind operations
+ * Resolve @iommu_vdevice_tsm_op::vdevice_id to a vdevice and dispatch the
+ * requested bind/unbind operation through the TSM core.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int rc;
+	struct kvm *kvm = NULL;
+	struct iommufd_vdevice *vdev;
+	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	if (vdev->viommu->kvm_file)
+		kvm = vdev->viommu->kvm_file->private_data;
+
+	if (!kvm) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	/* tsm layer will take care of parallel calls to tsm_bind/unbind */
+	switch (cmd->type) {
+	case IOMMU_VDEVICE_TSM_BIND:
+		rc = tsm_bind(vdev->idev->dev, kvm, vdev->virt_id);
+		break;
+	case IOMMU_VDEVICE_TSM_UNBIND:
+		rc = tsm_unbind(vdev->idev->dev);
+		break;
+	default:
+		rc = -EINVAL;
+		goto out_put_vdev;
+	}
+
+	if (rc)
+		goto out_put_vdev;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index bf5d58d55939..1b9379fcba84 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -3,6 +3,8 @@
  */
 #include <linux/file.h>
 #include "iommufd_private.h"
+#include <linux/cleanup.h>
+#include <linux/tsm.h>
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -124,6 +126,8 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	tsm_unbind(idev->dev);
+
 	if (vdev->destroy)
 		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index e784993353d8..3870d08ffe0d 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -108,6 +108,25 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
+}
+EXPORT_SYMBOL_GPL(tsm_bind);
+
+int tsm_unbind(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pci_tsm_unbind(to_pci_dev(dev));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_unbind);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 381c53244c83..7b6df827321b 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -123,4 +123,21 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
+
+struct kvm;
+#ifdef CONFIG_TSM
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
+int tsm_unbind(struct device *dev);
+#else
+static inline int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
+{
+	return -EINVAL;
+}
+
+static inline int tsm_unbind(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e998dfbd6960..66398efa31d1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
 };
 
 /**
@@ -1143,6 +1144,31 @@ struct iommu_vdevice_alloc {
 };
 #define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 
+/**
+ * enum iommu_vdevice_tsm_op_type - operation type for struct iommu_vdevice_tsm_op
+ * @IOMMU_VDEVICE_TSM_BIND: Bind a vDevice to TSM
+ * @IOMMU_VDEVICE_TSM_UNBIND: Unbind a vDevice from TSM
+ */
+enum iommu_vdevice_tsm_op_type {
+	IOMMU_VDEVICE_TSM_BIND = 0x1,
+	IOMMU_VDEVICE_TSM_UNBIND,
+};
+
+/**
+ * struct iommu_vdevice_tsm_op - ioctl(IOMMU_VDEVICE_TSM_OP)
+ * @size: sizeof(struct iommu_vdevice_tsm_op)
+ * @type: Type of TSM operation. Must be defined in enum iommu_vdevice_tsm_op_type
+ * @flags: Must be 0
+ * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
+ */
+struct iommu_vdevice_tsm_op {
+	__u32 size;
+	__u32 type;
+	__u32 flags;
+	__u32 vdevice_id;
+};
+#define IOMMU_VDEVICE_TSM_OP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_OP)
+
 /**
  * struct iommu_ioas_change_process - ioctl(VFIO_IOAS_CHANGE_PROCESS)
  * @size: sizeof(struct iommu_ioas_change_process)
-- 
2.43.0

