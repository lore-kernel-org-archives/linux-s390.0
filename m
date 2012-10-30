From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/5] KVM: s390: Add a channel I/O based virtio transport
 driver.
Date: Tue, 30 Oct 2012 15:00:55 +0100
Message-ID: <20121030150055.43271334@BR9GNB5Z>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com>
	<1351516046-30037-5-git-send-email-cornelia.huck@de.ibm.com>
	<D3058F7E-EB72-4749-AD52-485A1777CE17@suse.de>
	<20121029193447.05dad97b@BR9GNB5Z>
	<8466E164-8A30-431B-9103-D45F97331489@suse.de>
	<20121030140304.3bcd3863@BR9GNB5Z>
	<508FD91A.4060704@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <508FD91A.4060704@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 30 Oct 2012 14:41:46 +0100
Alexander Graf <agraf@suse.de> wrote:

> On 10/30/2012 02:03 PM, Cornelia Huck wrote:
> > On Mon, 29 Oct 2012 19:37:10 +0100
> > Alexander Graf<agraf@suse.de>  wrote:
> >
> >> On 29.10.2012, at 19:34, Cornelia Huck wrote:
> >>
> >>> On Mon, 29 Oct 2012 19:12:54 +0100
> >>> Alexander Graf<agraf@suse.de>  wrote:
> >>>
> >>>> On 29.10.2012, at 14:07, Cornelia Huck wrote:
> >>>>> +static void virtio_ccw_kvm_notify(struct virtqueue *vq)
> >>>>> +{
> >>>>> +	struct virtio_ccw_vq_info *info = vq->priv;
> >>>>> +	struct virtio_ccw_device *vcdev;
> >>>>> +	struct subchannel_id schid;
> >>>>> +	__u32 reg2;
> >>>>> +
> >>>>> +	vcdev = to_vc_device(info->vq->vdev);
> >>>>> +	ccw_device_get_schid(vcdev->cdev,&schid);
> >>>>> +	reg2 = *(__u32 *)&schid;
> >>>> That cast looks quite ugly. Can't you just access the field in there you need? Or if it's multiple fields do a union over them? Or assemble them by hand in C?
> >>> I think the cast looks less ugly than using a union to morph it around.
> >>> I want the schid with all fields filled out anyway, since this is what
> >>> identifies the subchannel.
> >> How about a helper function that returns a u32 for a struct subchannel_id in arch/s390/include/asm/schid.h then?
> > This would just move the cast around, no? I don't think that would
> > improve readability.
> 
> It would take it from the user of that struct close to the definition of 
> the struct. The fact that it's an ugly cast by then is an implementation 
> detail. This way it's a public API.

But API-wise, returning a struct subchannel_id is cleaner - we don't
want "u32 associated with that device", but "subchannel identifier for
that device". The fact that we want to stuff it into an integer for the
hypercall is the implementaton detail.
