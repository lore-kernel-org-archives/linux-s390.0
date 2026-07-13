Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9831B3B0AD1;
	Mon, 13 Jul 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948490; cv=none; b=VHvRGwmhj6woZnP/BRIWgJMbI7qVLbb3z5p1hV5GjcOdXhAIh+vt+yuswqkP0oLqetLcUcywyvBdPvtO3yt3ydSgj20zpinWJUizqBj3eL9bMCALy0g5jc3iokCCCDExZ0lR6oNArCPY8sUCuczLukGfiHXVFWD8v3rORoeZVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948490; c=relaxed/simple;
	bh=1yzgUn483sH+JxOQ5FbwdLIpvw9PWIjgLRVy9cHrIRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0f9CiiRatEDAhm8qBi9906eOPZncxsjlCKmrDZENAg+sIFciXXKxyVymqEwfgtFxSbudY6Fu50/hsCkUaZ+sR5mit+VUzUOR2X9TxSVoSJjcyEmOyzXMWekLzua952rtwMOC4kZDZPYrel5fFVq+o54M4x/kJmaqhe9qaAtv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mW3EdGl5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mW3EdGl5"
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id AA8D620B716F; Mon, 13 Jul 2026 06:14:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA8D620B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783948480;
	bh=0uQfzfsLDOyWc28Iub4vqCWbjhL+DS0pz2FwJiRgUvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mW3EdGl5gqw+3GBkXvv3n6dbQnd5J+cNN8+qe1t5nB9LHbcQ4K6MxrpSC8Ps/Dyz/
	 1kqo52e0VmqTO+WN0+i8/FBeDAGT0Fb6Ij5EfuRxt1jERN1SV8XhPwPJmKregZ1dOq
	 SWGeXQuXbQqwhuL1bYKo+fBebudB0ERSBSUe+2MI=
Date: Mon, 13 Jul 2026 06:14:40 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
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
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 2/5] iommufd/device: Associate KVM file pointer with
 iommufd_device
Message-ID: <alTkwFYXH2z6fmfO@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525154816.1029642-3-aneesh.kumar@kernel.org>

On Mon, May 25, 2026 at 09:18:13PM +0530, Aneesh Kumar K.V (Arm) wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> TSM vDevice support needs access to the KVM associated with a VFIO device
> after the device has been bound to iommufd.
> 
> Extend iommufd_device_bind() to accept the device's KVM file and store it
> in the iommufd_device. The KVM file reference is owned by VFIO and is
> already held for the duration of the device open path.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: fix build error in iommufd_test_mock_domain()]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/device.c          | 7 ++++++-
>  drivers/iommu/iommufd/iommufd_private.h | 2 ++
>  drivers/iommu/iommufd/selftest.c        | 2 +-
>  drivers/vfio/iommufd.c                  | 3 ++-
>  include/linux/iommufd.h                 | 4 +++-
>  5 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 170a7005f0bc..718abdc0e627 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -203,6 +203,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   * iommufd_device_bind - Bind a physical device to an iommu fd
>   * @ictx: iommufd file descriptor
>   * @dev: Pointer to a physical device struct
> + * @kvm_file: VM file if device belongs to a KVM VM
>   * @id: Output ID number to return to userspace for this device
>   *
>   * A successful bind establishes an ownership over the device and returns
> @@ -216,7 +217,9 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   * The caller must undo this with iommufd_device_unbind()
>   */
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev,
> +					   struct file *kvm_file,
> +					   u32 *id)
could it be a neutrally-named VM-file handle (e.g. vm_file)?
>  {
>  	struct iommufd_device *idev;
>  	struct iommufd_group *igroup;
> @@ -266,6 +269,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	if (!iommufd_selftest_is_mock_dev(dev))
>  		iommufd_ctx_get(ictx);
>  	idev->dev = dev;
For a non-KVM VMM a registrable "which VM-file type" hook (a 
file_is_mshv_partition() analogue) rather than an implicit "whatever 
VFIO set" contract will be helpful, so the type can be validated where 
it matters.
> +	/* reference is already taken in vfio_df_ioctl_bind_iommufd() */
> +	idev->kvm_file = kvm_file;
>  	idev->enforce_cache_coherency =
>  		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
>  	/* The calling driver is a user until iommufd_device_unbind() */
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..44eb026c206d 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -488,6 +488,8 @@ struct iommufd_device {
>  	struct list_head group_item;
>  	/* always the physical device */
>  	struct device *dev;
> +	/* ..and the VM file if available */
> +	struct file *kvm_file;
>  	bool enforce_cache_coherency;
>  	struct iommufd_vdevice *vdev;
>  	bool destroying;
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index af07c642a526..a193390f9d07 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -1069,7 +1069,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
>  		goto out_sobj;
>  	}
>  
> -	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
> +	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev, NULL,
>  				   &idev_id);
>  	if (IS_ERR(idev)) {
>  		rc = PTR_ERR(idev);
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a38d262c6028..d2d0bd9382a1 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -119,7 +119,8 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
>  {
>  	struct iommufd_device *idev;
>  
> -	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
> +	idev = iommufd_device_bind(ictx, vdev->dev, vdev->kvm_file,
> +				   out_device_id);
>  	if (IS_ERR(idev))
>  		return PTR_ERR(idev);
>  	vdev->iommufd_device = idev;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 6e7efe83bc5d..0a0bb4abfbd2 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -59,7 +59,9 @@ struct iommufd_object {
>  };
>  
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id);
> +					   struct device *dev,
> +					   struct file *kvm_file,
> +					   u32 *id);
>  void iommufd_device_unbind(struct iommufd_device *idev);
>  
>  int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
> -- 
> 2.43.0
> 
