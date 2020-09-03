Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] PCI/IOV: Mark VFs as not implementing MSE bit
References: <20200903164117.GA312152@bjorn-Precision-5520>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <38f95349-237e-34e2-66ef-e626cd4aec25@linux.ibm.com>
Date: Thu, 3 Sep 2020 13:10:02 -0400
MIME-Version: 1.0
In-Reply-To: <20200903164117.GA312152@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: alex.williamson@redhat.com, bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On 9/3/20 12:41 PM, Bjorn Helgaas wrote:
> On Wed, Sep 02, 2020 at 03:46:34PM -0400, Matthew Rosato wrote:
>> Per the PCIe spec, VFs cannot implement the MSE bit
>> AKA PCI_COMMAND_MEMORY, and it must be hard-wired to 0.
>> Use a dev_flags bit to signify this requirement.
> 
> This approach seems sensible to me, but
> 
>    - This is confusing because while the spec does not use "MSE" to
>      refer to the Command Register "Memory Space Enable" bit
>      (PCI_COMMAND_MEMORY), it *does* use "MSE" in the context of the
>      "VF MSE" bit, which is in the PF SR-IOV Capability.  But of
>      course, you're not talking about that here.  Maybe something like
>      this?
> 
>        For VFs, the Memory Space Enable bit in the Command Register is
>        hard-wired to 0.
> 
>        Add a dev_flags bit to signify devices where the Command
>        Register Memory Space Enable bit does not control the device's
>        response to MMIO accesses.

Will do.  I'll change the usage of the MSE acronym in the other patches 
as well.

> 
>    - "PCI_DEV_FLAGS_FORCE_COMMAND_MEM" says something about how you
>      plan to *use* this, but I'd rather use a term that describes the
>      hardware, e.g., "PCI_DEV_FLAGS_NO_COMMAND_MEMORY".

Sure, I will change.

> 
>    - How do we decide whether to use dev_flags vs a bitfield like
>      dev->is_virtfn?  The latter seems simpler unless there's a reason
>      to use dev_flags.  If there's a reason, maybe we could add a
>      comment at pci_dev_flags for future reference.
> 

Something like:

/*
  * Device does not implement PCI_COMMAND_MEMORY - this is true for any
  * device marked is_virtfn, but is also true for any VF passed-through
  * a lower-level hypervisor where emulation of the Memory Space Enable
  * bit was not provided.
  */
PCI_DEV_FLAGS_NO_COMMAND_MEMORY = (__force pci_dev_flags_t) (1 << 12),

?

>    - Wrap the commit log to fill a 75-char line.  It's arbitrary, but
>      that's what I use for consistency.

Sure, will do.  I'll roll up a new version once I have feedback from 
Alex on the vfio changes.

> 
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   drivers/pci/iov.c   | 1 +
>>   include/linux/pci.h | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index b37e08c..2bec77c 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -180,6 +180,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>>   	virtfn->device = iov->vf_device;
>>   	virtfn->is_virtfn = 1;
>>   	virtfn->physfn = pci_dev_get(dev);
>> +	virtfn->dev_flags |= PCI_DEV_FLAGS_FORCE_COMMAND_MEM;
>>   
>>   	if (id == 0)
>>   		pci_read_vf_config_common(virtfn);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8355306..9316cce 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -227,6 +227,8 @@ enum pci_dev_flags {
>>   	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>>   	/* Don't use Relaxed Ordering for TLPs directed at this device */
>>   	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>> +	/* Device does not implement PCI_COMMAND_MEMORY (e.g. a VF) */
>> +	PCI_DEV_FLAGS_FORCE_COMMAND_MEM = (__force pci_dev_flags_t) (1 << 12),
>>   };
>>   
>>   enum pci_irq_reroute_variant {
>> -- 
>> 1.8.3.1
>>
