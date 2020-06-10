Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbgFJRYp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Jun 2020 13:24:45 -0400
Date: Wed, 10 Jun 2020 19:24:22 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
Message-ID: <20200610192422.1cefb642.pasic@linux.ibm.com>
In-Reply-To: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

On Wed, 10 Jun 2020 15:11:51 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Protected Virtualisation protects the memory of the guest and
> do not allow a the host to access all of its memory.
> 
> Let's refuse a VIRTIO device which does not use IOMMU
> protected access.
> 

Should we ever get a virtio-ccw device implemented in hardware, we could
in theory have a trusted device, i.e. one that is not affected by the
memory protection.

IMHO this restriction applies to paravitualized devices, that is devices
realized by the hypervisor. In that sense this is not about ccw, but
could in the future affect PCI as well. Thus the transport code may not
be the best place to fence this, but frankly looking at how the QEMU
discussion is going (the one where I try to prevent this condition) I
would be glad to have something like this as a safety net.

I would however like the commit message to reflect what is written above.

Do we need backports (and cc-stable) for this? Connie what do you think?

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

If you were to add && !__virtio_test_bit(vdev, VIRTIO_F_ORDER_PLATFORM)
we could confine this check and the bail out to paravirtualized devices,
because a device realized in HW is expected to give us both
F_ACCESS_PLATFORM and F_ORDER_PLATFORM. I would not bet it will
ever matter for virtio-ccw though.

Connie, do you have an opinion on this?

Regards,
Halil

> +			status &= ~VIRTIO_CONFIG_S_FEATURES_OK;
> +
>  	/* Write the status to the host. */
>  	vcdev->dma_area->status = status;
>  	ccw->cmd_code = CCW_CMD_WRITE_STATUS;
