Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20143F54DD;
	Mon, 25 May 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724177; cv=none; b=cDp0vKIkXI52WB7rffy9Xjs6wjwphYMS4tPbUfBSMMWLqac3v/Be6+DuNhop5b466RCNDvq/3/b7mTLX/zvIOAO/eIhZQfUHbagw09ZSBUQCGyU09ZALQvorEzYrPNrCFidHCNMNWX82tbU0HU+mmKaz7p4Syq8+SJ4OZGPENlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724177; c=relaxed/simple;
	bh=mz34hRDMF21LfmIAT/xWLZOphwveic0Tu0PLIIlD28E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np4+C5o7j9NtPu/Z60UnF1OeEfbr11B4WcsXt2uYJBbxSiQzdd/9uyTGBxv5H0Guc5kx7CEwwfla5ADAb4eB3aAyluhKqfrUHGtyB+nxs9n+K6RZvNsjwoJIuf1THZ2IXCX8xqLKBRMAvhCLQ/WAmiIu+hrMnJ4cj2aVQtXkpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RACJSIzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RACJSIzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7881F00A3A;
	Mon, 25 May 2026 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724175;
	bh=VJSEaUEBwx/9WnTU9c3kp52xIPJugmYjuIP87ViR1aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RACJSIzXD/o0IaFudAv/OVa1Nhqmw/adkCtpzjYWPkFTgb3mG+FVLhIq6gCainsmt
	 jR7KveRH8E5xKAW5xsqOjFQ2pSdspXSR58NUbUPfyuoxdrFefhtYzN23LUyapTL4Nx
	 jzOl2Ev7jm6uwcoTW1U0ZWtSuMC1qPWePYLpKihU6SCSf4jjDgCqdl6wm9g867chKj
	 nzACLw2on0y1EPbbEW/SbECrzF+Ux64ZGFSmkvw6cEYnkqYXZAavMxm+iMbYPRRBWs
	 ldj3KtNW0drYNxb0jwfwis63cGYA6eDRrqdd1g6O18KWp06kX+dXXWkoCGycQZqkbw
	 2hhig+BgoBwTA==
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
Subject: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Date: Mon, 25 May 2026 21:18:16 +0530
Message-ID: <20260525154816.1029642-6-aneesh.kumar@kernel.org>
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

Add IOMMU_VDEVICE_TSM_REQUEST for issuing TSM guest request/response
transactions against an iommufd vdevice.

The ioctl takes a vdevice_id plus request/response user buffers and length
fields, and forwards the request through tsm_guest_req() to the PCI TSM
backend. This provides the host-side passthrough path used by CoCo guests
for TSM device attestation and acceptance flows after the device has been
bound to TSM.

Also add the supporting tsm_guest_req() helper and associated TSM core
interface definitions.

Based on changes from: Alexey Kardashevskiy <aik@amd.com>

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/iommufd_private.h |  6 ++
 drivers/iommu/iommufd/main.c            |  3 +
 drivers/iommu/iommufd/tsm.c             | 68 +++++++++++++++++++++
 drivers/virt/coco/tsm-core.c            | 39 ++++++++++++
 include/linux/pci-tsm.h                 |  9 +--
 include/linux/tsm.h                     | 25 ++++++++
 include/uapi/linux/iommufd.h            | 80 +++++++++++++++++++++++++
 7 files changed, 226 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8eea0c2c332b..0080895e9e92 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -701,11 +701,17 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 #ifdef CONFIG_TSM
 int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd);
 #else
 static inline int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct iommufd_vdevice *
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index d73e6b391c6f..5f49b546ec92 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -433,6 +433,7 @@ union ucmd_buffer {
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 	struct iommu_vdevice_tsm_op tsm_op;
+	struct iommu_vdevice_tsm_req tsm_req;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -496,6 +497,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_viommu_alloc, out_viommu_id),
 	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
 		 struct iommu_vdevice_tsm_op, vdevice_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_REQ, iommufd_vdevice_tsm_req_ioctl,
+		 struct iommu_vdevice_tsm_req, resp_uptr),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
index 09ee668dbed9..342fbdb6a6b9 100644
--- a/drivers/iommu/iommufd/tsm.c
+++ b/drivers/iommu/iommufd/tsm.c
@@ -60,3 +60,71 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &vdev->obj);
 	return rc;
 }
