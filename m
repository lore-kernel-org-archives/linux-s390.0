From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based
	virtio transport driver.
Date: Wed, 15 Aug 2012 12:45:26 +0930
Message-ID: <87r4r8rgkx.fsf@rustcorp.com.au>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com>
	<87pq72t3ku.fsf@rustcorp.com.au> <20120813105638.66df14a4@BR9GNB5Z>
	<87ipcms59i.fsf@rustcorp.com.au> <20120814130334.79ba51b5@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20120814130334.79ba51b5@BR9GNB5Z>
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

On Tue, 14 Aug 2012 13:03:34 +0200, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > It would be per-machine; per-device would be a bit crazy.  We'd
> > deprecate the old ring format.
> > 
> > There's been no consistent thread on the ideas for a ring change,
> > unfortunately, but you can find interesting parts here, off this thread:
> > 
> > Message-ID: <8762gj6q5r.fsf@rustcorp.com.au>
> > Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
> 
> I've read a bit through this and it looks like this is really virtio-2
> or so. How about discoverability by the guest? Guests will likely have
> to support both formats, and forcing them to look at the feature bits
> for each device in order to figure out the queue format feels wrong if
> it is going to be the same format for the whole machine anyway.

Yes, it needs some out-of-band acknowledgement mechanism by the guest.
Might be worth putting a max version number somewhere, which the guest
writes to acknowledge (ie. currently it would be 1, and the guest would
always write a 1).

Cheers,
Rusty.
