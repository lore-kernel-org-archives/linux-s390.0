From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 10 Sep 2014 11:36:51 -0400
Message-ID: <54107013.2030701@codeaurora.org>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<874mwpkxxi.fsf@rustcorp.com.au>
	<CALCETrWMc6TQy02kLXLcLwMJbPkpY4yv7U-As6jv0Frx34nuww@mail.gmail.com>
	<87lhpykdbu.fsf@rustcorp.com.au>
	<CALCETrX7feY6f-iVEgdxp-YPNNPctRjQr=KyByyPRgiW1xKUdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrX7feY6f-iVEgdxp-YPNNPctRjQr=KyByyPRgiW1xKUdA@mail.gmail.com>
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
Cc: virtio-dev@lists.oasis-open.org, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/04/2014 10:57 PM, Andy Lutomirski wrote:
> On Thu, Sep 4, 2014 at 7:31 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Andy Lutomirski <luto@amacapital.net> writes:
>>> On Sep 2, 2014 11:53 PM, "Rusty Russell" <rusty@rustcorp.com.au> wrote:
>>>>
>>>> Andy Lutomirski <luto@amacapital.net> writes:
>>>>> There really are virtio devices that are pieces of silicon and not
>>>>> figments of a hypervisor's imagination [1].
>>>>
>>>> Hi Andy,
>>>>
>>>>         As you're discovering, there's a reason no one has done the DMA
>>>> API before.
>>>>
>>>> So the problem is that ppc64's IOMMU is a platform thing, not a bus
>>>> thing.  They really do carve out an exception for virtio devices,
>>>> because performance (LOTS of performance).  It remains to be seen if
>>>> other platforms have the same performance issues, but in absence of
>>>> other evidence, the answer is yes.
>>>>
>>>> It's a hack.  But having specific virtual-only devices are an even
>>>> bigger hack.
>>>>
>>>> Physical virtio devices have been talked about, but don't actually exist
>>>> in Real Life.  And someone a virtio PCI card is going to have serious
>>>> performance issues: mainly because they'll want the rings in the card's
>>>> MMIO region, not allocated by the driver.  Being broken on PPC is really
>>>> the least of their problems.
>>>>
>>>> So, what do we do?  It'd be nice if Linux virtio Just Worked under Xen,
>>>> though Xen's IOMMU is outside the virtio spec.  Since virtio_pci can be
>>>> a module, obvious hacks like having xen_arch_setup initialize a dma_ops pointer
>>>> exposed by virtio_pci.c is out.
>>>
>>> Xen does expose dma_ops.  The trick is knowing when to use it.
>>>
>>>>
>>>> I think the best approach is to have a new feature bit (25 is free),
>>>> VIRTIO_F_USE_BUS_MAPPING which indicates that a device really wants to
>>>> use the mapping for the bus it is on.  A real device would set this,
>>>> or it won't work behind an IOMMU.  A Xen device would also set this.
>>>
>>> The devices I care about aren't actually Xen devices.  They're devices
>>> supplied by QEMU/KVM, booting a Xen hypervisor, which in turn passes
>>> the virtio device (along with every other PCI device) through to dom0.
>>> So this is exactly the same virtio device that regular x86 KVM guests
>>> would see.  The reason that current code fails is that Xen guest
>>> physical addresses aren't the same as the addresses seen by the outer
>>> hypervisor.
>>>
>>> These devices don't know that physical addresses != bus addresses, so
>>> they can't advertise that fact.
>>
>> Ah, I see.  Then we will need a Xen-specific hack.
>>
>>> Grr.  This is mostly a result of the fact that virtio_pci devices
>>> aren't really PCI devices.  I still think that virtio_pci shouldn't
>>> have to worry about this; ideally this would all be handled higher up
>>> in the device hierarchy.  x86 already gets this right.
>>
>> Yes.  Adding a feature to say "I am a real PCI device" is possible, but
>> has other issues (particularly as Michael Tsirkin pointed out, what do
>> you do if the driver doesn't understand the feature).
>>
>>> Are there any hypervisors except PPC that use virtio_pci, have IOMMUs
>>> on the pci slot that virtio_pci lives in, and that use physical
>>> addressing?  If not, I think that just quirking PPC will work (at
>>> least until someone wants IOMMU support in virtio_pci on PPC, in which
>>> case doing something using devicetree seems like a reasonable
>>> solution).
>>
>> We can either patch to make PPC weird or make Xen weird.  I'm on the
>> fence.
>>
>> Two questions for Paulo:
>> 1) When QEMU support IOMMU on x86, will the virtio devices behind it
>>    respect the IOMMU (do they use the right memory access primitives?).
>>
>> 2) Are we really going to be able to exclude virtio devices from using
>>    the x86 IOMMU in a portable way which will always work?  If it's
>>    per-bus granularity, will qemu really put them on their own PCI bus
>>    and get this right?  Or will it sometimes get it wrong and users will
>>    end up using virtio devices via IOMMU by accident?
>>
>> If the answers are both "yes", then x86 is going to be able to use
>> virtio+IOMMU, so PPC looks like the odd one out.  Otherwise it looks
>> like we're really going to want to stick with the "ignore IOMMU" rule
>> until (handwave future), and we make an exception for Xen.
> 
> There's a third option: try to make virtio-mmio work everywhere
> (except s390), at least in the long run.  This other benefits: it
> makes minimal hypervisors simpler, I think it'll get rid of the limits
> on the number of virtio devices in a system.  ARM is already going
> this direction, and I imagine that PPC support would be
> straightforward (it's already using devicetree).

In my opinion, a uniform "virt" machine for every instruction set would be
very beneficial. I would guess that MMIO is more universally available than
PCI, and as you point out, simpler to implement.

> Does virtio-mmio have any reasonable way of doing hotplug?  It could
> also eventually make sense to have a standard for virtio on virtio.

I don't think so, but it seems possible. My bystander understanding is that
QEMU allocates some fixed number of VirtIO-MMIO devices, maybe a dozen, in the
device tree. The ones that don't actually get hooked up to something real like
a block device or network interface are populated with a dummy device. One
naive approach might be to allow the dummy devices to tell the kernel that
they are now changing to a real device.

Also, higher level hotplug for at least SCSI sounds possible.

https://bugzilla.redhat.com/show_bug.cgi?id=1123390

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
