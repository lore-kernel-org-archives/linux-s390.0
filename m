From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Wed, 1 Oct 2014 09:42:35 +0300
Message-ID: <20141001064235.GA31859@redhat.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop>
	<20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
	<CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
	<20140930153821.GA4456@redhat.com>
	<CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 30, 2014 at 08:48:45AM -0700, Andy Lutomirski wrote:
> On Tue, Sep 30, 2014 at 8:38 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > I thought hard about this, I think we are better off waiting till the
> > next release: there's a chance QEMU will have IOMMU support for KVM x86
> > then, and this will make it easier to judge which way does the wind
> > blow.
> >
> > It seems that we lose nothing substantial keeping the status quo a bit longer,
> > but if we make an incompatible change in guests now we might
> > create nasty compatibility headaches going forward.
> >
> 
> I would argue for the opposite approach.  Having a QEMU release that
> supports an IOMMU on x86 and exposes a commonly used PCI device that
> bypasses that IOMMU without any explicit notification to the guest
> (and specification!) that this is happening is IMO insane.  Once that
> happens, we'll have to address the nasty case on both x86 and PPC.
> This will suck.
>
> If we accept the guest change and make sure that there is never a QEMU
> release that has a visible IOMMU cheat on any arch other than PPC,
> then at least the damage will be contained.

Wrt QEMU this sounds reasonable. Wrt guest, deferring guest changes
a bit, until we have a better idea about how the host side behaves
sounds better to me than saying "this is how guests will behave,
let the host adapt to that".

> x86 will be worse than PPC, too: the special case needed to support
> QEMU 2.2 with IOMMU and virtio enabled with a Xen guest will be fairly
> large and disgusting and will only exist to support something that IMO
> should never have existed in the first place.
> 
> PPC at least avoids *that* problem by virtue of not having Xen
> paravirt.  (And please don't add Xen paravirt to PPC -- x86 is trying
> to kill it off, but this is a 5-10 year project.)
> 
> [..., reordered]
> 
> >>
> >> Except that I think that PPC is the only platform on which QEMU's code
> >> actually bypasses any IOMMU.  Unless we've all missed something, there
> >> is no QEMU release that will put a virtio device behind an IOMMU on
> >> any platform other than PPC.
> >
> > I think that is true but it seems that this will be true for x86 for
> > QEMU 2.2 unless we make some changes there.
> > Which we might not have the time for since 2.2 is feature frozen
> > from tomorrow.
> > Maybe we should disable the IOMMU in 2.2, this is worth considering.
> >
> 
> Please do.

Or at least disable it just if there are virtio devices.

> Also, try booting this 2.2 QEMU candidate with nested virtualization
> on.  Then bind vfio to a virtio-pci device and watch the guest get
> corrupted.  QEMU will blame Linux for incorrectly programming the
> hardware, and Linux will blame QEMU for its blatant violation of the
> ACPI spec.  Given that this is presumably most of the point of adding
> IOMMU support, it seems like a terrible idea to let code like that
> into the wild.
> 
> If this happens, Linux may also end up needing a quirk to prevent vfio
> from binding to QEMU 2.2's virtio-pci devices.
> 
> --Andy

This specific item wouldn't worry me too much.

-- 
MST
