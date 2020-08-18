Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728571AbgHRRTZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:25 -0400
Date: Tue, 18 Aug 2020 19:19:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 1/2] virtio: let arch validate VIRTIO features
Message-ID: <20200818191910.1fc300f2.cohuck@redhat.com>
In-Reply-To: <1597762711-3550-2-git-send-email-pmorel@linux.ibm.com>
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
        <1597762711-3550-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 18 Aug 2020 16:58:30 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may need to validate the VIRTIO devices features
> based on architecture specifics.
> 
> Provide a new Kconfig entry, CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS,
> the architecture can select when it provides a callback named
> arch_has_restricted_memory_access to validate the virtio device
> features.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/virtio/Kconfig        | 6 ++++++
>  drivers/virtio/virtio.c       | 4 ++++
>  include/linux/virtio_config.h | 9 +++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..eef09e3c92f9 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,6 +6,12 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> +config ARCH_HAS_RESTRICTED_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected by any architecture enforcing
> +	  VIRTIO_F_IOMMU_PLATFORM

This option is only for a very specific case of "restricted memory
access", namely the kind that requires IOMMU_PLATFORM for virtio
devices. ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS? Or is this intended
to cover cases outside of virtio as well?

> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..1471db7d6510 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -176,6 +176,10 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = arch_has_restricted_memory_access(dev);
> +	if (ret)
> +		return ret;

Hm, I'd rather have expected something like

if (arch_has_restricted_memory_access(dev)) {
	// enforce VERSION_1 and IOMMU_PLATFORM
}

Otherwise, you're duplicating the checks in the individual architecture
callbacks again.

[Not sure whether the device argument would be needed here; are there
architectures where we'd only require IOMMU_PLATFORM for a subset of
virtio devices?]

> +
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index bb4cc4910750..f6b82541c497 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -459,4 +459,13 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>  		_r;							\
>  	})
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS
> +int arch_has_restricted_memory_access(struct virtio_device *dev);
> +#else
> +static inline int arch_has_restricted_memory_access(struct virtio_device *dev)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS */
> +
>  #endif /* _LINUX_VIRTIO_CONFIG_H */