+
+static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
+{
+	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
+		return false;
+
+	switch (scope) {
+	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
+	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
+	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
+	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * iommufd_vdevice_tsm_req_ioctl - Forward TSM requests
+ * @ucmd: user command data for IOMMU_VDEVICE_TSM_REQ
+ *
+ * Resolve @iommu_vdevice_tsm_req::vdevice_id to a vdevice and pass the
+ * request/response buffers to the TSM core.
+ *
+ * Return:
+ *  -errno on error.
+ *  positive residue if response/request bytes were left unconsumed.
+ *    if response buffer is provided, residue indicates the number of bytes
+ *    not used in response buffer
+ *    if there is no response buffer, residue indicates the number of bytes
+ *    not consumed in req buffer
+ *  0 otherwise.
+ */
+int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int rc;
+	struct iommufd_vdevice *vdev;
+	struct iommu_vdevice_tsm_req *cmd = ucmd->cmd;
+	struct tsm_guest_req_info info = {
+		.scope = cmd->scope,
+		.req   = {
+			.user = u64_to_user_ptr(cmd->req_uptr),
+			.is_kernel = false,
+		},
+		.req_len = cmd->req_len,
+		.resp    =  {
+			.user = u64_to_user_ptr(cmd->resp_uptr),
+			.is_kernel = false,
+		},
+		.resp_len = cmd->resp_len,
+	};
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	if (!iommufd_vdevice_tsm_req_scope_valid(cmd->scope))
+		return -EINVAL;
+
+	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	rc = tsm_guest_req(vdev->idev->dev, &info);
+
+	/* No inline response, hence we don't need to copy the response */
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 3870d08ffe0d..c24886851f9e 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <uapi/linux/iommufd.h>
 
 static void tsm_release(struct device *);
 static const struct class tsm_class = {
@@ -127,6 +128,44 @@ int tsm_unbind(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unbind);
 
+static int tsm_pci_req_scope(u32 scope, enum pci_tsm_req_scope *pci_scope)
+{
+	switch (scope) {
+	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
+		*pci_scope = PCI_TSM_REQ_INFO;
+		return 0;
+	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
+		*pci_scope = PCI_TSM_REQ_STATE_CHANGE;
+		return 0;
+	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
+		*pci_scope = PCI_TSM_REQ_DEBUG_READ;
+		return 0;
+	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
+		*pci_scope = PCI_TSM_REQ_DEBUG_WRITE;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info)
+{
+	int ret;
+	enum pci_tsm_req_scope pci_scope;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	ret = tsm_pci_req_scope(info->scope, &pci_scope);
+	if (ret)
+		return ret;
+
+	return pci_tsm_guest_req(to_pci_dev(dev), pci_scope, info->req,
+				 info->req_len, info->resp, info->resp_len,
+				 NULL);
+}
+EXPORT_SYMBOL_GPL(tsm_guest_req);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..ec2236a7a279 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -4,6 +4,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/iommufd.h>
 
 struct pci_tsm;
 struct tsm_dev;
@@ -173,7 +174,7 @@ enum pci_tsm_req_scope {
 	 * typical TDISP collateral information like Device Interface Reports.
 	 * No device secrets are permitted, and no device state is changed.
 	 */
-	PCI_TSM_REQ_INFO = 0,
+	PCI_TSM_REQ_INFO = IOMMU_VDEVICE_TSM_REQ_PCI_INFO,
 	/**
 	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
 	 * UNLOCKED->LOCKED, LOCKED->RUN, or other architecture specific state
@@ -181,14 +182,14 @@ enum pci_tsm_req_scope {
 	 * to TDISP) device / host state, configuration, or data change is
 	 * permitted.
 	 */
-	PCI_TSM_REQ_STATE_CHANGE = 1,
+	PCI_TSM_REQ_STATE_CHANGE = IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE,
 	/**
 	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
 	 *
 	 * A method to facilitate TVM information retrieval outside of typical
 	 * TDISP operational requirements. No device secrets are permitted.
 	 */
-	PCI_TSM_REQ_DEBUG_READ = 2,
+	PCI_TSM_REQ_DEBUG_READ = IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ,
 	/**
 	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
 	 *
@@ -196,7 +197,7 @@ enum pci_tsm_req_scope {
 	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
 	 * will taint the kernel.
 	 */
-	PCI_TSM_REQ_DEBUG_WRITE = 3,
+	PCI_TSM_REQ_DEBUG_WRITE = IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE,
 };
 
 #ifdef CONFIG_PCI_TSM
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 7b6df827321b..6101a2a1db61 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/device.h>
+#include <linux/sockptr.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_16M
@@ -128,6 +129,23 @@ struct kvm;
 #ifdef CONFIG_TSM
 int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
 int tsm_unbind(struct device *dev);
+
+/**
+ * struct tsm_guest_req_info - parameter for tsm_guest_req()
+ * @scope: iommufd allocated scope for tsm guest request
+ * @req: request data buffer filled by guest
+ * @req_len: the size of @req filled by guest
+ * @resp: response data buffer filled by host
+ * @resp_len: the size of @resp buffer filled by guest
+ */
+struct tsm_guest_req_info {
+	u32 scope;
+	sockptr_t req;
+	size_t req_len;
+	sockptr_t resp;
+	size_t resp_len;
+};
+ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info);
 #else
 static inline int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
 {
@@ -138,6 +156,13 @@ static inline int tsm_unbind(struct device *dev)
 {
 	return 0;
 }
+
+struct tsm_guest_req_info;
+static inline ssize_t tsm_guest_req(struct device *dev,
+		struct tsm_guest_req_info *info)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 66398efa31d1..7953e99a9671 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
+	IOMMUFD_CMD_VDEVICE_TSM_REQ = 0x96,
 };
 
 /**
@@ -1373,4 +1374,83 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/*
+ * TSM request scope values are allocated by iommufd. Each device-bus transport
+ * gets a range from this number space.
+ */
+#define IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE	0
+
+enum iommu_vdevice_tsm_req_scope {
+	/*
+	 * Read-only, without side effects, request for typical TDISP
+	 * collateral information like Device Interface Reports. No device
+	 * secrets are permitted, and no device state is changed.
+	 */
+	IOMMU_VDEVICE_TSM_REQ_PCI_INFO =
+		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE,
+	/*
+	 * Request to change the TDISP state from UNLOCKED->LOCKED,
+	 * LOCKED->RUN, or other architecture specific state changes to
+	 * support those transitions for a TDI. No other device or host state,
+	 * configuration, or data change is permitted.
+	 */
+	IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE =
+		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 1,
+	/*
+	 * Read-only request for debug information outside of typical TDISP
+	 * operational requirements. No device secrets are permitted.
+	 */
+	IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ =
+		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 2,
+	/*
+	 * Device state changes for debug purposes. The request may affect the
+	 * operational state of the device outside of the TDISP operational
+	 * model. If allowed, this requires CAP_SYS_RAW_IO and taints the
+	 * kernel.
+	 */
+	IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE =
+		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 3,
+	IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST =
+		IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE,
+};
+
+/**
+ * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
+ * @size: sizeof(struct iommu_vdevice_tsm_req)
+ * @vdevice_id: vDevice ID the guest request is for
+ * @scope: One of enum iommu_vdevice_tsm_req_scope
+ * @req_len: Size in bytes of the input payload at @req_uptr
+ * @resp_len: Size in bytes of the output buffer at @resp_uptr
+ * @__reserved: Must be 0
+ * @req_uptr: Userspace pointer to the guest-provided request payload
+ * @resp_uptr: Userspace pointer to the guest response buffer
+ *
+ * Forward a TSM request to the TSM bound vDevice. This is intended for
+ * guest TSM/TDISP message transport where the host kernel only marshals
+ * bytes between userspace and the TSM implementation.
+ *
+ * Requests outside the iommufd allocated scope values are rejected. Lower
+ * layers may reject scope values that are valid in the global iommufd
+ * namespace, but not permitted for a specific bus.
+ *
+ * The request payload is read from @req_uptr/@req_len. If a response is
+ * expected, userspace provides @resp_uptr/@resp_len as writable storage for
+ * response bytes returned by the TSM path.
+ *
+ * The ioctl is only suitable for commands and results that the host kernel
+ * has no use, the host is only facilitating guest to TSM communication.
+ */
+struct iommu_vdevice_tsm_req {
+	__u32 size;
+	__u32 vdevice_id;
+	__u32 scope;
+	__u32 req_len;
+	__u32 resp_len;
+	__u32 __reserved;
+	__aligned_u64 req_uptr;
+	__aligned_u64 resp_uptr;
+};
+
+#define IOMMU_VDEVICE_TSM_REQ _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_REQ)
 #endif
-- 
2.43.0

