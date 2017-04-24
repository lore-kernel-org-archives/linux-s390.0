From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] s390/virtio: fix compilation of kvm_virtio.c in
 linux-next
Date: Mon, 24 Apr 2017 19:22:03 +0300
Message-ID: <20170424192137-mutt-send-email-mst@kernel.org>
References: <1492776120-5186-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492776120-5186-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 21, 2017 at 02:02:00PM +0200, Christian Borntraeger wrote:
> Michael,
> commit db932ced55cf ("virtio: add context flag to find vqs") of
> linux-next causes this build failure:
> 
> drivers/s390/virtio/kvm_virtio.c: In function ‘kvm_find_vq’:
> drivers/s390/virtio/kvm_virtio.c:215:18: error: passing argument 8 of
> ‘vring_new_virtqueue’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>       kvm_notify, callback, name);
>                   ^~~~~~~~
> In file included from drivers/s390/virtio/kvm_virtio.c:22:0:
> ./include/linux/virtio_ring.h:93:19: note: expected ‘bool (*)(struct
> virtqueue *) {aka _Bool (*)(struct virtqueue *)}’ but argument is of
> type ‘void (*)(struct virtqueue *)’
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>                    ^~~~~~~~~~~~~~~~~~~
> drivers/s390/virtio/kvm_virtio.c:215:28: error: passing argument 9 of
> ‘vring_new_virtqueue’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>       kvm_notify, callback, name);
>                             ^~~~
> In file included from drivers/s390/virtio/kvm_virtio.c:22:0:
> ./include/linux/virtio_ring.h:93:19: note: expected ‘void (*)(struct
> virtqueue *)’ but argument is of type ‘const char *’
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>                    ^~~~~~~~~~~~~~~~~~~
> drivers/s390/virtio/kvm_virtio.c:213:7: error: too few arguments to
> function ‘vring_new_virtqueue’
>   vq = vring_new_virtqueue(index, config->num,
> KVM_S390_VIRTIO_RING_ALIGN,
>        ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/s390/virtio/kvm_virtio.c:22:0:
> ./include/linux/virtio_ring.h:93:19: note: declared here
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>                    ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> Looks like the new ctx was not added here.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

I squashed this into my commit to avoid bisect issues.
Thanks!


> ---
>  drivers/s390/virtio/kvm_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
> index 81b33aa..a99d09a 100644
> --- a/drivers/s390/virtio/kvm_virtio.c
> +++ b/drivers/s390/virtio/kvm_virtio.c
> @@ -211,7 +211,7 @@ static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
>  		goto out;
>  
>  	vq = vring_new_virtqueue(index, config->num, KVM_S390_VIRTIO_RING_ALIGN,
> -				 vdev, true, (void *) config->address,
> +				 vdev, true, ctx, (void *) config->address,
>  				 kvm_notify, callback, name);
>  	if (!vq) {
>  		err = -ENOMEM;
> -- 
> 2.7.4
