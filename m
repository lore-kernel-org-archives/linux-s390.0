From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based virtio transport
 driver.
Date: Mon, 13 Aug 2012 10:56:38 +0200
Message-ID: <20120813105638.66df14a4@BR9GNB5Z>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
	<87pq72t3ku.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <87pq72t3ku.fsf@rustcorp.com.au>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 08 Aug 2012 13:52:57 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tue,  7 Aug 2012 16:52:47 +0200, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > Add a driver for kvm guests that matches virtual ccw devices provided
> > by the host as virtio bridge devices.
> 
> Hi Cornelia,
> 
>         OK, this is a good opportunity to fix some limitations, just as
> we did for virtio_mmio (drivers/virtio/virtio_mmio.c).
> 
> 1) Please don't limit yourself to 32 feature bits!  If you look at how
>    virtio_mmio does it, they use a selector to index into a
>    theoretically-infinite array of feature bits:
> 
>  * 0x010  R  HostFeatures     Features supported by the host
>  * 0x014  W  HostFeaturesSel  Set of host features to access via HostFeatures
>  *
>  * 0x020  W  GuestFeatures    Features activated by the guest
>  * 0x024  W  GuestFeaturesSel Set of activated features to set via GuestFeatures

It should be easy to extend the data processed by the feature ccws to a
feature/index combination. Would it be practical to limit the index to
an 8 bit value?

> 
> 2) Please also allow the guest to set the alignment for virtio ring
>    layout (it controls the spacing between the rings), eg:
> 
>  * 0x03c  W  QueueAlign       Used Ring alignment for the current queue

I think the set_vq ccw could be extended with that info.

> 
> 3) Finally, make sure the guest can set the size of the queue, in case
>    it can't allocate the size the host suggests, eg:
> 
>  * 0x034  R  QueueNumMax      Maximum size of the currently selected queue
>  * 0x038  W  QueueNum         Queue size for the currently selected queue
> 
>    This means the host can suggest huge queues, knowing the guest won't
>    simply fail if it does so.

Makes sense, I didn't like just failing to allocate either. The actual
size could probably go into the set_vq ccw as well.

> 
> Note that we're also speculating a move to a new vring format, which
> will probably be little-endian.  But you probably want a completely new
> ccw code for that anyway.

Do you have a pointer to that discussion handy?

If the host may support different vring formats, I'll probably want to
add some kind of discovery mechanism for that as well (what discovery
mechanism depends on whether this would be per-device or per-machine).
