Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 19:48:49 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 10/12] virtio/s390: consolidate DMA allocations
In-Reply-To: <20190410183643.694ccb85.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-11-pasic@linux.ibm.com>
        <20190410104649.12cdbcba.cohuck@redhat.com>
        <20190410171254.71206015@oc2783563651>
        <20190410183643.694ccb85.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410194849.511ecc46@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 18:36:43 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 10 Apr 2019 17:12:54 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Wed, 10 Apr 2019 10:46:49 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Fri,  5 Apr 2019 01:16:20 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > index aa45a6a027ae..7268149f2ee8 100644
> > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > @@ -49,12 +49,12 @@ struct vq_config_block {
> > > >  struct vcdev_dma_area {
> > > >  	unsigned long indicators;
> > > >  	unsigned long indicators2;
> > > > +	struct vq_config_block config_block;
> > > > +	__u8 status; /* TODO check __aligned(8); */  
> > > 
> > > ...I think that needs attention.  
> > 
> > Yes I wanted to discuss this with you. I could not find anything
> > in the virtio spec that would put requirements on how this
> > status field needs to be aligned. But I did not look to hard.
> > 
> > The ccw.cda can hold an arbitrary data address AFAIR (for indirect,
> > of course we do have alignment requirements).
> 
> I think it needs to be doubleword aligned.
> 

I've re-read the part of the PoP that describes the ccw formats. And
it reinforced my position: for IDA and MIDA we need proper alignment,
but if the CCW ain't an indirect one there is no alignment requirement.

QEMU also does not seem to check either.

Can you double-check and provide me with a reference that proves me
wrong if I'm wrong.

> > 
> > Apparently status used to be a normal field, and became a pointer with
> > 73fa21ea4fc6 "KVM: s390: Dynamic allocation of virtio-ccw I/O
> > data." (Cornelia Huck, 2013-01-07). I could not quite figure out why.
> 
> In the beginning, the code used a below-2G-area for all commands.
> Rather than adding locking to avoid races there, that commit switches
> to allocating the needed structures individually. The status field
> needed to be below 2G, so it needed to be allocated separately.
> 

I get it now. The confusing part was that the field 'area' was about
holding the address of the also previously dynamically allocated
below 2G area that was used for talking to the hypervisor via CCW I/O.

> > 
> > So maybe dropping the TODO comment will do just fine. What do you think?
> 

I still think we just need to drop the comment, as we don't have to
align it.

Regards,
Halil
