From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based
	virtio transport driver.
Date: Tue, 14 Aug 2012 09:40:01 +0930
Message-ID: <87ipcms59i.fsf@rustcorp.com.au>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
	<87pq72t3ku.fsf@rustcorp.com.au> <20120813105638.66df14a4@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20120813105638.66df14a4@BR9GNB5Z>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2012 10:56:38 +0200, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Wed, 08 Aug 2012 13:52:57 +0930
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > On Tue,  7 Aug 2012 16:52:47 +0200, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > 1) Please don't limit yourself to 32 feature bits!  If you look at how
> >    virtio_mmio does it, they use a selector to index into a
> >    theoretically-infinite array of feature bits:
> 
> It should be easy to extend the data processed by the feature ccws to a
> feature/index combination. Would it be practical to limit the index to
> an 8 bit value?

256 feature bits?  That seems like it could one day be limiting.  Or an
8 bit accessor into feature words?  8192 seems enough for anyone sane.

> > Note that we're also speculating a move to a new vring format, which
> > will probably be little-endian.  But you probably want a completely new
> > ccw code for that anyway.
> 
> Do you have a pointer to that discussion handy?
> 
> If the host may support different vring formats, I'll probably want to
> add some kind of discovery mechanism for that as well (what discovery
> mechanism depends on whether this would be per-device or per-machine).

It would be per-machine; per-device would be a bit crazy.  We'd
deprecate the old ring format.

There's been no consistent thread on the ideas for a ring change,
unfortunately, but you can find interesting parts here, off this thread:

Message-ID: <8762gj6q5r.fsf@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.

Cheers,
Rusty.
