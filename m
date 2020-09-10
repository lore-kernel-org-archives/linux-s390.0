Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729449AbgIJJJH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 05:09:07 -0400
Subject: Re: [PATCH v12 1/2] virtio: let arch advertise guest's memory access
 restrictions
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
 <1599728030-17085-2-git-send-email-pmorel@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <bf1da509-be1a-5576-3859-f7e617422ddd@de.ibm.com>
Date: Thu, 10 Sep 2020 11:08:51 +0200
MIME-Version: 1.0
In-Reply-To: <1599728030-17085-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10.09.20 10:53, Pierre Morel wrote:
> An architecture may restrict host access to guest memory,
> e.g. IBM s390 Secure Execution or AMD SEV.
> 
> Provide a new Kconfig entry the architecture can select,
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
> the arch_has_restricted_virtio_memory_access callback to advertise
> to VIRTIO common code when the architecture restricts memory access
> from the host.
> 
> The common code can then fail the probe for any device where
> VIRTIO_F_ACCESS_PLATFORM is required, but not set.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       | 15 +++++++++++++++
>  include/linux/virtio_config.h | 10 ++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5c92e4a50882..ef2d49430800 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,6 +6,12 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected if the architecture may need to enforce
> +	  VIRTIO_F_ACCESS_PLATFORM
> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..a2b3f12e10a2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -176,6 +176,21 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = arch_has_restricted_virtio_memory_access();
> +	if (ret) {
> +		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +			dev_warn(&dev->dev,
> +				 "device must provide VIRTIO_F_VERSION_1\n");
> +			return -ENODEV;
> +		}
> +
> +		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
> +			dev_warn(&dev->dev,
> +				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8fe857e27ef3..3f697c8c8205 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -540,4 +540,14 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>  			virtio_cread_le((vdev), structname, member, ptr); \
>  		_r;							\
>  	})
> +
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +int arch_has_restricted_virtio_memory_access(void);
> +#else
> +static inline int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
> +
>  #endif /* _LINUX_VIRTIO_CONFIG_H */
> 
