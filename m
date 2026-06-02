Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845852DF138;
	Tue,  2 Jun 2026 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780377044; cv=none; b=XIgu4OEt8U7FVBFE0PyEhdIiWrTfuGPMxpuezP256+d1z8xyZAvbBnlpJJZ4eLwahpMv54aZckGRzgjrAk7tf2Cmye1Vwv3iDGmM+1SmSvlHP3ugvyIFVZJraC430/JsOy1PXQwCLPIiraQjmh40pAYqYH6RCF2hPlMTZEHtkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780377044; c=relaxed/simple;
	bh=gm4dW8NedlhptRpJCNnUM/YOdjo6Y8+IK2HnEJ2Gvo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QFhRhdyshRkPKo7jpN1HqDgMetSzSlR3F06ME1WJZgZskhbqfkR5AURt5sd0L2YvJZ0nlyLybdN+1zC74U29Gc8343Eb12DbpA/NhGN3ywpwCnjh9OarGx5mAj4v0jM5hthCz/VnilWd3zd5ENsDT9TXeSaCUvcLkjdvowPSHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOrfE+vt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOrfE+vt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA0B1F00893;
	Tue,  2 Jun 2026 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780377042;
	bh=JzCSm5WadCiXkyzrFfRbJ6w6dfhtp32ChjBkJ8y1Qo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dOrfE+vtXXLYtHlgVkvgyzoOD5zjpdQh/Nap7jve4EAhlkl+GSYPoMWUUSjjMgobN
	 4sehBqpswimMIVYw437ahcMDTA/RrqDjurkByNI2SwLKFDaaRM6kf5Gm4kd/Z57Aaz
	 1lUzfElnegJwVXENI7pVWqhxS3bAqt5hBzK1XcvHLlGs0KVFdV4jylznRKI/UMJ1BQ
	 NwAE+Is0biJiISzdiPhDftvcBPFVU9vQHaB+f2Ds9nYC5+Z/2Kn8nVZAiDuNi7hDOF
	 zC/+LekjRTRnbSn2pGiA5PCNM27FrEnp1887C9ocibsI++5/luSKT8KISLIaevO3IC
	 1nrQz7ZZll2wA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
	"Dan Williams (nvidia)" <djbw@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <djbw@kernel.org>,
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
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
In-Reply-To: <6a1774dd80f74_19737610095@djbw-dev.notmuch>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch> <yq5apl2gsw6y.fsf@kernel.org>
 <yq5aldd4spyc.fsf@kernel.org> <6a1774dd80f74_19737610095@djbw-dev.notmuch>
Date: Tue, 02 Jun 2026 10:40:29 +0530
Message-ID: <yq5aik81sf22.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Dan Williams (nvidia)" <djbw@kernel.org> writes:

