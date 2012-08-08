From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based
	virtio transport driver.
Date: Wed, 08 Aug 2012 13:52:57 +0930
Message-ID: <87pq72t3ku.fsf@rustcorp.com.au>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  7 Aug 2012 16:52:47 +0200, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> Add a driver for kvm guests that matches virtual ccw devices provided
> by the host as virtio bridge devices.

Hi Cornelia,

        OK, this is a good opportunity to fix some limitations, just as
we did for virtio_mmio (drivers/virtio/virtio_mmio.c).

1) Please don't limit yourself to 32 feature bits!  If you look at how
   virtio_mmio does it, they use a selector to index into a
   theoretically-infinite array of feature bits:

 * 0x010  R  HostFeatures     Features supported by the host
 * 0x014  W  HostFeaturesSel  Set of host features to access via HostFeatures
 *
 * 0x020  W  GuestFeatures    Features activated by the guest
 * 0x024  W  GuestFeaturesSel Set of activated features to set via GuestFeatures

2) Please also allow the guest to set the alignment for virtio ring
   layout (it controls the spacing between the rings), eg:

 * 0x03c  W  QueueAlign       Used Ring alignment for the current queue

3) Finally, make sure the guest can set the size of the queue, in case
   it can't allocate the size the host suggests, eg:

 * 0x034  R  QueueNumMax      Maximum size of the currently selected queue
 * 0x038  W  QueueNum         Queue size for the currently selected queue

   This means the host can suggest huge queues, knowing the guest won't
   simply fail if it does so.

Note that we're also speculating a move to a new vring format, which
will probably be little-endian.  But you probably want a completely new
ccw code for that anyway.

Cheers,
Rusty.
