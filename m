Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699C3DD87B;
	Tue, 26 May 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792758; cv=none; b=pZT9kIR3cmttKtnGwd43Qn3jNNbozIUMhOonkqpp0IDFlF8GK4ATRb17FIc7pLRjE5OKnBle+cFjtoSAPgKWauhQiyicNaH0sLFGlr2EYZMdEOj+LhJnh5gEwq7vnwwGLht4P2SqeeJRQC/wa5Za86qDwoLmqjWndlx0be2vP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792758; c=relaxed/simple;
	bh=1B2PpBRms+zDeZ++5vUTuODu64CSCkvh8N+3W7gmNXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW+9xyhUfDW4BV8lmctR9j6XEH2Ilsnq/osRL6vMwT7B4uCG8qPR1gkKIN+zArPABXh7YBA2VPl3TBkbVD8eF6Hm1Fk+e1rLsOAIIk5pliXnfxV2re6h6bs4BbrpKHEDT5TaMXuGuW3rYGYaDIflkIgYSZOkUOWYGZo5yOC3nmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UDojngOX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UDojngOX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PH4IdS2604055;
	Tue, 26 May 2026 10:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kfKJxz
	nRYJwdyHyIJxpk/vIAkXnkav0LywGz6xytoEc=; b=UDojngOXHDfhxB0PKvK9vH
	RfoCMqgAUAlZkOYpYA+Vv4p47UHaHTj2tuFV0HIFNn3QpAteB/d/N83lGZXdBcEP
	Vi3eNjQ5JEv3Aa7s8siE2olXiMaF170OLKP7iE/IVSaQhyyqDPtR2OWyX26HktfF
	w0VaXzCnfJax5SXjnbivjyUylbMAueFuF79okNOJVVPrvNSbtVK2WapoQyAqq1TG
	lqskfllYAY54gMWp5v5zsOTugPg46o6GcmO9Pg9rJQalzfbPvVGEkhNj4b4m/B6Z
	aq8AJV7lXFwYS0rv2Jp3+1eQjvdsC2DFIEzoE/clGG+M18ffwFnOfhArgDXUk75A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nukq14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:52:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QAdBlm013911;
	Tue, 26 May 2026 10:52:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebpjq9432-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:52:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QAq9Gl21496548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 10:52:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8B3B5805C;
	Tue, 26 May 2026 10:52:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A84A58051;
	Tue, 26 May 2026 10:52:06 +0000 (GMT)
