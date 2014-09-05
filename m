From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Fri, 05 Sep 2014 10:35:59 +0200
Message-ID: <540975EF.8090504@suse.de>
References: <20140904105223.336503578@de.ibm.com> <1409836584.3804.268.camel@ul30vt.home> <20140905074651.GA43812@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140905074651.GA43812@tuxmaker.boeblingen.de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Frank Blaschka <blaschka@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 05.09.14 09:46, Frank Blaschka wrote:
> On Thu, Sep 04, 2014 at 07:16:24AM -0600, Alex Williamson wrote:
>> On Thu, 2014-09-04 at 12:52 +0200, frank.blaschka@de.ibm.com wrote:
>>> This set of patches implements pci pass-through support for qemu/KVM on s390.
>>> PCI support on s390 is very different from other platforms.
>>> Major differences are:
>>>
>>> 1) all PCI operations are driven by special s390 instructions
>>
>> Generating config cycles is always arch specific.
>>
>>> 2) all s390 PCI instructions are privileged
>>
>> While the operations to generate config cycles on x86 are not
>> privileged, they must be arbitrated between accesses, so in a sense
>> they're privileged.
>>
>>> 3) PCI config and memory spaces can not be mmap'ed
>>
>> VFIO has mapping flags that allow any region to specify mmap support.
>>
> 
> Hi Alex,
> 
> thx for your reply.
> 
> Let me elaborate a little bit ore on 1 - 3. Config and memory space can not
> be accessed via memory operations. You have to use special s390 instructions.
> This instructions can not be executed in user space. So there is no other
> way than executing this instructions in kernel. Yes vfio does support a
> slow path via ioctrl we could use, but this seems suboptimal from performance
> point of view.

Ah, I missed the "memory spaces" part ;). I agree that it's "suboptimal"
to call into the kernel for every PCI access, but I still think that
VFIO provides the correct abstraction layer for us to use. If nothing
else, it would at least give us identical configuration to x86 and nice
debugability en par with the other platforms.

>  
>>> 4) no classic interrupts (INTX, MSI). The pci hw understands the concept
>>>    of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.
>>
>> VFIO delivers interrupts as eventfds regardless of the underlying
>> platform mechanism.
>>
> 
> yes that's right, but then we have to do platform specific stuff to present
> the irq to the guest. I do not say this is impossible but we have add s390
> specific code to vfio. 

Not at all - interrupt delivery is completely transparent to VFIO.

> 
>>> 5) For DMA access there is always an IOMMU required.
>>
>> x86 requires the same.
>>
>>>  s390 pci implementation
>>>    does not support a complete memory to iommu mapping, dma mappings are
>>>    created on request.
>>
>> Sounds like POWER.
> 
> Don't know the details from power, maybe it is similar but not the same.
> We might be able to extend vfio to have a new interface allowing
> us to do DMA mappings on request.

We already have that.

> 
>>
>>> 6) The OS does not get any informations about the physical layout
>>>    of the PCI bus.
>>
>> If that means that every device is isolated (seems unlikely for
>> multifunction devices) then that makes IOMMU group support really easy.
>>
> 
> OK
>  
>>> 7) To take advantage of system z specific virtualization features
>>>    we need to access the SIE control block residing in the kernel KVM
>>
>> The KVM-VFIO device allows interaction between VFIO devices and KVM.
>>
>>> 8) To enable system z specific virtualization features we have to manipulate
>>>    the zpci device in kernel.
>>
>> VFIO supports different device backends, currently pci_dev and working
>> towards platform devices.  zpci might just be an extension to standard
>> pci.
>>
> 
> 7 - 8 At least this is not as straightforward as the pure kernel approach, but
> I have to dig into that in more detail if we could only agree on a vfio solution.

Please do so, yes :).

> 
>>> For this reasons I decided to implement a kernel based approach similar
>>> to x86 device assignment. There is a new qemu device (s390-pci) representing a
>>> pass through device on the host. Here is a sample qemu device configuration:
>>>
>>> -device s390-pci,host=0000:00:00.0
>>>
>>> The device executes the KVM_ASSIGN_PCI_DEVICE ioctl to create a proxy instance
>>> in the kernel KVM and connect this instance to the host pci device.
>>>
>>> kernel patches apply to linux-kvm
>>>
>>> s390: cio: chsc function to register GIB
>>> s390: pci: export pci functions for pass-through usage
>>> KVM: s390: Add GISA support
>>> KVM: s390: Add PCI pass-through support
>>>
>>> qemu patches apply to qemu-master
>>>
>>> s390: Add PCI bus support
>>> s390: Add PCI pass-through device support
>>>
>>> Feedback and discussion is highly welcome ...
>>
>> KVM-based device assignment needs to go away.  It's a horrible model for
>> devices, it offers very little protection to the kernel, assumes every
>> device is fully isolated and visible to the IOMMU, relies on smattering
>> of sysfs files to operate, etc.  x86, POWER, and ARM are all moving to
>> VFIO-based device assignment.  Why is s390 special enough to repeat all
>> the mistakes that x86 did?  Thanks,
>>
> 
> Is this your personal opinion or was this a strategic decision of the
> QEMU/KVM community? Can anybody give us direction about this?
> 
> Actually I can understand your point. In the last weeks I did some development
> and testing regarding the use of vfio too. But the in kernel solutions seems to
> offer the best performance and most straighforward implementation for our
> platform.

I don't see why there should be any difference in performance between
the two approaches if done right. However, we'd get a lot of benefits.
Most notably the fact that s390 is not different from everyone else.

I think you'll see that it's pretty straight forward to do things VFIO
style once you get the hang of it :).


Alex
