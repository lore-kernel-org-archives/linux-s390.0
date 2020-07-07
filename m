Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32468 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgGGJ1I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 05:27:08 -0400
Date: Tue, 7 Jul 2020 11:26:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/2] virtio: let arch validate VIRTIO features
Message-ID: <20200707112652.42fcab80.cohuck@redhat.com>
In-Reply-To: <1594111477-15401-2-git-send-email-pmorel@linux.ibm.com>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
        <1594111477-15401-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On Tue,  7 Jul 2020 10:44:36 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may need to validate the VIRTIO devices features
> based on architecture specificities.

s/specifities/specifics/

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>  include/linux/virtio_config.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..3179a8aa76f5 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
>  
> +/*
> + * arch_needs_virtio_iommu_platform - provide arch specific hook when finalizing

s/arch_needs_virtio_iommu_platform/arch_validate_virtio_features/

:)

> + *				      features for VIRTIO device dev
> + * @dev: the VIRTIO device being added
> + *
> + * Permits the platform to provide architecture specific functionality when

s/provide architecture specific functionality/handle architecture-specific requirements/

?

> + * devices features are finalized. This is the default implementation.

s/devices/device/

> + * Architecture implementations can override this.
> + */
> +
> +int __weak arch_validate_virtio_features(struct virtio_device *dev)
> +{
> +	return 0;
> +}
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -176,6 +191,10 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = arch_validate_virtio_features(dev);
> +	if (ret)
> +		return ret;
> +
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index bb4cc4910750..3f4117adf311 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -459,4 +459,5 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>  		_r;							\
>  	})
>  
> +int arch_validate_virtio_features(struct virtio_device *dev);
>  #endif /* _LINUX_VIRTIO_CONFIG_H */

With the wording fixed,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
