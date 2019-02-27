From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 4/7] vfio: ap: register IOMMU VFIO notifier
Date: Wed, 27 Feb 2019 10:42:42 +0100
Message-ID: <20190227104242.1214d55e.cohuck@redhat.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Feb 2019 16:29:57 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> To be able to use the VFIO interface to facilitate the
> mediated device memory pining/unpining we need to register

s/pining/pinning/ (unless it's pining for the fjords :)

> a notifier for IOMMU.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 53 ++++++++++++++++++++++++++++++++---
>  drivers/s390/crypto/vfio_ap_private.h |  2 ++
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 172d6eb..1b5130a 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -748,6 +748,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>  };
>  
>  /**
> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
> + *
> + * @nb: The notifier block
> + * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)

I'd drop this annotation; you only do something for UNMAP but nothing
prevents the caller from passing in something else :)

> + * @data: the specific unmap structure for vfio_iommu_type1

"data associated with the request" ?

(same reasoning as above)

> + *
> + * Unpins the guest IOVA. (The NIB guest address we pinned before).
> + * Return NOTIFY_OK after unpining on a UNMAP request.
> + * otherwise, returns NOTIFY_DONE .

"For an UNMAP request, unpin the guest IOVA (the NIB guest address we
pinned before). Other requests are ignored."

?

> + */

Looks sane to me.

With comments changed,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
