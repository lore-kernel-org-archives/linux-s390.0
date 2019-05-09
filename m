Return-Path: <SRS0=ZS0J=TJ=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 9 May 2019 20:26:00 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 08/10] virtio/s390: add indirection to indicators access
In-Reply-To: <a4bf1976-8037-63bb-2cf6-c389edbd2e89@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-9-pasic@linux.ibm.com>
        <716d47ca-016f-e8f4-6d78-7746a7d9f6ba@linux.ibm.com>
        <a4bf1976-8037-63bb-2cf6-c389edbd2e89@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190509202600.4fd6aebe.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 9 May 2019 14:01:01 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 08/05/2019 16:31, Pierre Morel wrote:
> > On 26/04/2019 20:32, Halil Pasic wrote:
> >> This will come in handy soon when we pull out the indicators from
> >> virtio_ccw_device to a memory area that is shared with the hypervisor
> >> (in particular for protected virtualization guests).
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> ---
> >>   drivers/s390/virtio/virtio_ccw.c | 40 
> >> +++++++++++++++++++++++++---------------
> >>   1 file changed, 25 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/s390/virtio/virtio_ccw.c 
> >> b/drivers/s390/virtio/virtio_ccw.c
> >> index bb7a92316fc8..1f3e7d56924f 100644
> >> --- a/drivers/s390/virtio/virtio_ccw.c
> >> +++ b/drivers/s390/virtio/virtio_ccw.c
> >> @@ -68,6 +68,16 @@ struct virtio_ccw_device {
> >>       void *airq_info;
> >>   };
> >> +static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
> >> +{
> >> +    return &vcdev->indicators;
> >> +}
> >> +
> >> +static inline unsigned long *indicators2(struct virtio_ccw_device 
> >> *vcdev)
> >> +{
> >> +    return &vcdev->indicators2;
> >> +}
> >> +
> >>   struct vq_info_block_legacy {
> >>       __u64 queue;
> >>       __u32 align;
> >> @@ -337,17 +347,17 @@ static void virtio_ccw_drop_indicator(struct 
> >> virtio_ccw_device *vcdev,
> >>           ccw->cda = (__u32)(unsigned long) thinint_area;
> >>       } else {
> >>           /* payload is the address of the indicators */
> >> -        indicatorp = kmalloc(sizeof(&vcdev->indicators),
> >> +        indicatorp = kmalloc(sizeof(indicators(vcdev)),
> >>                        GFP_DMA | GFP_KERNEL);
> >>           if (!indicatorp)
> >>               return;
> >>           *indicatorp = 0;
> >>           ccw->cmd_code = CCW_CMD_SET_IND;
> >> -        ccw->count = sizeof(&vcdev->indicators);
> >> +        ccw->count = sizeof(indicators(vcdev));
> > 
> > This looks strange to me. Was already weird before.
> > Lucky we are indicators are long...
> > may be just sizeof(long)
> 

I'm not sure I understand where are you coming from...

With CCW_CMD_SET_IND we tell the hypervisor the guest physical address
at which the so called classic indicators. There is a comment that
makes this obvious. The argument of the sizeof was and remained a
pointer type. AFAIU this is what bothers you. 
> 
> AFAIK the size of the indicators (AIV/AIS) is not restricted by the 
> architecture.

The size of vcdev->indicators is restricted or defined by the virtio
specification. Please have a look at '4.3.2.6.1 Setting Up Classic Queue
Indicators' here:
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-1630002

Since with Linux on s390 only 64 bit is supported, both the sizes are in
line with the specification. Using u64 would semantically match the spec
better, modulo pre virtio 1.0 which ain't specified. I did not want to
do changes that are not necessary for what I'm trying to accomplish. If
we want we can change these to u64 with a patch on top.

> However we never use more than 64 bits, do we ever have an adapter 
> having more than 64 different interrupts?

These are one per queue. The number of queues used to be limited to 64
but it ain't no more. If the driver uses classic notifiers, only the
first 64 can be used.

> 
> May be we can state than we use a maximal number of AISB of 64 and 
> therefor use indicators with a size of unsigned long, or __u64 or 
> whatever is appropriate. Please clear this.
> 

I think you are mixing up adapter interrupts as defined by the
architecture, with virtio indicators which are kind of a special case
at best: the two stage stuff is modeled after AISB and AIBV.  

> With this cleared:

I hope, I managed to clear this up a bit. If not please try to re-state
your concern in different words.

> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> 

Thanks for your review!

Halil
 
