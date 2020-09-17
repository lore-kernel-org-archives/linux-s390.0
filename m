Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbgIQOXD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Sep 2020 10:23:03 -0400
Date: Thu, 17 Sep 2020 16:22:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 06/16] s390/vfio-ap: introduce shadow APCB
Message-ID: <20200917162242.1941772a.cohuck@redhat.com>
In-Reply-To: <20200821195616.13554-7-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-7-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:06 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The APCB is a field within the CRYCB that provides the AP configuration
> to a KVM guest. Let's introduce a shadow copy of the KVM guest's APCB and
> maintain it for the lifespan of the guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 32 ++++++++++++++++++++++-----
>  drivers/s390/crypto/vfio_ap_private.h |  2 ++
>  2 files changed, 29 insertions(+), 5 deletions(-)

(...)

> @@ -1202,13 +1223,12 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	if (ret)
>  		return NOTIFY_DONE;
>  
> -	/* If there is no CRYCB pointer, then we can't copy the masks */
> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
>  		return NOTIFY_DONE;
>  
> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> -				  matrix_mdev->matrix.aqm,
> -				  matrix_mdev->matrix.adm);
> +	memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
> +	       sizeof(matrix_mdev->shadow_apcb));
> +	vfio_ap_mdev_commit_crycb(matrix_mdev);

We are sure that the shadow APCB always matches up as we are the only
ones manipulating the APCB in the CRYCB, right?

>  
>  	return NOTIFY_OK;
>  }
