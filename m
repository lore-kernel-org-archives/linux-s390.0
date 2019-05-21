Return-Path: <SRS0=A95w=TV=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
 VFIO_IOMMU_INFO_CAPABILITIES
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
 <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
 <20190517104143.240082b5@x1.home>
 <92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
 <ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
 <20190520162737.7560ad7c.cohuck@redhat.com>
 <23f6a739-be4f-7eda-2227-2994fdc2325a@linux.ibm.com>
 <20190520122352.73082e52@x1.home>
 <9dc0a8de-b850-df21-e3b7-21b7c2a373a3@linux.ibm.com>
 <20190521131120.0b2afb37.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 21 May 2019 14:46:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190521131120.0b2afb37.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <6216c287-c741-0600-d5b7-cbdaf2214661@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

On 21/05/2019 13:11, Cornelia Huck wrote:
> On Tue, 21 May 2019 11:14:38 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> 1) A short description, of zPCI functions and groups
>>
>> IN Z, PCI cards, leave behind an adapter between subchannels and PCI.
>> We access PCI cards through 2 ways:
>> - dedicated PCI instructions (pci_load/pci_store/pci/store_block)
>> - DMA
> 
> Quick question: What about the new pci instructions? Anything that
> needs to be considered there?

No and yes.

No because they should be used when pci_{load,stor,store_block} are 
interpreted AFAIU.
And currently we only use interception.

Yes, because, the CLP part, use to setup the translations IIUC, (do not 
ask me for details now), will need to be re-issued by the kernel after 
some modifications and this will also need a way from QEMU S390 PCI down 
to the ZPCI driver.
Way that I try to setup with this patch.

So answer is not now but we should keep in mind that we will 
definitively need a way down to the zpci low level in the host.

> 
>> We receive events through
>> - Adapter interrupts
> 
> Note for the non-s390 folks: These are (I/O) interrupts that are not
> tied to a specific device. MSI-X is mapped to this.
> 
>> - CHSC events
> 
> Another note for the non-s390 folks: This is a notification mechanism
> that is using machine check interrupts; more information is retrieved
> via a special instruction (chsc).
> 

thanks, it is yes better to explain better :)

>>
>> The adapter propose an IOMMU to protect the DMA
>> and the interrupt handling goes through a MSIX like interface handled by
>> the adapter.
>>
>> The architecture specific PCI do the interface between the standard PCI
>> level and the zPCI function (PCI + DMA/IOMMU/Interrupt)
>>
>> To handle the communication through the "zPCI way" the CLP interface
>> provides instructions to retrieve informations from the adapters.
>>
>> There are different group of functions having same functionalities.
>>
>> clp_list give us a list from zPCI functions
>> clp_query_pci_function returns informations specific to a function
>> clp_query_group returns information on a function group
>>
>>
>> 2) Why do we need it in the guest
>>
>> We need to provide the guest with information on the adapters and zPCI
>> functions returned by the clp_query instruction so that the guest's
>> driver gets the right information on how the way to the zPCI function
>> has been built in the host.
>>
>>
>> When a guest issues the CLP instructions we intercept the clp command in
>> QEMU and we need to feed the response with the right values for the guest.
>> The "right" values are not the raw CLP response values:
>>
>> - some identifier must be virtualized, like UID and FID,
>>
>> - some values must match what the host received from the CLP response,
>> like the size of the transmited blocks, the DMA Address Space Mask,
>> number of interrupt, MSIA
>>
>> - some other must match what the host handled with the adapter and
>> function, the start and end of DMA,
>>
>> - some what the host IOMMU driver supports (frame size),
>>
>>
>>
>> 3) We have three different way to get This information:
>>
>> The PCI Linux interface is a standard PCI interface and some Z specific
>> information is available in sysfs.
>> Not all the information needed to be returned inside the CLP response is
>> available.
>> So we can not use the sysfs interface to get all the information.
>>
>> There is a CLP ioctl interface but this interface is not secure in that
>> it returns the information for all adapters in the system.
>>
>> The VFIO interface offers the advantage to point to a single PCI
>> function, so more secure than the clp ioctl interface.
>> Coupled with the s390_iommu we get access to the zPCI CLP instruction
>> and to the values handled by the zPCI driver.
>>
>>
>> 4) Until now we used to fill the CLP response to the guest inside QEMU
>> with fixed values corresponding to the only PCI card we supported.
>> To support new cards we need to get the right values from the kernel out.
> 
> IIRC, the current code fills in values that make sense for one specific
> type of card only, right?

yes, right

> We also use the same values for emulated
> cards (virtio); I assume that they are not completely weird for that
> case...
> 

No they are not.

For emulated cards, all is done inside QEMU, we do not need kernel 
access, the emulated cards get a specific emulation function and group 
assigned with pre-defined values.

I sent a QEMU patch related to this.
Even the kernel interface will change with the changes in the kernel 
patch, the emulation should continue in this way.

Regards,
Pierre










-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
