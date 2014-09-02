From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 3 Sep 2014 00:10:23 +0300
Message-ID: <20140902211023.GB25231@redhat.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
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

On Mon, Sep 01, 2014 at 10:55:29PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 1, 2014 at 3:16 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Mon, 2014-09-01 at 10:39 -0700, Andy Lutomirski wrote:
> >> Changes from v1:
> >>  - Using the DMA API is optional now.  It would be nice to improve the
> >>    DMA API to the point that it could be used unconditionally, but s390
> >>    proves that we're not there yet.
> >>  - Includes patch 4, which fixes DMA debugging warnings from virtio_net.
> >
> > I'm not sure if you saw my reply on the other thread but I have a few
> > comments based on the above "it would be nice if ..."
> >
> 
> Yeah, sorry, I sort of thought I responded, but I didn't do a very good job.
> 
> > So here we have both a yes and a no :-)
> >
> > It would be nice to avoid those if () games all over and indeed just
> > use the DMA API, *however* we most certainly don't want to actually
> > create IOMMU mappings for the KVM virio case. This would be a massive
> > loss in performances on several platforms and generally doesn't make
> > much sense.
> >
> > However, we can still use the API without that on any architecture
> > where the dma mapping API ends up calling the generic dma_map_ops,
> > it becomes just a matter of virtio setting up some special "nop" ops
> > when needed.
> 
> I'm not quite convinced that this is a good idea.  I think that there
> are three relevant categories of virtio devices:
> 
> a) Any virtio device where the normal DMA ops are nops.  This includes
> x86 without an IOMMU (e.g. in a QEMU/KVM guest), 32-bit ARM, and
> probably many other architectures.  In this case, what we do only
> matters for performance, not for correctness.  Ideally the arch DMA
> ops are fast.
> 
> b) Virtio devices that use physical addressing on systems where DMA
> ops either don't exist at all (most s390) or do something nontrivial.
> In this case, we must either override the DMA ops or just not use
> them.
> 
> c) Virtio devices that use bus addressing.  This includes everything
> on Xen (because the "physical" addresses are nonsense) and any actual
> physical PCI device that speaks virtio on a system with an IOMMU.  In
> this case, we must use the DMA ops.
> 
> The issue is that, on systems with DMA ops that do something, we need
> to make sure that we know whether we're in case (b) or (c).  In these
> patches, I've made the assumption that, if the virtio devices lives on
> the PCI bus, then it uses the same type of addressing that any other
> device on that PCI bus would use.
> 
> On x86, at least, I doubt that we'll ever see a physically addressed
> PCI virtio device for which ACPI advertises an IOMMU, since any sane
> hypervisor will just not advertise an IOMMU for the virtio device.

How exactly does one not advertise an IOMMU for a specific
device? Could you please clarify?

> But are there arm64 or PPC guests that use virtio_pci, that have
> IOMMUs, and that will malfunction if the virtio_pci driver ends up
> using the IOMMU?  I certainly hope not, since these systems might be
> very hard-pressed to work right if someone plugged in a physical
> virtio-speaking PCI device.

One simple fix is to defer this all until virtio 1.0.
virtio 1.0 has an alternative set of IDs for virtio pci,
that can be used if you are making an incompatible change.
We can use that if there's an iommu.


> >
> > The difficulty here resides in the fact that we have never completely
> > made the dma_map_ops generic. The ops themselves are defined generically
> > as are the dma_map_* interfaces based on them, but the location of the
> > ops pointer is still more/less arch specific and some architectures
> > still chose not to use that indirection at all I believe.
> >
> 
> I'd be happy to update the patches if someone does this, but I don't
> really want to attack the DMA API on all architectures right now.  In
> the mean time, at least s390 requires that we be able to compile out
> the DMA API calls.  I'd rather see s390 provide working no-op dma ops
> for all of the struct devices that provide virtio interfaces.
> 
> On a related note, shouldn't virtio be doing something to provide dma
> ops to the virtio device and any of its children?  I don't know how it
> would even try to do this, given how architecture-dependent this code
> currently is.  Calling dma_map_single on the virtio device (as opposed
> to its parent) is currently likely to crash on x86.  Fortunately,
> nothing does this.
> 
> --Andy
