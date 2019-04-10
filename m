Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 10:42:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 07/12] virtio/s390: use DMA memory for ccw I/O
Message-ID: <20190410104251.38fe7405.cohuck@redhat.com>
In-Reply-To: <20190404231622.52531-8-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-8-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Apr 2019 01:16:17 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Before virtio-ccw could get away with not using DMA API for the pieces of
> memory it does ccw I/O with. With protected virtualization this has to
> change, since the hypervisor needs to read and sometimes also write these
> pieces of memory.
> 
> Let us make sure all ccw I/O is done through shared memory.
> 
> Note: The control blocks of I/O instructions do not need to be shared.
> These are marshalled by the ultravisor.

Ok, so direct parameters of I/O instructions are handled by the
ultravisor?

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 177 +++++++++++++++++++++++----------------
>  1 file changed, 107 insertions(+), 70 deletions(-)
> 
(...)
> @@ -167,6 +170,28 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
>  	return container_of(vdev, struct virtio_ccw_device, vdev);
>  }
>  
> +#define vc_dma_decl_struct(type, field) \
> +	dma_addr_t field ## _dma_addr;  \
> +	struct type *field
> +
> +static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size,
> +				   dma_addr_t *dma_handle)
> +{
> +	return dma_alloc_coherent(vdev->dev.parent, size, dma_handle,
> +				  GFP_DMA | GFP_KERNEL | __GFP_ZERO);
> +}
> +
> +static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
> +				 void *cpu_addr, dma_addr_t dma_handle)
> +{
> +	dma_free_coherent(vdev->dev.parent, size, cpu_addr, dma_handle);
> +}
> +
> +#define vc_dma_alloc_struct(vdev, ptr) \
> +	({ ptr = __vc_dma_alloc(vdev, (sizeof(*(ptr))), &(ptr ## _dma_addr)); })
> +#define vc_dma_free_struct(vdev, ptr) \
> +	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr), (ptr ## _dma_addr))

Not sure I'm a fan of those wrappers... I think they actually hurt
readability of the code.

> +
>  static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
>  {
>  	unsigned long i, flags;
> @@ -322,12 +347,12 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>  {
>  	int ret;
>  	unsigned long *indicatorp = NULL;
> -	struct virtio_thinint_area *thinint_area = NULL;
> +	vc_dma_decl_struct(virtio_thinint_area, thinint_area) = NULL;
> +	dma_addr_t indicatorp_dma_addr;
>  	struct airq_info *airq_info = vcdev->airq_info;
>  
>  	if (vcdev->is_thinint) {
> -		thinint_area = kzalloc(sizeof(*thinint_area),
> -				       GFP_DMA | GFP_KERNEL);
> +		vc_dma_alloc_struct(&vcdev->vdev, thinint_area);
>  		if (!thinint_area)
>  			return;
>  		thinint_area->summary_indicator =
> @@ -338,8 +363,9 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>  		ccw->cda = (__u32)(unsigned long) thinint_area;
>  	} else {
>  		/* payload is the address of the indicators */
> -		indicatorp = kmalloc(sizeof(&vcdev->indicators),
> -				     GFP_DMA | GFP_KERNEL);
> +		indicatorp = __vc_dma_alloc(&vcdev->vdev,
> +					    sizeof(&vcdev->indicators),
> +					    &indicatorp_dma_addr);
>  		if (!indicatorp)
>  			return;
>  		*indicatorp = 0;
> @@ -359,8 +385,10 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>  			 "Failed to deregister indicators (%d)\n", ret);
>  	else if (vcdev->is_thinint)
>  		virtio_ccw_drop_indicators(vcdev);
> -	kfree(indicatorp);
> -	kfree(thinint_area);
> +	if (indicatorp)
> +		__vc_dma_free(&vcdev->vdev, sizeof(&vcdev->indicators),
> +			       indicatorp, indicatorp_dma_addr);
> +	vc_dma_free_struct(&vcdev->vdev, thinint_area);

Don't you need to check for !NULL here as well?

>  }
>  
>  static inline long __do_kvm_notify(struct subchannel_id schid,
(...)
> @@ -1280,7 +1318,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  
>  	vcdev->is_thinint = virtio_ccw_use_airq; /* at least try */
>  
> -	vcdev->vdev.dev.parent = &cdev->dev;

Hm?

(You added a line like that in a previous patch; should it simply have
been a movement instead? Or am I misremembering?)

>  	vcdev->vdev.dev.release = virtio_ccw_release_dev;
>  	vcdev->vdev.config = &virtio_ccw_config_ops;
>  	vcdev->cdev = cdev;
