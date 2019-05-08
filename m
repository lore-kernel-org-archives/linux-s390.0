Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 09/10] virtio/s390: use DMA memory for ccw I/O and classic
 notifiers
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-10-pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 8 May 2019 16:46:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190426183245.37939-10-pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a873909a-9846-d6d3-f03e-e86d53fd9c75@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 26/04/2019 20:32, Halil Pasic wrote:
> Before virtio-ccw could get away with not using DMA API for the pieces of
> memory it does ccw I/O with. With protected virtualization this has to
> change, since the hypervisor needs to read and sometimes also write these
> pieces of memory.
> 
> The hypervisor is supposed to poke the classic notifiers, if these are
> used, out of band with regards to ccw I/O. So these need to be allocated
> as DMA memory (which is shared memory for protected virtualization
> guests).
> 
> Let us factor out everything from struct virtio_ccw_device that needs to
> be DMA memory in a satellite that is allocated as such.
> 
> Note: The control blocks of I/O instructions do not need to be shared.
> These are marshalled by the ultravisor.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>   drivers/s390/virtio/virtio_ccw.c | 177 +++++++++++++++++++++------------------
>   1 file changed, 96 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 1f3e7d56924f..613b18001a0c 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -46,9 +46,15 @@ struct vq_config_block {
>   #define VIRTIO_CCW_CONFIG_SIZE 0x100
>   /* same as PCI config space size, should be enough for all drivers */
>   
> +struct vcdev_dma_area {
> +	unsigned long indicators;
> +	unsigned long indicators2;
> +	struct vq_config_block config_block;
> +	__u8 status;
> +};
> +
>   struct virtio_ccw_device {
>   	struct virtio_device vdev;
> -	__u8 *status;
>   	__u8 config[VIRTIO_CCW_CONFIG_SIZE];
>   	struct ccw_device *cdev;
>   	__u32 curr_io;
> @@ -58,24 +64,22 @@ struct virtio_ccw_device {
>   	spinlock_t lock;
>   	struct mutex io_lock; /* Serializes I/O requests */
>   	struct list_head virtqueues;
> -	unsigned long indicators;
> -	unsigned long indicators2;
> -	struct vq_config_block *config_block;
>   	bool is_thinint;
>   	bool going_away;
>   	bool device_lost;
>   	unsigned int config_ready;
>   	void *airq_info;
> +	struct vcdev_dma_area *dma_area;
>   };
>   
>   static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
>   {
> -	return &vcdev->indicators;
> +	return &vcdev->dma_area->indicators;
>   }
>   
>   static inline unsigned long *indicators2(struct virtio_ccw_device *vcdev)
>   {
> -	return &vcdev->indicators2;
> +	return &vcdev->dma_area->indicators2;
>   }
>   
>   struct vq_info_block_legacy {
> @@ -176,6 +180,22 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
>   	return container_of(vdev, struct virtio_ccw_device, vdev);
>   }
>   
> +static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size)
> +{
> +	return ccw_device_dma_zalloc(to_vc_device(vdev)->cdev, size);
> +}
> +
> +static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
> +				 void *cpu_addr)
> +{
> +	return ccw_device_dma_free(to_vc_device(vdev)->cdev, cpu_addr, size);
> +}
> +
> +#define vc_dma_alloc_struct(vdev, ptr) \
> +	({ptr = __vc_dma_alloc(vdev, sizeof(*(ptr))); })
> +#define vc_dma_free_struct(vdev, ptr) \
> +	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr))
> +
>   static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
>   {
>   	unsigned long i, flags;
> @@ -335,8 +355,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>   	struct airq_info *airq_info = vcdev->airq_info;
>   
>   	if (vcdev->is_thinint) {
> -		thinint_area = kzalloc(sizeof(*thinint_area),
> -				       GFP_DMA | GFP_KERNEL);
> +		vc_dma_alloc_struct(&vcdev->vdev, thinint_area);
>   		if (!thinint_area)
>   			return;
>   		thinint_area->summary_indicator =
> @@ -347,8 +366,8 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>   		ccw->cda = (__u32)(unsigned long) thinint_area;
>   	} else {
>   		/* payload is the address of the indicators */
> -		indicatorp = kmalloc(sizeof(indicators(vcdev)),
> -				     GFP_DMA | GFP_KERNEL);
> +		indicatorp = __vc_dma_alloc(&vcdev->vdev,
> +					   sizeof(indicators(vcdev)));

should be sizeof(long) ?

This is a recurrent error, but it is not an issue because the size of
the indicators is unsigned long as the size of the pointer.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
