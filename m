From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 16:12:01 +0930
Message-ID: <874mwpkxxi.fsf@rustcorp.com.au>
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
To: Andy Lutomirski <luto@amacapital.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

Andy Lutomirski <luto@amacapital.net> writes:
> There really are virtio devices that are pieces of silicon and not
> figments of a hypervisor's imagination [1].

Hi Andy,

        As you're discovering, there's a reason no one has done the DMA
API before.

So the problem is that ppc64's IOMMU is a platform thing, not a bus
thing.  They really do carve out an exception for virtio devices,
because performance (LOTS of performance).  It remains to be seen if
other platforms have the same performance issues, but in absence of
other evidence, the answer is yes.

It's a hack.  But having specific virtual-only devices are an even
bigger hack.

Physical virtio devices have been talked about, but don't actually exist
in Real Life.  And someone a virtio PCI card is going to have serious
performance issues: mainly because they'll want the rings in the card's
MMIO region, not allocated by the driver.  Being broken on PPC is really
the least of their problems.

So, what do we do?  It'd be nice if Linux virtio Just Worked under Xen,
though Xen's IOMMU is outside the virtio spec.  Since virtio_pci can be
a module, obvious hacks like having xen_arch_setup initialize a dma_ops pointer
exposed by virtio_pci.c is out.

I think the best approach is to have a new feature bit (25 is free),
VIRTIO_F_USE_BUS_MAPPING which indicates that a device really wants to
use the mapping for the bus it is on.  A real device would set this,
or it won't work behind an IOMMU.  A Xen device would also set this.

Thoughts?
Rusty.

PS.  I cc'd OASIS virtio-dev: it's subscriber only for IP reasons (to
     subscribe you have to promise we can use your suggestion in the
     standard).  Feel free to remove in any replies, but it's part of
     the world we live in...
