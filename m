From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Sun, 14 Sep 2014 11:58:06 +0300
Message-ID: <20140914085806.GA24929@redhat.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<874mwpkxxi.fsf@rustcorp.com.au>
	<CALCETrWMc6TQy02kLXLcLwMJbPkpY4yv7U-As6jv0Frx34nuww@mail.gmail.com>
	<87lhpykdbu.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87lhpykdbu.fsf@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtio-dev@lists.oasis-open.org, pawel.moll@arm.com, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 05, 2014 at 12:01:33PM +0930, Rusty Russell wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
> > On Sep 2, 2014 11:53 PM, "Rusty Russell" <rusty@rustcorp.com.au> wrote:
> >>
> >> Andy Lutomirski <luto@amacapital.net> writes:
> >> > There really are virtio devices that are pieces of silicon and not
> >> > figments of a hypervisor's imagination [1].
> >>
> >> Hi Andy,
> >>
> >>         As you're discovering, there's a reason no one has done the DMA
> >> API before.
> >>
> >> So the problem is that ppc64's IOMMU is a platform thing, not a bus
> >> thing.  They really do carve out an exception for virtio devices,
> >> because performance (LOTS of performance).  It remains to be seen if
> >> other platforms have the same performance issues, but in absence of
> >> other evidence, the answer is yes.
> >>
> >> It's a hack.  But having specific virtual-only devices are an even
> >> bigger hack.
> >>
> >> Physical virtio devices have been talked about, but don't actually exist
> >> in Real Life.  And someone a virtio PCI card is going to have serious
> >> performance issues: mainly because they'll want the rings in the card's
> >> MMIO region, not allocated by the driver.  Being broken on PPC is really
> >> the least of their problems.
> >>
> >> So, what do we do?  It'd be nice if Linux virtio Just Worked under Xen,
> >> though Xen's IOMMU is outside the virtio spec.  Since virtio_pci can be
> >> a module, obvious hacks like having xen_arch_setup initialize a dma_ops pointer
> >> exposed by virtio_pci.c is out.
> >
> > Xen does expose dma_ops.  The trick is knowing when to use it.
> >
> >>
> >> I think the best approach is to have a new feature bit (25 is free),
> >> VIRTIO_F_USE_BUS_MAPPING which indicates that a device really wants to
> >> use the mapping for the bus it is on.  A real device would set this,
> >> or it won't work behind an IOMMU.  A Xen device would also set this.
> >
> > The devices I care about aren't actually Xen devices.  They're devices
> > supplied by QEMU/KVM, booting a Xen hypervisor, which in turn passes
> > the virtio device (along with every other PCI device) through to dom0.
> > So this is exactly the same virtio device that regular x86 KVM guests
> > would see.  The reason that current code fails is that Xen guest
> > physical addresses aren't the same as the addresses seen by the outer
> > hypervisor.
> >
> > These devices don't know that physical addresses != bus addresses, so
> > they can't advertise that fact.
> 
> Ah, I see.  Then we will need a Xen-specific hack.
> 
> > Grr.  This is mostly a result of the fact that virtio_pci devices
> > aren't really PCI devices.  I still think that virtio_pci shouldn't
> > have to worry about this; ideally this would all be handled higher up
> > in the device hierarchy.  x86 already gets this right.
> 
> Yes.  Adding a feature to say "I am a real PCI device" is possible, but
> has other issues (particularly as Michael Tsirkin pointed out, what do
> you do if the driver doesn't understand the feature).
> 
> > Are there any hypervisors except PPC that use virtio_pci, have IOMMUs
> > on the pci slot that virtio_pci lives in, and that use physical
> > addressing?  If not, I think that just quirking PPC will work (at
> > least until someone wants IOMMU support in virtio_pci on PPC, in which
> > case doing something using devicetree seems like a reasonable
> > solution).
> 
> We can either patch to make PPC weird or make Xen weird.  I'm on the
> fence.
> 
> Two questions for Paulo:
> 1) When QEMU support IOMMU on x86, will the virtio devices behind it
>    respect the IOMMU (do they use the right memory access primitives?).
> 
> 2) Are we really going to be able to exclude virtio devices from using
>    the x86 IOMMU in a portable way which will always work?  If it's
>    per-bus granularity, will qemu really put them on their own PCI bus
>    and get this right?  Or will it sometimes get it wrong and users will
>    end up using virtio devices via IOMMU by accident?
> 
> If the answers are both "yes", then x86 is going to be able to use
> virtio+IOMMU, so PPC looks like the odd one out.  Otherwise it looks
> like we're really going to want to stick with the "ignore IOMMU" rule
> until (handwave future), and we make an exception for Xen.
> 
> Cheers,
> Rusty.

In theory, it's yes to both questions.
In practice, with patches merged recently it's no to both questions :).

It's a work in progress, but some extra effort to support miltiple
PCI roots will be needed on the QEMU side.
What problems will surface when we try to do multiple roots?
Only time will tell.

If it's felt that it's much cleaner to make PPC the odd one out, we can
defer enabling iommu in qemu on x86 until ways to bypass it are
implemented.

But I would be inclined, for pre-1.0 drivers, to make Xen weird.
For 1.0 drivers, we have a bit of time to consider this,
and maybe PPC guys can come up with some way (can be PV)
to tell guest "these devices bypass the IOMMU".

> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