> Aneesh Kumar K.V wrote:
>> >> I am leaning towards the latter at this point.
>> >
>> > But we already have struct pci_tsm_ops::guest_req, which is specific to
>> > the underlying CC architecture. From the above, pci_tsm_req_scope also
>> > appears to carry the same information. Is that useful?
>> >
>>=20
>> I think there is value in having the VMM express the guest=E2=80=99s
>> confidential computing architecture, so that the TSM backend can
>> validate whether it should handle that guest request ?.
>
> Yes, that is the idea.
>
>> So it would not be the IOMMU validating the scope value, but rather
>> pci_tsm_ops::guest_req.
>>=20
>> static ssize_t cca_tsm_guest_req(struct pci_tdi *tdi, enum pci_tsm_req_s=
cope scope,
>> 		sockptr_t req, size_t req_len, sockptr_t resp,
>> 		size_t resp_len, u64 *tsm_code)
>> {
>> 	struct pci_dev *pdev =3D tdi->pdev;
>>=20
>> 	/* reject the guest request if VMM was using the link tsm wrongly. The =
guest
>> 	 * was using a wrong CC archiecture with this link tsm
>> 	 */
>> 	if (scope !=3D TSM_REQ_TYPE_CCA)
>> 		return -EINVAL;
>
> Right, iommufd is tunneling TSM requests. The tunnel should have an
> envelope of TSM_REQ_TYPE_* and an @op field. The TSM driver gets those
> from iommufd, validates the envelope and then processes @req.
>
> This self-consistency and explicitness also buys some future-proofing.
> It allows for alternate command sets within an arch, cross TSM
> implementation shared commands, IOMMUFD-to-TSM requests outside of guest
> requests.
>
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>=20
>> > On Tue, May 26, 2026 at 11:17:50PM -0700, Dan Williams (nvidia) wrote:
>> >
>> >> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
>> >>=20
>> >> TSM_REQ_TYPE_CCA
>> >> TSM_REQ_TYPE_SEV
>> >> TSM_REQ_TYPE_TDX
>> >>=20
>> >> I am leaning towards the latter at this point.
>> >
>> > Yeah, this sounds good. I would also include an common op field that
>> > can be decoded by the TSM driver based on the TYPE above, and the
>> > usual in/out message buffers.
>>=20
>> We already have iommufd_vdevice_tsm_op_ioctl() to handle common
>> operations.
>
> Per above, I believe this is about an @op value in a common location
> that iommufd can forward to the backend for validation of guest
> requests.
>
>> Right now, it handles IOMMU_VDEVICE_TSM_BIND and
>> IOMMU_VDEVICE_TSM_UNBIND. I guess we should move TSM_REQ_SET_TDI_STATE
>> operations to that as well?
>
> I think we can wait to move it to its own IOMMU operation unless/until
> there is a need to set RUN outside of an explicit guest request, right?

Something like the below? (the diff against this series)

I have not yet integrated this into the full CCA patchset for testing,
but I wanted to make sure we are aligned on the UAPI.

diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
index 56bb499ba7a9..345efba2e66e 100644
--- a/drivers/iommu/iommufd/tsm.c
+++ b/drivers/iommu/iommufd/tsm.c
@@ -61,17 +61,30 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *u=
cmd)
 	return ret;
 }
=20
-static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
+static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
 {
-	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
+	switch (tvm_arch) {
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
+		return true;
+	default:
 		return false;
+	}
+}
=20
-	switch (scope) {
-	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
-	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
-	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
-	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
+static bool iommufd_vdevice_tsm_req_op_valid(u32 op, u32 tvm_arch)
+{
+	switch (op) {
+	case TSM_REQ_READ_OBJECT:
+	case TSM_REQ_REGEN_OBJECT:
+	case TSM_REQ_OBJECT_INFO:
+	case TSM_REQ_VALIDATE_MMIO:
+	case TSM_REQ_SET_TDI_STATE:
 		return true;
+	case TSM_REQ_SEV_ENABLE_DMA:
+	case TSM_REQ_SEV_DISABLE_DMA:
+		return tvm_arch =3D=3D IOMMU_VDEVICE_TSM_TVM_ARCH_SEV;
 	default:
 		return false;
 	}
@@ -99,7 +112,8 @@ int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *u=
cmd)
 	struct iommufd_vdevice *vdev;
 	struct iommu_vdevice_tsm_req *cmd =3D ucmd->cmd;
 	struct tsm_guest_req_info info =3D {
-		.scope =3D cmd->scope,
+		.op =3D cmd->op,
+		.tvm_arch =3D cmd->tvm_arch,
 		.req   =3D {
 			.user =3D u64_to_user_ptr(cmd->req_uptr),
 			.is_kernel =3D false,
@@ -112,10 +126,10 @@ int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd=
 *ucmd)
 		.resp_len =3D cmd->resp_len,
 	};
=20
-	if (cmd->__reserved)
-		return -EOPNOTSUPP;
+	if (!iommufd_vdevice_tsm_req_arch_valid(cmd->tvm_arch))
+		return -EINVAL;
=20
-	if (!iommufd_vdevice_tsm_req_scope_valid(cmd->scope))
+	if (!iommufd_vdevice_tsm_req_op_valid(cmd->op, cmd->tvm_arch))
 		return -EINVAL;
=20
 	vdev =3D iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..439241c756fd 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -378,7 +378,8 @@ EXPORT_SYMBOL_GPL(pci_tsm_bind);
 /**
  * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
  * @pdev: @pdev representing a bound tdi
- * @scope: caller asserts this passthrough request is limited to TDISP ope=
rations
+ * @op: guest-initiated request operation
+ * @tvm_arch: guest TVM architecture
  * @req_in: Input payload forwarded from the guest
  * @in_len: Length of @req_in
  * @req_out: Output payload buffer response to the guest
@@ -387,7 +388,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_bind);
  *
  * This is a common entry point for requests triggered by userspace KVM-ex=
it
  * service handlers responding to TDI information or state change requests=
. The
- * scope parameter limits requests to TDISP state management, or limited d=
ebug.
+ * operation parameter limits requests to guest-initiated TSM operations.
  * This path is only suitable for commands and results that are the host k=
ernel
  * has no use, the host is only facilitating guest to TSM communication.
  *
@@ -400,7 +401,9 @@ EXPORT_SYMBOL_GPL(pci_tsm_bind);
  * Context: Caller is responsible for calling this within the pci_tsm_bind=
()
  * state of the TDI.
  */
-ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope sco=
pe,
+ssize_t pci_tsm_guest_req(struct pci_dev *pdev,
+			  enum iommu_vdevice_tsm_guest_req_op op,
+			  enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code)
 {
@@ -408,9 +411,30 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum p=
ci_tsm_req_scope scope,
 	struct pci_tdi *tdi;
 	int rc;
=20
-	/* Forbid requests that are not directly related to TDISP operations */
-	if (scope > PCI_TSM_REQ_STATE_CHANGE)
+	switch (tvm_arch) {
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
+		break;
+	default:
 		return -EINVAL;
+	}
+
+	switch (op) {
+	case TSM_REQ_READ_OBJECT:
+	case TSM_REQ_REGEN_OBJECT:
+	case TSM_REQ_OBJECT_INFO:
+	case TSM_REQ_VALIDATE_MMIO:
+	case TSM_REQ_SET_TDI_STATE:
+		break;
+	case TSM_REQ_SEV_ENABLE_DMA:
+	case TSM_REQ_SEV_DISABLE_DMA:
+		if (tvm_arch =3D=3D IOMMU_VDEVICE_TSM_TVM_ARCH_SEV)
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
=20
 	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
 	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &lock)))
