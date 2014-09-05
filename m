From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Sat, 06 Sep 2014 01:19:14 +0200
Message-ID: <540A44F2.3040803@suse.de>
References: <20140904105223.336503578@de.ibm.com> <54097287.1000006@suse.de> <20140905113954.GB17325@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140905113954.GB17325@tuxmaker.boeblingen.de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 05.09.14 13:39, Frank Blaschka wrote:
> On Fri, Sep 05, 2014 at 10:21:27AM +0200, Alexander Graf wrote:
>>
>>
>> On 04.09.14 12:52, frank.blaschka@de.ibm.com wrote:
>>> This set of patches implements pci pass-through support for qemu/KVM on s390.
>>> PCI support on s390 is very different from other platforms.
>>> Major differences are:
>>>
>>> 1) all PCI operations are driven by special s390 instructions
>>> 2) all s390 PCI instructions are privileged
>>> 3) PCI config and memory spaces can not be mmap'ed
>>
>> That's ok, vfio abstracts config space anyway.
>>
>>> 4) no classic interrupts (INTX, MSI). The pci hw understands the concept
>>>    of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.
>>
>> This is in line with other implementations. Interrupts go from
>>
>>   device -> PHB -> PIC -> CPU
>>
>> (some times you can have another converter device in between)
>>
>> In your case, the PHB converts INTX and MSI interrupts to Adapter
>> interrupts to go to the floating interrupt controller. Same thing as
>> everyone else really.
>>
> 
> Yes, I think this can be done, but we need s390 specific changes in vfio.
> 
>>> 5) For DMA access there is always an IOMMU required. s390 pci implementation
>>>    does not support a complete memory to iommu mapping, dma mappings are
>>>    created on request.
>>
>> Sounds great :). So I suppose we should implement a guest facing IOMMU?
>>
>>> 6) The OS does not get any informations about the physical layout
>>>    of the PCI bus.
>>
>> So how does it know whether different devices are behind the same IOMMU
>> context? Or can we assume that every device has its own context?
> 
> Actually yes

That greatly simplifies things. Awesome :).

> 
>>
>>> 7) To take advantage of system z specific virtualization features
>>>    we need to access the SIE control block residing in the kernel KVM
>>
>> Pleas elaborate.
>>
>>> 8) To enable system z specific virtualization features we have to manipulate
>>>    the zpci device in kernel.
>>
>> Why?
>>
> 
> We have following s390 specific virtualization features:
> 
> 1) interpretive execution of pci load/store instruction. If we use this function
>    pci access does not get intercepted (no SIE exit) but is handled via microcode.
>    To enable this we have to disable zpci device and enable it again with information
>    from the SIE control block.

Hrm. So how about you create a special vm ioctl for KVM that allows you
to attach a VFIO device fd into the KVM VM context? Then the default
would stay "accessible by mmap traps", but we could accelerate it with KVM.

>    Further in qemu problem is: vfio traps access to
>    MSIX table so we have to find another way programming msix if we do not get
>    intercepts for memory space access.

We trap access to the MSIX table because it's a shared resource. If it's
not shared for you, there's no need to trap it.

> 2) Adapter event forwarding (with alerting). This is a mechanism the adpater event (irq)
>    is directly forwarded to the guest. To set this up we also need to manipulate
>    the zpci device (in kernel) with information form the SIE block. Exploiting
>    GISA is only one part of this mechanism.

How does this work when the VM is not running (because it's idle)?

Either way, we have a very similar thing on x86. It's called "posted
interrupts" there. I'm not sure everything's in place for VFIO and
posted interrupts to work properly, but whatever we do it sounds like
the interfaces and configuration flow should be identical.

> Both might be possible with some more or less nice looking vfio extensions. As I said
> before we have to dig more into. Also this can be further optimazation steps later
> if we have a running vfio implementation on the platform. 

Yup :). That's the nice part about it.

>  
>>>
>>> For this reasons I decided to implement a kernel based approach similar
>>> to x86 device assignment. There is a new qemu device (s390-pci) representing a
>>
>> I fail to see the rationale and I definitely don't want to see anything
>> even remotely similar to the legacy x86 device assignment on s390 ;).
>>
>> Can't we just enhance VFIO?
>>
> 
> Probably yes, but we need some vfio changes (kernel and qemu)

We need changes either way ;). So let's better do the right ones.

> 
>> Also, I think we'll get the cleanest model if we start off with an
>> implementation that allows us to add emulated PCI devices to an s390x
>> machine and only then follow on with physical ones.
>>
> 
> I can already do this. With some more s390 intercepts a device can be detected and
> guest is able to access config/memory space. Unfortunately s390 platform does not
> support I/O bars so non of the emulated devices will work on the platform ...

Oh? How about "nec-usb-xhci" or "intel-hda"?


Alex
