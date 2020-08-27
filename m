Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5492 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbgH0TVh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 15:21:37 -0400
Subject: Re: [PATCH v3] PCI: Introduce flag for detached virtual functions
References: <20200827183138.GA1929779@bjorn-Precision-5520>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <69a78288-9d19-7ffd-4690-28140688fa3f@linux.ibm.com>
Date: Thu, 27 Aug 2020 15:21:23 -0400
MIME-Version: 1.0
In-Reply-To: <20200827183138.GA1929779@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: alex.williamson@redhat.com, bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On 8/27/20 2:31 PM, Bjorn Helgaas wrote:
> Re the subject line, this patch does a lot more than just "introduce a
> flag"; AFAICT it actually enables important VFIO functionality, e.g.,
> something like:
> 
>    vfio/pci: Enable MMIO access for s390 detached VFs
> 

Fair -- maybe s/Enable/Restore/ as this functionality had been working 
until the mem bit enforcement was added to vfio via abafbc551fdd.

> On Thu, Aug 13, 2020 at 11:40:43AM -0400, Matthew Rosato wrote:
>> s390x has the notion of providing VFs to the kernel in a manner
>> where the associated PF is inaccessible other than via firmware.
>> These are not treated as typical VFs and access to them is emulated
>> by underlying firmware which can still access the PF.  After
>> the referened commit however these detached VFs were no longer able
>> to work with vfio-pci as the firmware does not provide emulation of
>> the PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
>> these detached VFs so that vfio-pci can allow memory access to
>> them again.
> 
> Out of curiosity, in what sense is the PF inaccessible?  Is it
> *impossible* for Linux to access the PF, or is it just not enumerated
> by clp_list_pci() so Linux doesn't know about it?

So, it is not enumerated via clp_list_pci because it is not assigned to 
the host partition -- So while it is physically available to the machine 
and the firmware can see it, the machine is divided up into multiple 
logical partitions -- The partition where we are running the host kernel 
in this scenario has no access to the PF.  Basically, think bare metal 
hypervisor and only the VF was passed through to the kernel guest.

> VFs do not implement PCI_COMMAND, so I guess "firmware does not
> provide emulation of PCI_COMMAND_MEMORY" means something like "we
> can't access the PF so we can't enable/disable PCI_COMMAND_MEMORY"?
> 

So, the root issue is that vfio-pci added enforcement of the bit via 
abafbc551fdd -- Then subsequently waived the requirement for VFs via 
bugfix ebfa440ce38b since as you say it can't be on for VFs per the PCIe 
spec -- Problem is, vfio can't tell these devices are VFs because 
is_virtfn=0 for these devices.

Fundamentally, I am trying to find a proper way to tell vfio it's OK to 
waive the requirement for these devices too.

> s/referened/referenced/
> 
>> Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access on disabled memory")
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   arch/s390/pci/pci_bus.c            | 13 +++++++++++++
>>   drivers/vfio/pci/vfio_pci_config.c |  8 ++++----
>>   include/linux/pci.h                |  4 ++++
>>   3 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
>> index 642a993..1b33076 100644
>> --- a/arch/s390/pci/pci_bus.c
>> +++ b/arch/s390/pci/pci_bus.c
>> @@ -184,6 +184,19 @@ static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
>>   }
>>   #endif
>>   
>> +void pcibios_bus_add_device(struct pci_dev *pdev)
>> +{
>> +	struct zpci_dev *zdev = to_zpci(pdev);
>> +
>> +	/*
>> +	 * If we have a VF on a non-multifunction bus, it must be a VF that is
>> +	 * detached from its parent PF.  We rely on firmware emulation to
>> +	 * provide underlying PF details.
> 
> What exactly does "multifunction bus" mean?  I'm familiar with
> multi-function *devices*, but not multi-function buses.
> 

So, this flag is effectively stating whether proper SR-IOV support is 
available for devices on the bus.  This is an interesting point though, 
I don't think this will catch all instances of this scenario (vs a 
more-direct check for a device that has a vfn but no linked PF).  I need 
to look at this again, thanks.

>> +	 */
>> +	if (zdev->vfn && !zdev->zbus->multifunction)
>> +		pdev->detached_vf = 1;
>> +}
>> +
>>   static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
>>   {
>>   	struct pci_bus *bus;
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index d98843f..98f93d1 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -406,7 +406,7 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
>>   	 * PF SR-IOV capability, there's therefore no need to trigger
>>   	 * faults based on the virtual value.
>>   	 */
>> -	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
>> +	return dev_is_vf(&pdev->dev) || (cmd & PCI_COMMAND_MEMORY);
> 
> I'm not super keen on the idea of having two subtly different ways of
> identifying VFs.  I think that will be confusing.  This seems to be
> the critical line, so whatever we do here, it will be out of the
> ordinary and probably deserves a little comment.
> 

Another notion that Alex floated was the idea of tagging these devices 
that don't implement the PCI_COMMAND_MEMORY bit via a dev_flags bit 
rather than changing the way we identify VFs.  It's grown on me and I've 
tried it out as an alternative.  Does this sort of approach sound better?

> If Linux doesn't see the PF, does pci_physfn(VF) return NULL, i.e., is
> VF->physfn NULL?
> 

pci_physfn(VF) == VF because is_virtfn=0 for these devices.
