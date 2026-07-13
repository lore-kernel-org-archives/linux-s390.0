Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE7421F07;
	Mon, 13 Jul 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948722; cv=none; b=k57+oBrTP/d9g8miB98pCdQ+KM30oTCOD9Kzgzn2p5Ee3mG9DOAN1fOjETl7TGMsO4HPRvgnAd4Fx5o0vsY3/yHfE4Z3JmD+SzNlXRSvAODHZFjicRXZkqTPXeGWWRVT4W6i6uAKoaXnq67ptOh6X9vxwqtXDwmlXfVzh1Xka+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948722; c=relaxed/simple;
	bh=X9JRMSq1AMWvjWaU/HGkgYRxUCf0PIuQXmQX73UbfF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt7ru6jHJ2tS/V3unUyHBYBq1ZqCD/D+AVGFydAByVTzOR6o/HrtEBUjd/yOuOvXSSFF1eXb/5BnbNqHNIxIS8RnW4odDwCIdOSJvVwYi+2QrGEP6v9TJUtNVPayDegtxbFyj/pX0Tl8lqGg3NpwFQIU+l+SHEuv35Orbf2hJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pcHJtExY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pcHJtExY"
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 1738A20B716F; Mon, 13 Jul 2026 06:18:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1738A20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783948713;
	bh=xzr7uwbpfq4Gc6YZ72X+EEXOl8FzzS0PqiMEC/4obio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcHJtExYZf1Q4pdqSyvxTTGs8q5fNrCxH32ERLjsxcgUCidFKCmTVT3d1Mmo7JyUV
	 GzGkKFje4QLUvII4Kvq2+hNmppSMEbGx98kKQPiegCYik9ScAl4NgjDifDgkkT32jG
	 4+4tC8g4nF+VmekXQbYu3lTc394lMmuwURLhU/4Q=
Date: Mon, 13 Jul 2026 06:18:33 -0700
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
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iommufd/viommu: Keep a reference to the KVM file
Message-ID: <alTlqRcSpzhW7rZv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525154816.1029642-4-aneesh.kumar@kernel.org>

On Mon, May 25, 2026 at 09:18:14PM +0530, Aneesh Kumar K.V (Arm) wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
> vIOMMU is allocated, and take a file reference so it remains valid for the
> lifetime of the vIOMMU.
> 
> Release the reference when the vIOMMU is destroyed.
> 
> Based on an original patch by Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 5 +++++
>  include/linux/iommufd.h        | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 4081deda9b33..bf5d58d55939 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>   */
> +#include <linux/file.h>
>  #include "iommufd_private.h"
>  
>  void iommufd_viommu_destroy(struct iommufd_object *obj)
> @@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>  	if (viommu->ops && viommu->ops->destroy)
>  		viommu->ops->destroy(viommu);
>  	refcount_dec(&viommu->hwpt->common.obj.users);
> +	if (viommu->kvm_file)
> +		fput(viommu->kvm_file);
>  	xa_destroy(&viommu->vdevs);
>  }
>  
> @@ -76,6 +79,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	}
>  
>  	xa_init(&viommu->vdevs);
> +	if (idev->kvm_file)
> +		viommu->kvm_file = get_file(idev->kvm_file);
There is now no uapi path at all for a non-KVM VMM to associate its VM
with a viommu. Can we (re)introduce an explicit, neutral
association, that accepts a KVM fd or another VMM's VM fd, in addition
to the implicit VFIO path?
>  	viommu->type = cmd->type;
>  	viommu->ictx = ucmd->ictx;
>  	viommu->hwpt = hwpt_paging;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 0a0bb4abfbd2..3267717f676d 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -103,6 +103,7 @@ struct iommufd_viommu {
>  	struct iommufd_ctx *ictx;
>  	struct iommu_device *iommu_dev;
>  	struct iommufd_hwpt_paging *hwpt;
> +	struct file *kvm_file;
>  
>  	const struct iommufd_viommu_ops *ops;
>  
> -- 
> 2.43.0
> 
