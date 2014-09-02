From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 2 Sep 2014 16:11:35 -0700
Message-ID: <CALCETrXA0Po5mhLWDn41_sT+zBwbo7Rzm5Nqxdmao-MbtfKvmQ@mail.gmail.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<1409695810.30640.57.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409695810.30640.57.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 2, 2014 at 3:10 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2014-09-02 at 14:37 -0700, Andy Lutomirski wrote:
>
>> Let's take a step back from from the implementation.  What is a driver
>> for a virtio PCI device (i.e. a PCI device with vendor 0x1af4)
>> supposed to do on ppc64?
>
> Today, it's supposed to send guest physical addresses. We can make that
> optional via some nego or capabilities to support more esoteric setups
> but for backward compatibility, this must remain the default behaviour.

I think it only needs to remain the default in cases where the
alternative (bus addressing) won't work.  I think that, so far, this
is just ppc64.  But see below...

>
> My suggestion was that it might be a cleaner approach to do that by
> having the individual virtio drivers always use the dma_map_* API, and
> limiting the kludgery to a combination of virtio_pci "core" and arch
> code by selecting an appropriate set of dma_map_ops, defaulting with a
> "transparent" (or direct) one as our current default case (and thus
> overriding the iommu ones provided by the arch).

I think the cleanest way of all would be to get the bus drivers to do
the right thing so that all of the virtio code can just use the dma
api.  I don't know whether this is achievable.

>
>>   We could teach virtio_pci
>> to use physical addressing on ppc64, but that seems like a pretty
>> awful hack, and it'll start needing quirks as soon as someone tries to
>> plug a virtio-speaking PCI card into a ppc64 machine.
>
> But x86_64 is the same no ? The day it starts growing an iommu emulation
> in qemu (and I've heard it's happening) it will still want to do direct
> bypass for virtio for performance.

I don't think so.  I would argue that it's a straight-up bug for QEMU
to expose a physically-addressed virtio-pci device to the guest behind
an emulated IOMMU.  QEMU may already be doing that on ppc64, but it
isn't on x86_64 or arm (yet).

On x86_64, I'm pretty sure that QEMU can emulate an IOMMU for
everything except the virtio-pci devices.  The ACPI DMAR stuff is
quite expressive.

On ARM, I hope the QEMU will never implement a PCI IOMMU.  As far as I
could tell when I looked last week, none of the newer QEMU-emulated
ARM machines even support PCI.  Even if QEMU were to implement a PCI
IOMMU on some future ARM machine, it could continue using virtio-mmio
for virtio devices.

So ppc might actually be the only system that has or will have
physically-addressed virtio PCI devices that are behind an IOMMU.  Can
this be handled in a ppc64-specific way?  Is there any way that the
kernel can distinguish a QEMU-provided virtio PCI device from a
physical PCIe thing?  It would be kind of nice to address this without
adding complexity to the virtio spec.  Maybe virtio 1.0 devices could
be assumed to use bus addressing unless a new devicetree property says
otherwise.

--Andy
