Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgGGLN7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:13:59 -0400
Subject: Re: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <862dce70-1aed-ace0-cb7b-54844e812be3@de.ibm.com>
Date: Tue, 7 Jul 2020 13:12:28 +0200
MIME-Version: 1.0
In-Reply-To: <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 07.07.20 10:44, Pierre Morel wrote:
> S390, protecting the guest memory against unauthorized host access
> needs to enforce VIRTIO I/O device protection through the use of
> VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index c296e5c8dbf9..106330f6eda1 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -14,6 +14,7 @@
>  #include <linux/memblock.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> +#include <linux/virtio_config.h>
>  #include <asm/facility.h>
>  #include <asm/sections.h>
>  #include <asm/uv.h>
> @@ -413,3 +414,27 @@ static int __init uv_info_init(void)
>  }
>  device_initcall(uv_info_init);
>  #endif
> +
> +/*
> + * arch_validate_virtio_iommu_platform
> + * @dev: the VIRTIO device being added
> + *
> + * Return value: returns -ENODEV if any features of the
> + *               device breaks the protected virtualization
> + *               0 otherwise.
> + */
> +int arch_validate_virtio_features(struct virtio_device *dev)
> +{
> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");

I think you only want to warn if is_prot_virt_guest is true? We certainly
want to be able to run as a guest of older hypervisors with virtio 0.95, no?


> +		return is_prot_virt_guest() ? -ENODEV : 0;
> +	}
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");

same here. 
> +		return is_prot_virt_guest() ? -ENODEV : 0;
> +	}
> +
> +	return 0;
> +}
> 
