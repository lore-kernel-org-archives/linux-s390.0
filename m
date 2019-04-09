Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 11:57:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 02/12] virtio/s390: DMA support for virtio-ccw
Message-ID: <20190409115743.26e51b81.cohuck@redhat.com>
In-Reply-To: <20190404231622.52531-3-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-3-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Apr 2019 01:16:12 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Currently we have a problem if a virtio-ccw device has
> VIRTIO_F_IOMMU_PLATFORM. 

Can you please describe what the actual problem is?

> In future we do want to support DMA API with
> virtio-ccw.
> 
> Let us do the plumbing, so the feature VIRTIO_F_IOMMU_PLATFORM works
> with virtio-ccw.
> 
> Let us also switch from legacy avail/used accessors to the DMA aware
> ones (even if it isn't strictly necessary).

I think with this change we can remove the legacy accessors, if I
didn't mis-grep.

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index edf4afe2d688..5956c9e820bb 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -66,6 +66,7 @@ struct virtio_ccw_device {
>  	bool device_lost;
>  	unsigned int config_ready;
>  	void *airq_info;
> +	__u64 dma_mask;

u64?

>  };
>  
>  struct vq_info_block_legacy {
> @@ -536,8 +537,8 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  		info->info_block->s.desc = queue;
>  		info->info_block->s.index = i;
>  		info->info_block->s.num = info->num;
> -		info->info_block->s.avail = (__u64)virtqueue_get_avail(vq);
> -		info->info_block->s.used = (__u64)virtqueue_get_used(vq);
> +		info->info_block->s.avail = (__u64)virtqueue_get_avail_addr(vq);
> +		info->info_block->s.used = (__u64)virtqueue_get_used_addr(vq);
>  		ccw->count = sizeof(info->info_block->s);
>  	}
>  	ccw->cmd_code = CCW_CMD_SET_VQ;
> @@ -769,10 +770,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>  static void ccw_transport_features(struct virtio_device *vdev)
>  {
>  	/*
> -	 * Packed ring isn't enabled on virtio_ccw for now,
> -	 * because virtio_ccw uses some legacy accessors,
> -	 * e.g. virtqueue_get_avail() and virtqueue_get_used()
> -	 * which aren't available in packed ring currently.
> +	 * There shouldn't be anything that precludes supporting paced.

s/paced/packed/

> +	 * TODO: Remove the limitation after having another look into this.
>  	 */
>  	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
>  }
> @@ -1255,6 +1254,18 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  		ret = -ENOMEM;
>  		goto out_free;
>  	}
> +	vcdev->vdev.dev.parent = &cdev->dev;

That one makes sense, pci and mmio are doing that as well.

> +	cdev->dev.dma_mask = &vcdev->dma_mask;

That one feels a bit weird. Will this change in one of the follow-on
patches? (Have not yet looked at the whole series.)

> +
> +	ret = dma_set_mask_and_coherent(&cdev->dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		ret = dma_set_mask_and_coherent(&cdev->dev,
> +						DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_warn(&cdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");

This does not look like you'd try to continue?

> +		goto out_free;
> +	}
> +
>  	vcdev->config_block = kzalloc(sizeof(*vcdev->config_block),
>  				   GFP_DMA | GFP_KERNEL);
>  	if (!vcdev->config_block) {
