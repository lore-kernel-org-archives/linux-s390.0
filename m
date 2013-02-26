From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Tue, 26 Feb 2013 14:29:07 +0100
Message-ID: <20130226142907.3a38659f@gondolin>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
	<20130226111812.GA11111@redhat.com>
	<512CA6F3.7080203@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <512CA6F3.7080203@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, rusty@rustcorp.com.au
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Feb 2013 13:13:39 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 26/02/13 12:18, Michael S. Tsirkin wrote:
> > virtio_ccw: pass a cookie value to kvm hypercall
> > 
> > Lookups by channel/vq pair on host during virtio notifications might be
> > expensive.  Interpret hypercall return value as a cookie which host can
> > use to do device lookups for the next notification more efficiently.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > 
> > diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> > index 2029b6c..1054f3a 100644
> > --- a/drivers/s390/kvm/virtio_ccw.c
> > +++ b/drivers/s390/kvm/virtio_ccw.c
> > @@ -77,6 +77,7 @@ struct virtio_ccw_vq_info {
> >  	void *queue;
> >  	struct vq_info_block *info_block;
> >  	struct list_head node;
> > +	long cookie;
> >  };
> > 
> >  #define KVM_VIRTIO_CCW_RING_ALIGN 4096
> > @@ -145,15 +146,18 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
> >  }
> > 
> >  static inline long do_kvm_notify(struct subchannel_id schid,
> > -				 unsigned long queue_index)
> > +				 unsigned long queue_index,
> > +				 long cookie)
> >  {
> >  	register unsigned long __nr asm("1") = KVM_S390_VIRTIO_CCW_NOTIFY;
> >  	register struct subchannel_id __schid asm("2") = schid;
> >  	register unsigned long __index asm("3") = queue_index;
> >  	register long __rc asm("2");
> > +	register long __cookie asm("4") = cookie;
> > 
> >  	asm volatile ("diag 2,4,0x500\n"
> > -		      : "=d" (__rc) : "d" (__nr), "d" (__schid), "d" (__index)
> > +		      : "=d" (__rc) : "d" (__nr), "d" (__schid), "d" (__index),
> > +		      "d"(__cookie)
> >  		      : "memory", "cc");
> >  	return __rc;
> >  }
> > @@ -166,7 +170,7 @@ static void virtio_ccw_kvm_notify(struct virtqueue *vq)
> > 
> >  	vcdev = to_vc_device(info->vq->vdev);
> >  	ccw_device_get_schid(vcdev->cdev, &schid);
> > -	do_kvm_notify(schid, virtqueue_get_queue_index(vq));
> > +	info->cookie = do_kvm_notify(schid, virtqueue_get_queue_index(vq), info->cookie);
> >  }
> > 
> >  static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
> 
> 
> Hmmm, forget my last mail. This actually could be even forward and backward compatible.
> In the virtio spec we will not define the cookie format (just 64bit int). That will allow
> qemu or future kernels to use that for other things (as long as a validity check is 
> possible) if we dont have a kvm bus.
> 
> Now:
> 
> old guest, old host: 
> works.
> 
> old guest, new host: 
> the cookie from the guest contains junk, the host needs to detect that the cookie is 
> junk and ignores it. It will return the new cookie anyway. 
> 
> new guest, old host:
> The guest will get a junk cookie and pass it back to the host. But the host will ignore
> it anyway.
> 
> new guest, new host:
> works.
> 
> So...
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Yes, that sounds sane; I'll give it a try later.

However, I'd rather not want to rush this; I'd prefer to get the
initial version in first.

I'll do a v4 later.
