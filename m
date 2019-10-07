Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbfJGSEs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Oct 2019 14:04:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x97I2hf6144024
        for <linux-s390@vger.kernel.org>; Mon, 7 Oct 2019 14:04:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg9gr9td3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 07 Oct 2019 14:04:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 7 Oct 2019 19:04:44 +0100
Subject: Re: [PATCH v2 1/1] s390/cio: fix virtio-ccw DMA without PV
References: <20190930153803.7958-1-pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 7 Oct 2019 20:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190930153803.7958-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fee4157e-7dd3-e003-fbdf-5aa013147dde@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>



On 30.09.19 17:38, Halil Pasic wrote:
> Commit 37db8985b211 ("s390/cio: add basic protected virtualization
> support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
> Protected Virtualization (PV) guests. The problem is that the dma_mask
> of the ccw device, which is used by virtio core, gets changed from 64 to
> 31 bit, because some of the DMA allocations do require 31 bit
> addressable memory. For PV the only drawback is that some of the virtio
> structures must end up in ZONE_DMA because we have the bounce the
> buffers mapped via DMA API anyway.
> 
> But for non PV guests we have a problem: because of the 31 bit mask
> guests bigger than 2G are likely to try bouncing buffers. The swiotlb
> however is only initialized for PV guests, because we don't want to
> bounce anything for non PV guests. The first such map kills the guest.
> 
> Since the DMA API won't allow us to specify for each allocation whether
> we need memory from ZONE_DMA (31 bit addressable) or any DMA capable
> memory will do, let us use coherent_dma_mask (which is used for
> allocations) to force allocating form ZONE_DMA while changing dma_mask
> to DMA_BIT_MASK(64) so that at least the streaming API will regard
> the whole memory DMA capable.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")

Thanks applied to the s390 tree. (pending some regression tests)


> ---
> 
> v1 --> v2:
> * Fixed comment: dropped the sentence with workaround.
> 
> The idea of enabling the client code to specify on s390 whether a chunk
> of allocated DMA memory is to be allocated form ZONE_DMA for each
> allocation was not well received [1]. 
> 
> Making the streaming API threat all addresses as DMA capable, while
> restricting the DMA API allocations to  ZONE_DMA (regardless of needed
> or not) is the next best thing we can do (from s390 perspective).
> 
> [1] https://lkml.org/lkml/2019/9/23/531 
> ---
> ---
>  drivers/s390/cio/cio.h    | 1 +
>  drivers/s390/cio/css.c    | 7 ++++++-
>  drivers/s390/cio/device.c | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
> index ba7d2480613b..dcdaba689b20 100644
> --- a/drivers/s390/cio/cio.h
> +++ b/drivers/s390/cio/cio.h
> @@ -113,6 +113,7 @@ struct subchannel {
>  	enum sch_todo todo;
>  	struct work_struct todo_work;
>  	struct schib_config config;
> +	u64 dma_mask;
>  	char *driver_override; /* Driver name to force a match */
>  } __attribute__ ((aligned(8)));
>  
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index 22c55816100b..a05dbf2e97db 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -232,7 +232,12 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>  	 * belong to a subchannel need to fit 31 bit width (e.g. ccw).
>  	 */
>  	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
> -	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
> +	/*
> +	 * But we don't have such restrictions imposed on the stuff that
> +	 * is handled by the streaming API.
> +	 */
> +	sch->dma_mask = DMA_BIT_MASK(64);
> +	sch->dev.dma_mask = &sch->dma_mask;
>  	return sch;
>  
>  err:
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 131430bd48d9..0c6245fc7706 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -710,7 +710,7 @@ static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
>  	if (!cdev->private)
>  		goto err_priv;
>  	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
> -	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
> +	cdev->dev.dma_mask = sch->dev.dma_mask;
>  	dma_pool = cio_gp_dma_create(&cdev->dev, 1);
>  	if (!dma_pool)
>  		goto err_dma_pool;
> 
