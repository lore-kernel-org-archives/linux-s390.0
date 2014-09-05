From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Sat, 06 Sep 2014 01:03:29 +0200
Message-ID: <540A4141.3060703@suse.de>
References: <20140904105223.336503578@de.ibm.com> <1409836584.3804.268.camel@ul30vt.home> <20140905074651.GA43812@tuxmaker.boeblingen.de.ibm.com> <540975EF.8090504@suse.de> <20140905115501.GC17325@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140905115501.GC17325@tuxmaker.boeblingen.de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 05.09.14 13:55, Frank Blaschka wrote:
> On Fri, Sep 05, 2014 at 10:35:59AM +0200, Alexander Graf wrote:
>>
>>
>> On 05.09.14 09:46, Frank Blaschka wrote:
>>> On Thu, Sep 04, 2014 at 07:16:24AM -0600, Alex Williamson wrote:
>>>> On Thu, 2014-09-04 at 12:52 +0200, frank.blaschka@de.ibm.com wrote:
>>>>> This set of patches implements pci pass-through support for qemu/KVM on s390.
>>>>> PCI support on s390 is very different from other platforms.
>>>>> Major differences are:
>>>>>
>>>>> 1) all PCI operations are driven by special s390 instructions
>>>>
>>>> Generating config cycles is always arch specific.
>>>>
>>>>> 2) all s390 PCI instructions are privileged
>>>>
>>>> While the operations to generate config cycles on x86 are not
>>>> privileged, they must be arbitrated between accesses, so in a sense
>>>> they're privileged.
>>>>
>>>>> 3) PCI config and memory spaces can not be mmap'ed
>>>>
>>>> VFIO has mapping flags that allow any region to specify mmap support.
>>>>
>>>
>>> Hi Alex,
>>>
>>> thx for your reply.
>>>
>>> Let me elaborate a little bit ore on 1 - 3. Config and memory space can not
>>> be accessed via memory operations. You have to use special s390 instructions.
>>> This instructions can not be executed in user space. So there is no other
>>> way than executing this instructions in kernel. Yes vfio does support a
>>> slow path via ioctrl we could use, but this seems suboptimal from performance
>>> point of view.
>>
>> Ah, I missed the "memory spaces" part ;). I agree that it's "suboptimal"
>> to call into the kernel for every PCI access, but I still think that
>> VFIO provides the correct abstraction layer for us to use. If nothing
>> else, it would at least give us identical configuration to x86 and nice
>> debugability en par with the other platforms.
>>
>>>  
>>>>> 4) no classic interrupts (INTX, MSI). The pci hw understands the concept
>>>>>    of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.
>>>>
>>>> VFIO delivers interrupts as eventfds regardless of the underlying
>>>> platform mechanism.
>>>>
>>>
>>> yes that's right, but then we have to do platform specific stuff to present
>>> the irq to the guest. I do not say this is impossible but we have add s390
>>> specific code to vfio. 
>>
>> Not at all - interrupt delivery is completely transparent to VFIO.
>>
> 
> interrupt yes, but MSIX no
>  
>>>
>>>>> 5) For DMA access there is always an IOMMU required.
>>>>
>>>> x86 requires the same.
>>>>
>>>>>  s390 pci implementation
>>>>>    does not support a complete memory to iommu mapping, dma mappings are
>>>>>    created on request.
>>>>
>>>> Sounds like POWER.
>>>
>>> Don't know the details from power, maybe it is similar but not the same.
>>> We might be able to extend vfio to have a new interface allowing
>>> us to do DMA mappings on request.
>>
>> We already have that.
>>
> 
> Great, can you give me some pointers how to use? Thx!

Sure! :)

So on POWER (sPAPR) you get a list of page entries that describe the
device -> ram mapping. Every time you want to modify any of these
entries, you need to invoke a hypercall (H_PUT_TCE).

So every time the guest wants to runtime add a DMA window, we trap into
put_tce_emu() in hw/ppc/spapr_iommu.c. Here we call
memory_region_notify_iommu().

This call goes either to an emulated IOMMU context for emulated devices
or to the special VFIO IOMMU context for VFIO devices.

In the VFIO case, we end up in vfio_iommu_map_notify() at hw/misc/vfio.c
which calls ioctl(VFIO_IOMMU_MAP_DMA) at the end of the day. The
in-kernel implementation of the host IOMMU provider uses this map to
create the virtual DMA window map.

Basically, VFIO *only* supports "DMA mappings on request" as you call
them. Prepopulated DMA windows are just a coincidence that may or may
not happen.

I hope that makes it slightly more clear what the path looks like :). If
you have more questions on this, don't hesitate to ask.


Alex
