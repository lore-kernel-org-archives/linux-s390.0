From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 2 Sep 2014 14:37:23 -0700
Message-ID: <CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409691213.30640.37.camel@pasglop>
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

On Tue, Sep 2, 2014 at 1:53 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2014-09-01 at 22:55 -0700, Andy Lutomirski wrote:
>>
>> On x86, at least, I doubt that we'll ever see a physically addressed
>> PCI virtio device for which ACPI advertises an IOMMU, since any sane
>> hypervisor will just not advertise an IOMMU for the virtio device.
>> But are there arm64 or PPC guests that use virtio_pci, that have
>> IOMMUs, and that will malfunction if the virtio_pci driver ends up
>> using the IOMMU?  I certainly hope not, since these systems might be
>> very hard-pressed to work right if someone plugged in a physical
>> virtio-speaking PCI device.
>
> It will definitely not work on ppc64. We always have IOMMUs on pseries,
> all PCI busses do, and because it's a paravirtualized environment,
> napping/unmapping pages means hypercalls -> expensive.
>
> But our virtio implementation bypasses it in qemu, so if virtio-pci
> starts using the DMA mapping API without changing the DMA ops under the
> hood, it will break for us.
>

Let's take a step back from from the implementation.  What is a driver
for a virtio PCI device (i.e. a PCI device with vendor 0x1af4)
supposed to do on ppc64?

It can send the device physical addresses and ignore the normal PCI
DMA semantics, which is what the current virtio_pci driver does.  This
seems like a layering violation, and this won't work if the device is
a real PCI device.  Alternatively, it can treat the device like any
other PCI device and use the IOMMU.  This is a bit slower, and it is
also incompatible with current hypervisors.

There really are virtio devices that are pieces of silicon and not
figments of a hypervisor's imagination [1].  We could teach virtio_pci
to use physical addressing on ppc64, but that seems like a pretty
awful hack, and it'll start needing quirks as soon as someone tries to
plug a virtio-speaking PCI card into a ppc64 machine.

Ideas?  x86 and arm seem to be safe here, since AFAIK there is no such
thing as a physically addressed virtio "PCI" device on a bus with an
IOMMU on x86, arm, or arm64.

[1] https://lwn.net/Articles/580186/

> Cheers,
> Ben.
>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
