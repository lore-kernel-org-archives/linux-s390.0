From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 2 Sep 2014 16:42:15 -0700
Message-ID: <CALCETrWTwoBLj6onvNWOrwvY_n3-rWx0KifR0xP7091Vd-xHbg@mail.gmail.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<1409695810.30640.57.camel@pasglop>
	<CALCETrXA0Po5mhLWDn41_sT+zBwbo7Rzm5Nqxdmao-MbtfKvmQ@mail.gmail.com>
	<1409700010.30640.67.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409700010.30640.67.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 2, 2014 at 4:20 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> On Tue, 2014-09-02 at 16:11 -0700, Andy Lutomirski wrote:
>
>> I don't think so.  I would argue that it's a straight-up bug for QEMU
>> to expose a physically-addressed virtio-pci device to the guest behind
>> an emulated IOMMU.  QEMU may already be doing that on ppc64, but it
>> isn't on x86_64 or arm (yet).
>
> Last I looked, it does on everything, it bypasses the DMA layer in qemu
> which is where IOMMUs are implemented.

I believe you, but I'm not convinced that this means much from the
guest's POV, except on ppc64.

>
>> On x86_64, I'm pretty sure that QEMU can emulate an IOMMU for
>> everything except the virtio-pci devices.  The ACPI DMAR stuff is
>> quite expressive.
>
> Well, *except* virtio, exactly...

But there aren't any ACPI systems with both virtio-pci and IOMMUs,
right?  So we could say that, henceforth, ACPI systems must declare
whether virtio-pci devices live behind IOMMUs without breaking
backward compatibility.

>
>> On ARM, I hope the QEMU will never implement a PCI IOMMU.  As far as I
>> could tell when I looked last week, none of the newer QEMU-emulated
>> ARM machines even support PCI.  Even if QEMU were to implement a PCI
>> IOMMU on some future ARM machine, it could continue using virtio-mmio
>> for virtio devices.
>
> Possibly...
>
>> So ppc might actually be the only system that has or will have
>> physically-addressed virtio PCI devices that are behind an IOMMU.  Can
>> this be handled in a ppc64-specific way?
>
> I wouldn't be so certain, as I said, the way virtio is implemented in
> qemu bypass the DMA layer which is where IOMMUs sit. The fact that
> currently x86 doesn't put an IOMMU there is not even garanteed, is it ?
> What happens if you try to mix and match virtio and other emulated
> devices that require the iommu on the same bus ?

AFAIK QEMU doesn't support IOMMUs at all on x86, so current versions
of QEMU really do guarantee that virtio-pci on x86 has no IOMMU, even
if that guarantee is purely accidental.

>
> If we could discriminate virtio devices to a specific host bridge and
> guarantee no mix & match, we could probably add a concept of
> "IOMMU-less" bus but that would require guest changes which limits the
> usefulness.
>
>>   Is there any way that the
>> kernel can distinguish a QEMU-provided virtio PCI device from a
>> physical PCIe thing?
>
> Not with existing guests which cannot be changed. Existing distros are
> out with those drivers. If we add a backward compatibility mechanism,
> then we could add something yes, provided we can segregate virtio onto a
> dedicated host bridge (which can be a problem with the libvirt
> trainwreck...)

Ugh.

So here's an ugly proposal:

Step 1: Make virtio-pci use the DMA API only on x86.  This will at
least fix Xen and people experimenting with virtio hardware on x86,
and it won't break anything, since there are no emulated IOMMUs on
x86.

Step 2: Update the virtio spec.  Virtio 1.0 PCI devices should set a
new bit if they are physically addressed.  If that bit is clear, then
the device is assumed to be addressed in accordance with the
platform's standard addressing model for PCI.  Presumably this would
be something like VIRTIO_F_BUS_ADDRESSING = 33, and the spec would say
something like "Physical devices compatible with this specification
MUST offer VIRTIO_F_BUS_ADDRESSING.  Drivers MUST implement this
feature."  Alternatively, this could live in a PCI configuration
capability.

Step 3: Update virtio-pci to use the DMA API for all devices on x86
and for devices that advertise bus addressing on other architectures.

I think this proposal will work, but I also think it sucks and I'd
really like to see a better counter-proposal.


--Andy
