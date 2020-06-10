Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729275AbgFJNYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Jun 2020 09:24:43 -0400
Date: Wed, 10 Jun 2020 15:24:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
Message-ID: <20200610152431.358fded7.cohuck@redhat.com>
In-Reply-To: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

On Wed, 10 Jun 2020 15:11:51 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Protected Virtualisation protects the memory of the guest and
> do not allow a the host to access all of its memory.
> 
> Let's refuse a VIRTIO device which does not use IOMMU
> protected access.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 5730572b52cd..06ffbc96587a 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -986,6 +986,11 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>  	if (!ccw)
>  		return;
>  
> +	/* Protected Virtualisation guest needs IOMMU */
> +	if (is_prot_virt_guest() &&
> +	    !__virtio_test_bit(vdev, VIRTIO_F_IOMMU_PLATFORM))
> +			status &= ~VIRTIO_CONFIG_S_FEATURES_OK;
> +

set_status seems like an odd place to look at features; shouldn't that
rather be done in finalize_features?

>  	/* Write the status to the host. */
>  	vcdev->dma_area->status = status;
>  	ccw->cmd_code = CCW_CMD_WRITE_STATUS;
