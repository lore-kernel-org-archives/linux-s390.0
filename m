From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 12:24:03 -0700
Message-ID: <CALCETrVeT-M+qMxXwDUB50xnFW1B6yu+ofiX-ydvtjaGgRLUNA@mail.gmail.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
	<20150728160358-mutt-send-email-mst@redhat.com>
	<55B77F8C.7010804@siemens.com>
	<CALCETrVF1-=z60bCtsMBctbd14zjJgpUPNNo+EcJj_fXhww1og@mail.gmail.com>
	<55B7B15C.4010101@siemens.com>
	<CALCETrW_7tmUg1zf3m1xYeSruW8njNYP9N4s8tBKJcTGJf_0QA@mail.gmail.com>
	<55B7B91E.40200@siemens.com>
	<CALCETrWUVQWQ=mydbdiSJnA0uLSFarVYCnWWKpcgYD0A8hpfXQ@mail.gmail.com>
	<55B7D2A9.6040700@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55B7D2A9.6040700@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel <Xen-devel@lists.xen.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 28, 2015 at 12:06 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2015-07-28 20:22, Andy Lutomirski wrote:
>> On Tue, Jul 28, 2015 at 10:17 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> On 2015-07-28 19:10, Andy Lutomirski wrote:
>>>> The trouble is that this is really a property of the bus and not of
>>>> the device.  If you build a virtio device that physically plugs into a
>>>> PCIe slot, the device has no concept of an IOMMU in the first place.
>>>
>>> If one would build a real virtio device today, it would be broken
>>> because every IOMMU would start to translate its requests. Already from
>>> that POV, we really need to introduce a feature flag "I will be
>>> IOMMU-translated" so that a potential physical implementation can carry
>>> it unconditionally.
>>>
>>
>> Except that, with my patches, it would work correctly.  ISTM the thing
>
> I haven't looked at your patches yet - they make the virtio PCI driver
> in Linux IOMMU-compatible? Perfect - except for a compatibility check,
> right?

Yes.  (virtio_pci_legacy, anyway.  Presumably virtio_pci_modern is
easy to adapt, too.)

>
>> that's broken right now is QEMU and the virtio_pci driver.  My patches
>> fix the driver.  Last year that would have been the end of the story
>> except for PPC.  Now we have to deal with QEMU.
>>
>>>> Similarly, if you take an L0-provided IOMMU-supporting device and pass
>>>> it through to L2 using current QEMU on L1 (with Q35 emulation and
>>>> iommu enabled), then, from L2's perspective, the device is 1:1 no
>>>> matter what the device thinks.
>>>>
>>>> IOW, I think the original design was wrong and now we have to deal
>>>> with it.  I think the best solution would be to teach QEMU to fix its
>>>> ACPI tables so that 1:1 virtio devices are actually exposed as 1:1.
>>>
>>> Only the current drivers are broken. And we can easily tell them apart
>>> from newer ones via feature flags. Sorry, don't get the problem.
>>
>> I still don't see how feature flags solve the problem.  Suppose we
>> added a feature flag meaning "respects IOMMU".
>>
>> Bad case 1:  Build a malicious device that advertises
>> non-IOMMU-respecting virtio.  Plug it in behind an IOMMU.  Host starts
>> leaking physical addresses to the device (and the device doesn't work,
>> of course).  Maybe that's only barely a security problem, but still...
>
> I don't see right now how critical such a hypothetical case could be.
> But the OS / its drivers could still decide to refuse talking to such a
> device.
>

How does OS know it's such a device as opposed to a QEMU-supplied thing?

>>
>> Bad case 2: Some hypothetical well-behaved new QEMU provides a virtio
>> device that *does* respect the IOMMU and sets the feature flag.  They
>> emulate Q35 with an IOMMU.  They boot Linux 4.1.  Data corruption in
>> the guest.
>
> No. In that case, the feature negotiation of "virtio-with-iommu-support"
> would have failed for older drivers, and the device would have never
> been used by the guest.

So are you suggesting that newer virtio devices always provide this
feature flag and, if supplied by QEMU with iommu=on, simply refuse to
operate of the driver doesn't support that flag?

That could work as long as QEMU with the current (broken?) iommu=on
never exposes such a device.

>
>>
>> We could make the rule that *all* virtio-pci devices (except on PPC)
>> respect the bus rules.  We'd have to fix QEMU so that virtio devices
>> on Q35 iommu=on systems set up a PCI topology where the devices
>> *aren't* behind the IOMMU or are protected by RMRRs or whatever.  Then
>> old kernels would work correctly on new hosts, new kernels would work
>> correctly except on old iommu-providing hosts, and Xen would work.
>
> I don't see a point in doing anything about old QEMU with IOMMU enabled
> and virtio devices plugged except declaring such setups broken. No one
> should have configured this for production purposes, only for test
> setups (like we, with the knowledge about the limitations).
>

I'm fine with that.  In fact, I proposed these patches before QEMU had
this feature in the first place.

>>
>> In fact, on Xen, it's impossible without colossal hacks to support
>> non-IOMMU-respecting virtio devices because Xen acts as an
>> intermediate IOMMU between the Linux dom0 guest and the actual host.
>> The QEMU host doesn't even know that Xen is involved.  This is why Xen
>> and virtio don't currently work together (without my patches): the
>> device thinks it doesn't respect the IOMMU, the driver thinks the
>> device doesn't respect the IOMMU, and they're both wrong.
>>
>> TL;DR: I think there are only two cases.  Either a device respects the
>> IOMMU or a device doesn't know whether it respects the IOMMU.  The
>> latter case is problematic.
>
> See above, the latter is only problematic on setups that actually use an
> IOMMU. If that includes Xen, then no one should use it until virtio can
> declare itself IOMMU compatible, and drivers exist that process this.

Xen works right now with my patches on standard QEMU (as long as
iommu=off).  Certainly no one except me uses it now with virtio
because it doesn't work with mainline kernels.

If we apply something similar enough to my patches, then even old
hypervisors (e.g. Amazon's hardware virt systems) will support Xen
with virtio devices passed in just fine.

--Andy