@@ -430,8 +454,9 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pc=
i_tsm_req_scope scope,
 	tdi =3D pdev->tsm->tdi;
 	if (!tdi)
 		return -ENXIO;
-	return to_pci_tsm_ops(pdev->tsm)->guest_req(tdi, scope, req_in, in_len,
-						    req_out, out_len, tsm_code);
+	return to_pci_tsm_ops(pdev->tsm)->guest_req(tdi, op, tvm_arch, req_in,
+						    in_len, req_out, out_len,
+						    tsm_code);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
=20
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index ce01b19990f5..88cb168d8120 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -128,42 +128,15 @@ int tsm_unbind(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unbind);
=20
-static int tsm_pci_req_scope(u32 scope, enum pci_tsm_req_scope *pci_scope)
-{
-	switch (scope) {
-	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
-		*pci_scope =3D PCI_TSM_REQ_INFO;
-		return 0;
-	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
-		*pci_scope =3D PCI_TSM_REQ_STATE_CHANGE;
-		return 0;
-	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
-		*pci_scope =3D PCI_TSM_REQ_DEBUG_READ;
-		return 0;
-	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
-		*pci_scope =3D PCI_TSM_REQ_DEBUG_WRITE;
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
 ssize_t tsm_guest_req(struct device *dev,
 		struct tsm_guest_req_info *info, u64 *tsm_code)
 {
-	int ret;
-	enum pci_tsm_req_scope pci_scope;
-
 	if (!dev_is_pci(dev))
 		return -EINVAL;
=20
-	ret =3D tsm_pci_req_scope(info->scope, &pci_scope);
-	if (ret)
-		return ret;
-
-	return pci_tsm_guest_req(to_pci_dev(dev), pci_scope, info->req,
-				 info->req_len, info->resp, info->resp_len,
-				 tsm_code);
+	return pci_tsm_guest_req(to_pci_dev(dev), info->op, info->tvm_arch,
+				 info->req, info->req_len, info->resp,
+				 info->resp_len, tsm_code);
 }
 EXPORT_SYMBOL_GPL(tsm_guest_req);
=20
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index ec2236a7a279..30a60551fcf5 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -9,7 +9,6 @@
 struct pci_tsm;
 struct tsm_dev;
 struct kvm;
-enum pci_tsm_req_scope;
=20
 /*
  * struct pci_tsm_ops - manage confidential links and security state
@@ -55,7 +54,8 @@ struct pci_tsm_ops {
 					struct kvm *kvm, u32 tdi_id);
 		void (*unbind)(struct pci_tdi *tdi);
 		ssize_t (*guest_req)(struct pci_tdi *tdi,
-				     enum pci_tsm_req_scope scope,
+				     enum iommu_vdevice_tsm_guest_req_op op,
+				     enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch,
 				     sockptr_t req_in, size_t in_len,
 				     sockptr_t req_out, size_t out_len,
 				     u64 *tsm_code);
@@ -160,46 +160,6 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) =3D=3D 0;
 }
=20
-/**
- * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
- *
- * Guest requests are a transport for a TVM to communicate with a TSM + DS=
M for
- * a given TDI. A TSM driver is responsible for maintaining the kernel sec=
urity
- * model and limit commands that may affect the host, or are otherwise out=
side
- * the typical TDISP operational model.
- */
-enum pci_tsm_req_scope {
-	/**
-	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
-	 * typical TDISP collateral information like Device Interface Reports.
-	 * No device secrets are permitted, and no device state is changed.
-	 */
-	PCI_TSM_REQ_INFO =3D IOMMU_VDEVICE_TSM_REQ_PCI_INFO,
-	/**
-	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
-	 * UNLOCKED->LOCKED, LOCKED->RUN, or other architecture specific state
-	 * changes to support those transitions for a TDI. No other (unrelated
-	 * to TDISP) device / host state, configuration, or data change is
-	 * permitted.
-	 */
-	PCI_TSM_REQ_STATE_CHANGE =3D IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE,
-	/**
-	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
-	 *
-	 * A method to facilitate TVM information retrieval outside of typical
-	 * TDISP operational requirements. No device secrets are permitted.
-	 */
-	PCI_TSM_REQ_DEBUG_READ =3D IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ,
-	/**
-	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
-	 *
-	 * The request may affect the operational state of the device outside of
-	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
-	 * will taint the kernel.
-	 */
-	PCI_TSM_REQ_DEBUG_WRITE =3D IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE,
-};
-
 #ifdef CONFIG_PCI_TSM
 int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
@@ -214,7 +174,9 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm,=
 u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);
 void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 			     struct kvm *kvm, u32 tdi_id);
-ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope sco=
pe,
+ssize_t pci_tsm_guest_req(struct pci_dev *pdev,
+			  enum iommu_vdevice_tsm_guest_req_op op,
+			  enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code);
 #else
@@ -233,7 +195,8 @@ static inline void pci_tsm_unbind(struct pci_dev *pdev)
 {
 }
 static inline ssize_t pci_tsm_guest_req(struct pci_dev *pdev,
-					enum pci_tsm_req_scope scope,
+					enum iommu_vdevice_tsm_guest_req_op op,
+					enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch,
 					sockptr_t req_in, size_t in_len,
 					sockptr_t req_out, size_t out_len,
 					u64 *tsm_code)
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index b83b72bbf5e3..cba0ada5f4cb 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -7,6 +7,7 @@
 #include <linux/uuid.h>
 #include <linux/device.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/iommufd.h>
=20
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_16M
@@ -132,14 +133,16 @@ int tsm_unbind(struct device *dev);
=20
 /**
  * struct tsm_guest_req_info - parameter for tsm_guest_req()
- * @scope: iommufd allocated scope for tsm guest request
+ * @op: operation for the guest-initiated request
+ * @tvm_arch: guest TVM architecture
  * @req: request data buffer filled by guest
  * @req_len: the size of @req filled by guest
  * @resp: response data buffer filled by host
  * @resp_len: the size of @resp buffer filled by guest
  */
 struct tsm_guest_req_info {
-	u32 scope;
+	enum iommu_vdevice_tsm_guest_req_op op;
+	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
 	sockptr_t req;
 	size_t req_len;
 	sockptr_t resp;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 70c2927c18bc..0789a705bb07 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1375,54 +1375,46 @@ struct iommu_hw_queue_alloc {
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
=20
-/*
- * TSM request scope values are allocated by iommufd. Each device-bus tran=
sport
- * gets a range from this number space.
+/**
+ * enum iommu_vdevice_tsm_guest_tvm_arch - guest TVM architecture
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_CCA: Arm CCA TVM
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_SEV: AMD SEV TVM
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_TDX: Intel TDX TVM
  */
-#define IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE	0
+enum iommu_vdevice_tsm_guest_tvm_arch {
+	IOMMU_VDEVICE_TSM_TVM_ARCH_CCA =3D 1,
+	IOMMU_VDEVICE_TSM_TVM_ARCH_SEV,
+	IOMMU_VDEVICE_TSM_TVM_ARCH_TDX,
+};
=20
-enum iommu_vdevice_tsm_req_scope {
-	/*
-	 * Read-only, without side effects, request for typical TDISP
-	 * collateral information like Device Interface Reports. No device
-	 * secrets are permitted, and no device state is changed.
-	 */
-	IOMMU_VDEVICE_TSM_REQ_PCI_INFO =3D
-		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE,
-	/*
-	 * Request to change the TDISP state from UNLOCKED->LOCKED,
-	 * LOCKED->RUN, or other architecture specific state changes to
-	 * support those transitions for a TDI. No other device or host state,
-	 * configuration, or data change is permitted.
-	 */
-	IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE =3D
-		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 1,
-	/*
-	 * Read-only request for debug information outside of typical TDISP
-	 * operational requirements. No device secrets are permitted.
-	 */
-	IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ =3D
-		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 2,
-	/*
-	 * Device state changes for debug purposes. The request may affect the
-	 * operational state of the device outside of the TDISP operational
-	 * model. If allowed, this requires CAP_SYS_RAW_IO and taints the
-	 * kernel.
-	 */
-	IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE =3D
-		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 3,
-	IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST =3D
-		IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE,
+/**
+ * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
+ * @TSM_REQ_READ_OBJECT: Read a TSM object
+ * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
+ * @TSM_REQ_OBJECT_INFO: Read TSM object information
+ * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
+ * @TSM_REQ_SET_TDI_STATE: Set TDI state
+ * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
+ * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
+ */
+enum iommu_vdevice_tsm_guest_req_op {
+	TSM_REQ_READ_OBJECT =3D 1,
+	TSM_REQ_REGEN_OBJECT,
+	TSM_REQ_OBJECT_INFO,
+	TSM_REQ_VALIDATE_MMIO,
+	TSM_REQ_SET_TDI_STATE,
+	TSM_REQ_SEV_ENABLE_DMA,
+	TSM_REQ_SEV_DISABLE_DMA,
 };
=20
 /**
  * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
  * @size: sizeof(struct iommu_vdevice_tsm_req)
  * @vdevice_id: vDevice ID the guest request is for
- * @scope: One of enum iommu_vdevice_tsm_req_scope
+ * @op: One of enum iommu_vdevice_tsm_guest_req_op
+ * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
  * @req_len: Size in bytes of the input payload at @req_uptr
  * @resp_len: Size in bytes of the output buffer at @resp_uptr
- * @__reserved: Must be 0
  * @req_uptr: Userspace pointer to the guest-provided request payload
  * @resp_uptr: Userspace pointer to the guest response buffer
  * @tsm_code: TSM-specific result code returned by the TSM implementation
@@ -1431,9 +1423,9 @@ enum iommu_vdevice_tsm_req_scope {
  * guest TSM/TDISP message transport where the host kernel only marshals
  * bytes between userspace and the TSM implementation.
  *
- * Requests outside the iommufd allocated scope values are rejected. Lower
- * layers may reject scope values that are valid in the global iommufd
- * namespace, but not permitted for a specific bus.
+ * The request operation is guest initiated. Operations that may also be h=
ost
+ * initiated are handled through IOMMU_VDEVICE_TSM_OP instead. The TSM bac=
kend
+ * validates @tvm_arch against its bound TVM architecture assumptions.
  *
  * The request payload is read from @req_uptr/@req_len. If a response is
  * expected, userspace provides @resp_uptr/@resp_len as writable storage f=
or
@@ -1445,10 +1437,10 @@ enum iommu_vdevice_tsm_req_scope {
 struct iommu_vdevice_tsm_req {
 	__u32 size;
 	__u32 vdevice_id;
-	__u32 scope;
+	__u32 op;
+	__u32 tvm_arch;
 	__u32 req_len;
 	__u32 resp_len;
-	__u32 __reserved;
 	__aligned_u64 req_uptr;
 	__aligned_u64 resp_uptr;
 	__aligned_u64 tsm_code;
