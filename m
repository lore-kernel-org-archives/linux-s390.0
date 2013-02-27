From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Wed, 27 Feb 2013 20:49:57 +0100
Message-ID: <512E6365.3010406@de.ibm.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
	<20130226111812.GA11111@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130226111812.GA11111@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On 26/02/13 12:18, Michael S. Tsirkin wrote:

> virtio_ccw: pass a cookie value to kvm hypercall
> 
> Lookups by channel/vq pair on host during virtio notifications might be
> expensive.  Interpret hypercall return value as a cookie which host can
> use to do device lookups for the next notification more efficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Seems to work fine. (as expected).
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> 
> ---
> 
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index 2029b6c..1054f3a 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -77,6 +77,7 @@ struct virtio_ccw_vq_info {
>  	void *queue;
>  	struct vq_info_block *info_block;
>  	struct list_head node;
> +	long cookie;
>  };
> 
>  #define KVM_VIRTIO_CCW_RING_ALIGN 4096
> @@ -145,15 +146,18 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
>  }
> 
>  static inline long do_kvm_notify(struct subchannel_id schid,
> -				 unsigned long queue_index)
> +				 unsigned long queue_index,
> +				 long cookie)
>  {
>  	register unsigned long __nr asm("1") = KVM_S390_VIRTIO_CCW_NOTIFY;
>  	register struct subchannel_id __schid asm("2") = schid;
>  	register unsigned long __index asm("3") = queue_index;
>  	register long __rc asm("2");
> +	register long __cookie asm("4") = cookie;
> 
>  	asm volatile ("diag 2,4,0x500\n"
> -		      : "=d" (__rc) : "d" (__nr), "d" (__schid), "d" (__index)
> +		      : "=d" (__rc) : "d" (__nr), "d" (__schid), "d" (__index),
> +		      "d"(__cookie)
>  		      : "memory", "cc");
>  	return __rc;
>  }
> @@ -166,7 +170,7 @@ static void virtio_ccw_kvm_notify(struct virtqueue *vq)
> 
>  	vcdev = to_vc_device(info->vq->vdev);
>  	ccw_device_get_schid(vcdev->cdev, &schid);
> -	do_kvm_notify(schid, virtqueue_get_queue_index(vq));
> +	info->cookie = do_kvm_notify(schid, virtqueue_get_queue_index(vq), info->cookie);
>  }
> 
>  static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
> 
