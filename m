From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 08:10:10 +1000
Message-ID: <1409695810.30640.57.camel@pasglop>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2014-09-02 at 14:37 -0700, Andy Lutomirski wrote:

> Let's take a step back from from the implementation.  What is a driver
> for a virtio PCI device (i.e. a PCI device with vendor 0x1af4)
> supposed to do on ppc64?

Today, it's supposed to send guest physical addresses. We can make that
optional via some nego or capabilities to support more esoteric setups
but for backward compatibility, this must remain the default behaviour.

> It can send the device physical addresses and ignore the normal PCI
> DMA semantics, which is what the current virtio_pci driver does.  This
> seems like a layering violation, and this won't work if the device is
> a real PCI device.

Correct, it's an original virtio implementation choice for maximum
performances.

>   Alternatively, it can treat the device like any
> other PCI device and use the IOMMU.  This is a bit slower, and it is
> also incompatible with current hypervisors.

This is a potentially a LOT slower and is backward incompatible with
current qemu/KVM and kvmtool yes.

The slowness can be alleviated using various techniques, for example on
ppc64 we can create a DMA window that contains a permanent mapping of
the entire guest space, so we could use such a thing for virtio.

Another think we could do potentially is advertize via the device-tree
that such a bus uses a direct mapping and have the guest use appropriate
"direct map" dma_ops.

But we need to keep backward compatibility with existing
guest/hypervisors so the default must remain as it is.

> There really are virtio devices that are pieces of silicon and not
> figments of a hypervisor's imagination [1].

I am aware of that. There are also attempts at using virtio to make two
machines communicate via a PCIe link (either with one as endpoint of the
other or via a non-transparent switch).

Which is why I'm not objecting to what you are trying to do ;-)

My suggestion was that it might be a cleaner approach to do that by
having the individual virtio drivers always use the dma_map_* API, and
limiting the kludgery to a combination of virtio_pci "core" and arch
code by selecting an appropriate set of dma_map_ops, defaulting with a
"transparent" (or direct) one as our current default case (and thus
overriding the iommu ones provided by the arch).

>   We could teach virtio_pci
> to use physical addressing on ppc64, but that seems like a pretty
> awful hack, and it'll start needing quirks as soon as someone tries to
> plug a virtio-speaking PCI card into a ppc64 machine.

But x86_64 is the same no ? The day it starts growing an iommu emulation
in qemu (and I've heard it's happening) it will still want to do direct
bypass for virtio for performance.

> Ideas?  x86 and arm seem to be safe here, since AFAIK there is no such
> thing as a physically addressed virtio "PCI" device on a bus with an
> IOMMU on x86, arm, or arm64.

Today .... I wouldn't bet on it to remain that way. The qemu
implementation of virtio is physically addressed and you don't
necessarily have a choice of which device gets an iommu and which not.

Cheers,
Ben.

> [1] https://lwn.net/Articles/580186/
> 
> > Cheers,
> > Ben.
> >
> >
> 
> 
> 