Received: from [9.61.173.49] (unknown [9.61.173.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 10:52:06 +0000 (GMT)
Message-ID: <12c55949-73f2-4ee3-b960-955335f4308f@linux.ibm.com>
Date: Tue, 26 May 2026 06:52:05 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] vfio: cache KVM VM file references instead of raw
 struct kvm pointers
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
        linux-coco@lists.linux.dev, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-2-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260525154816.1029642-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MiBTYWx0ZWRfX7o/qVmOEQt69
 ZXpN6vbPCBTHtw7cqaxPptgCIIQ6TpsJWNopZHwccljlmumOsfuTNWZwK7YpDtomngaN6Yr4/0b
 hGzJ5n8sW5Ak7nYU8imQnqwsxXGxDQ5b7TAaRvnDwzFXzjkL5higGMo36uoxoIvzIOWt9ZZJUQc
 WwBNR/icISvVRMOuAORYWc8Mzb4MrMudZ4TXKuK4ptg7v49Cg7zuuAMVEZImz+3kCmd+/iQCr6v
 gWt8jhzEfwUX3BMrtaNy3Cd50G6P+Sj0881J2bswHAWEIc1KUD/CxhR4yxQBXK1tDq3g4TYQyKr
 aqca1BuZteb9j5Ri3QJq51sQ+QszJLlbbPfrcB+m8vwXIPT/P76XHEAmdIpp7o3TyUjSaElj3a8
 0302eL1SFIT0FvzSiE45e8NJsx1GG4+n2ealJD3qp7yOCzlUrQMx1ePTTPH5Xydv4jyW9ZBjBR5
 O8udXtHRTvofVBCtSHw==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a157b5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xQhe5w7CTnWIMBQ0vvEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2SGcXYzw01ErDbjc3oPAqUby1r2sOgK4
X-Proofpoint-GUID: 2SGcXYzw01ErDbjc3oPAqUby1r2sOgK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260092



On 5/25/26 11:48 AM, Aneesh Kumar K.V (Arm) wrote:
> VFIO currently records struct kvm pointers on vfio_group, vfio_device_file
> and the opened vfio_device. Switch VFIO to track the VM's struct file
> instead, so VFIO and iommufd can use normal file references for VM lifetime
> instead of depending on KVM's internal struct kvm refcounting.
>
> KVM_CREATE_DEVICE binds the KVM VM lifetime to the KVM device fd lifetime.
> For KVM_DEV_TYPE_VFIO, the KVM VFIO device fd also takes references to each
> VFIO file added through KVM_DEV_VFIO_FILE_ADD. The KVM VFIO device fd
> therefore owns both the internal KVM reference and the VFIO file references
> in kvf->file.
>
> KVM_DEV_VFIO_FILE_ADD further installs the VM file association into the
> VFIO file. VFIO converts the struct kvm pointer to a VM file reference with
> get_file_active(&kvm->_file), because the KVM device fd can keep struct kvm
> alive after the original VM fd is already in final release.
>
> The association intentionally pins the VM file until KVM_DEV_VFIO_FILE_DEL
> or until the KVM VFIO device fd is released. This gives VFIO/iommufd a
> stable VM file reference source without taking a dependency on KVM's struct
> kvm lifetime. The KVM VFIO device release path clears the VFIO-side
> association before dropping its VFIO file references.
>
> When a VFIO device is opened or bound, VFIO takes an additional reference
> from the associated VM file and stores it in vfio_device::kvm_file for
> driver and iommufd use. That open-time reference is released from
> vfio_device_put_kvm() when the VFIO device is closed or unbound.
>
> This gives the ownership model:
>
>    - KVM device fd pins struct kvm through kvm->users_count
>    - KVM VFIO device fd pins VFIO files through kvf->file
>    - VFIO group/device-file state pins the VM file while associated with KVM
>    - vfio_device::kvm_file pins the VM file during active VFIO device use
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Acked-by: Anthony Krowiak <akrowiak@linxux.ibm.com>

> ---
>   drivers/s390/crypto/vfio_ap_ops.c |  5 +-
>   drivers/vfio/device_cdev.c        | 10 ++--
>   drivers/vfio/group.c              | 14 +++---
>   drivers/vfio/pci/vfio_pci_zdev.c  |  7 +--
>   drivers/vfio/vfio.h               | 16 ++++--
>   drivers/vfio/vfio_main.c          | 81 ++++++++++++++++---------------
>   include/linux/kvm_host.h          |  3 ++
>   include/linux/vfio.h              | 17 ++++++-
>   virt/kvm/kvm_main.c               |  2 +
>   9 files changed, 91 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 44b3a1dcc1b3..05996a8fd860 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2054,11 +2054,12 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
>   {
>   	struct ap_matrix_mdev *matrix_mdev =
>   		container_of(vdev, struct ap_matrix_mdev, vdev);
> +	struct kvm *kvm = vfio_device_get_kvm(vdev);
>   
> -	if (!vdev->kvm)
> +	if (!kvm)
>   		return -EINVAL;
>   
> -	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
> +	return vfio_ap_mdev_set_kvm(matrix_mdev, kvm);
>   }
>   
>   static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf04..ca75ab8eb7bd 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -56,7 +56,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>   static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
>   {
>   	spin_lock(&df->kvm_ref_lock);
> -	vfio_device_get_kvm_safe(df->device, df->kvm);
> +	vfio_device_get_kvm_safe(df->device, df->kvm_file);
>   	spin_unlock(&df->kvm_ref_lock);
>   }
>   
> @@ -133,10 +133,10 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>   	}
>   
>   	/*
> -	 * Before the device open, get the KVM pointer currently
> -	 * associated with the device file (if there is) and obtain
> -	 * a reference.  This reference is held until device closed.
> -	 * Save the pointer in the device for use by drivers.
> +	 * Before the device open, get the VM struct file currently
> +	 * associated with the device file (if there is one) and obtain a
> +	 * reference. This reference is held until the device is closed.
> +	 * Save the file in the device for use by drivers.
>   	 */
>   	vfio_df_get_kvm_safe(df);
>   
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index b2299e5bc6df..8950cfb9405d 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -163,7 +163,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>   static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
>   {
>   	spin_lock(&device->group->kvm_ref_lock);
> -	vfio_device_get_kvm_safe(device, device->group->kvm);
> +	vfio_device_get_kvm_safe(device, device->group->kvm_file);
>   	spin_unlock(&device->group->kvm_ref_lock);
>   }
>   
> @@ -181,10 +181,10 @@ static int vfio_df_group_open(struct vfio_device_file *df)
>   	mutex_lock(&device->dev_set->lock);
>   
>   	/*
> -	 * Before the first device open, get the KVM pointer currently
> -	 * associated with the group (if there is one) and obtain a reference
> -	 * now that will be held until the open_count reaches 0 again.  Save
> -	 * the pointer in the device for use by drivers.
> +	 * Before the first device open, get the VM struct file currently
> +	 * associated with the group (if there is one) and obtain a
> +	 * reference now that will be held until the open_count reaches 0
> +	 * again. Save the file in the device for use by drivers.
>   	 */
>   	if (device->open_count == 0)
>   		vfio_device_group_get_kvm_safe(device);
> @@ -862,9 +862,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
>   
>   void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
>   {
> -	spin_lock(&group->kvm_ref_lock);
> -	group->kvm = kvm;
> -	spin_unlock(&group->kvm_ref_lock);
> +	vfio_kvm_file_replace(&group->kvm_file, &group->kvm_ref_lock, kvm);
>   }
>   
>   /**
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0990fdb146b7..a9d8e6aa3839 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -144,15 +144,16 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>   {
>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	struct kvm *kvm = vfio_device_get_kvm(&vdev->vdev);
>   
>   	if (!zdev)
>   		return -ENODEV;
>   
> -	if (!vdev->vdev.kvm)
> +	if (!kvm)
>   		return 0;
>   
>   	if (zpci_kvm_hook.kvm_register)
> -		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
> +		return zpci_kvm_hook.kvm_register(zdev, kvm);
>   
>   	return -ENOENT;
>   }
> @@ -161,7 +162,7 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>   {
>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>   
> -	if (!zdev || !vdev->vdev.kvm)
> +	if (!zdev || !vfio_device_get_kvm(&vdev->vdev))
>   		return;
>   
>   	if (zpci_kvm_hook.kvm_unregister)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e4b72e79b7e3..41032104eb36 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -22,8 +22,8 @@ struct vfio_device_file {
>   
>   	u8 access_granted;
>   	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
> +	struct file *kvm_file;
>   	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>   };
>   
> @@ -88,7 +88,7 @@ struct vfio_group {
>   #endif
>   	enum vfio_group_type		type;
>   	struct mutex			group_lock;
> -	struct kvm			*kvm;
> +	struct file			*kvm_file;
>   	struct file			*opened_file;
>   	struct iommufd_ctx		*iommufd;
>   	spinlock_t			kvm_ref_lock;
> @@ -434,11 +434,17 @@ static inline void vfio_virqfd_exit(void)
>   #endif
>   
>   #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
> +void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm *kvm);
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm_file);
>   void vfio_device_put_kvm(struct vfio_device *device);
>   #else
> +static inline void vfio_kvm_file_replace(struct file **dst,
> +		spinlock_t *lock, struct kvm *kvm)
> +{
> +}
> +
>   static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
> -					    struct kvm *kvm)
> +					    struct file *kvm_file)
>   {
>   }
>   
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab..88c85a7b98c0 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -442,55 +442,61 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>   EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>   
>   #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
> +void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm *kvm)
>   {
> -	void (*pfn)(struct kvm *kvm);
> -	bool (*fn)(struct kvm *kvm);
> -	bool ret;
> +	struct file *old_kvm_file, *new_kvm_file = NULL;
>   
> -	lockdep_assert_held(&device->dev_set->lock);
> +	/*
> +	 * @kvm can outlive the VM fd and its final __fput(). Only take a
> +	 * new reference if the VM file is still active.
> +	 */
> +	if (kvm)
> +		new_kvm_file = get_file_active(&kvm->_file);
>   
> -	if (!kvm)
> -		return;
> +	spin_lock(lock);
> +	old_kvm_file = *dst;
> +	*dst = new_kvm_file;
> +	spin_unlock(lock);
>   
> -	pfn = symbol_get(kvm_put_kvm);
> -	if (WARN_ON(!pfn))
> -		return;
> +	if (old_kvm_file)
> +		fput(old_kvm_file);
> +}
>   
> -	fn = symbol_get(kvm_get_kvm_safe);
> -	if (WARN_ON(!fn)) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm_file)
> +{
> +	lockdep_assert_held(&device->dev_set->lock);
>   
> -	ret = fn(kvm);
> -	symbol_put(kvm_get_kvm_safe);
> -	if (!ret) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> +	/*
> +	 * Take a VM file reference if the KVM fd is still active.
> +	 */
> +	if (kvm_file)
> +		kvm_file = get_file(kvm_file);
>   
> -	device->put_kvm = pfn;
> -	device->kvm = kvm;
> +	device->kvm_file = kvm_file;
>   }
>   
>   void vfio_device_put_kvm(struct vfio_device *device)
>   {
> +	struct file *kvm_file;
> +
>   	lockdep_assert_held(&device->dev_set->lock);
>   
> -	if (!device->kvm)
> +	kvm_file = device->kvm_file;
> +	if (!kvm_file)
>   		return;
>   
> -	if (WARN_ON(!device->put_kvm))
> -		goto clear;
> +	device->kvm_file = NULL;
> +	fput(kvm_file);
> +}
>   
> -	device->put_kvm(device->kvm);
> -	device->put_kvm = NULL;
> -	symbol_put(kvm_put_kvm);
> +struct kvm *vfio_device_get_kvm(struct vfio_device *device)
> +{
> +	if (!device->kvm_file)
> +		return NULL;
>   
> -clear:
> -	device->kvm = NULL;
> +	return device->kvm_file->private_data;
>   }
> +EXPORT_SYMBOL_GPL(vfio_device_get_kvm);
>   #endif
>   
>   /* true if the vfio_device has open_device() called but not close_device() */
> @@ -1518,13 +1524,10 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
>   	struct vfio_device_file *df = file->private_data;
>   
>   	/*
> -	 * The kvm is first recorded in the vfio_device_file, and will
> -	 * be propagated to vfio_device::kvm when the file is bound to
> -	 * iommufd successfully in the vfio device cdev path.
> +	 * Cache the VM file reference associated with this VFIO file so it
> +	 * can be pinned into vfio_device while the device is open.
>   	 */
> -	spin_lock(&df->kvm_ref_lock);
> -	df->kvm = kvm;
> -	spin_unlock(&df->kvm_ref_lock);
> +	vfio_kvm_file_replace(&df->kvm_file, &df->kvm_ref_lock, kvm);
>   }
>   
>   /**
> @@ -1532,8 +1535,8 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
>    * @file: VFIO group file or VFIO device file
>    * @kvm: KVM to link
>    *
> - * When a VFIO device is first opened the KVM will be available in
> - * device->kvm if one was associated with the file.
> + * When a VFIO device is first opened, VFIO caches a VM file reference if
> + * one was associated with the file.
>    */
>   void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>   {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4c14aee1fb06..31afac5fb0ea 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -45,6 +45,8 @@
>   #include <asm/kvm_host.h>
>   #include <linux/kvm_dirty_ring.h>
>   
> +struct file;
> +
>   #ifndef KVM_MAX_VCPU_IDS
>   #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
>   #endif
> @@ -861,6 +863,7 @@ struct kvm {
>   	struct srcu_struct srcu;
>   	struct srcu_struct irq_srcu;
>   	pid_t userspace_pid;
> +	struct file __rcu *_file;
>   	bool override_halt_poll_ns;
>   	unsigned int max_halt_poll_ns;
>   	u32 dirty_ring_size;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 31b826efba00..bca1d00f7845 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -22,8 +22,22 @@ struct kvm;
>   struct iommufd_ctx;
>   struct iommufd_device;
>   struct iommufd_access;
> +struct vfio_device;
>   struct vfio_info_cap;
>   
> +#if IS_ENABLED(CONFIG_KVM)
> +/*
> + * Return the KVM associated with @vdev's kvm_file. The returned pointer
> + * is valid only while VFIO device open holds the kvm_file reference.
> + */
> +struct kvm *vfio_device_get_kvm(struct vfio_device *vdev);
> +#else
> +static inline struct kvm *vfio_device_get_kvm(struct vfio_device *vdev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>   /*
>    * VFIO devices can be placed in a set, this allows all devices to share this
>    * structure and the VFIO core will provide a lock that is held around
> @@ -54,7 +68,7 @@ struct vfio_device {
>   	struct list_head dev_set_list;
>   	unsigned int migration_flags;
>   	u8 precopy_info_v2;
> -	struct kvm *kvm;
> +	struct file *kvm_file;
>   
>   	/* Members below here are private, not for driver use */
>   	unsigned int index;
> @@ -66,7 +80,6 @@ struct vfio_device {
>   	unsigned int open_count;
>   	struct completion comp;
>   	struct iommufd_access *iommufd_access;
> -	void (*put_kvm)(struct kvm *kvm);
>   	struct inode *inode;
>   #if IS_ENABLED(CONFIG_IOMMUFD)
>   	struct iommufd_device *iommufd_device;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..011819c5c47c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1351,6 +1351,7 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>   
>   	kvm_irqfd_release(kvm);
>   
> +	RCU_INIT_POINTER(kvm->_file, NULL);
>   	kvm_put_kvm(kvm);
>   	return 0;
>   }
> @@ -5500,6 +5501,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
>   		r = PTR_ERR(file);
>   		goto put_kvm;
>   	}
> +	rcu_assign_pointer(kvm->_file, file);
>   
>   	/*
>   	 * Don't call kvm_put_kvm anymore at this point; file->f_op is

