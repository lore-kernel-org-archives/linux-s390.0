Return-Path: <SRS0=nFot=SK=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 8 Apr 2019 13:01:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 01/12] virtio/s390: use vring_create_virtqueue
Message-ID: <20190408130128.7859febe.cohuck@redhat.com>
In-Reply-To: <20190404231622.52531-2-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-2-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Apr 2019 01:16:11 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> The commit 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> establishes a new way of allocating virtqueues (as a part of the effort
> that taught DMA to virtio rings).
> 
> In the future we will want virtio-ccw to use the DMA API as well.
> 
> Let us switch from the legacy method of allocating virtqueues to
> vring_create_virtqueue() as the first step into that direction.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 74c328321889..edf4afe2d688 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c

> @@ -516,17 +512,10 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  		err = info->num;
>  		goto out_err;
>  	}
> -	size = PAGE_ALIGN(vring_size(info->num, KVM_VIRTIO_CCW_RING_ALIGN));
> -	info->queue = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> -	if (info->queue == NULL) {
> -		dev_warn(&vcdev->cdev->dev, "no queue\n");
> -		err = -ENOMEM;
> -		goto out_err;
> -	}
> +	vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
> +				    vdev, true, true, ctx,

This second true means 'may_reduce_num'. Looking at the vring code, it
seems that this parameter is never checked; the code will try to
allocate a smaller queue if it can't get the requested size in any
case... this will probably be a problem for legacy virtio-pci, which
explicitly sets may_reduce_num to false. (I can try to come up with a
patch to fix that.)

> +				    virtio_ccw_kvm_notify, callback, name);
>  
> -	vq = vring_new_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN, vdev,
> -				 true, ctx, info->queue, virtio_ccw_kvm_notify,
> -				 callback, name);
>  	if (!vq) {
>  		/* For now, we fail if we can't get the requested size. */
>  		dev_warn(&vcdev->cdev->dev, "no vq\n");
> @@ -534,15 +523,17 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  		goto out_err;
>  	}
>  
> +

Extra blank line :)

>  	/* Register it with the host. */
> +	queue = virtqueue_get_desc_addr(vq);
>  	if (vcdev->revision == 0) {
> -		info->info_block->l.queue = (__u64)info->queue;
> +		info->info_block->l.queue = queue;
>  		info->info_block->l.align = KVM_VIRTIO_CCW_RING_ALIGN;
>  		info->info_block->l.index = i;
>  		info->info_block->l.num = info->num;

You always fill in the size requested by the host, but the actual size
may be smaller (see above). I don't think that is allowed for revision
0 (which implies !virtio-1). You probably need to call
vring_create_virtqueue with may_reduce_num=false for revision 0 (and
wait for the generic vring code to be fixed...)

>  		ccw->count = sizeof(info->info_block->l);
>  	} else {
> -		info->info_block->s.desc = (__u64)info->queue;
> +		info->info_block->s.desc = queue;
>  		info->info_block->s.index = i;
>  		info->info_block->s.num = info->num;

Here, you need to obtain the actual number via
virtqueue_get_vring_size().

>  		info->info_block->s.avail = (__u64)virtqueue_get_avail(vq);
