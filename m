Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbgHLSEL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Aug 2020 14:04:11 -0400
Subject: Re: [PATCH] PCI: Introduce flag for detached virtual functions
References: <1597243817-3468-1-git-send-email-mjrosato@linux.ibm.com>
 <1597243817-3468-2-git-send-email-mjrosato@linux.ibm.com>
 <20200812104351.3668cc0f@x1.home>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <05c46459-7d00-c01c-6387-68bc7d6c4f63@linux.ibm.com>
Date: Wed, 12 Aug 2020 14:04:01 -0400
MIME-Version: 1.0
In-Reply-To: <20200812104351.3668cc0f@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On 8/12/20 12:43 PM, Alex Williamson wrote:
> On Wed, 12 Aug 2020 10:50:17 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> s390x has the notion of providing VFs to the kernel in a manner
>> where the associated PF is inaccessible other than via firmware.
>> These are not treated as typical VFs and access to them is emulated
>> by underlying firmware which can still access the PF.  After
>> abafbc55 however these detached VFs were no longer able to work
>> with vfio-pci as the firmware does not provide emulation of the
>> PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
>> these detached VFs so that vfio-pci can allow memory access to
>> them again.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>   arch/s390/pci/pci.c                | 8 ++++++++
>>   drivers/vfio/pci/vfio_pci_config.c | 3 ++-
>>   include/linux/pci.h                | 1 +
>>   3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 3902c9f..04ac76d 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -581,6 +581,14 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>>   
>> +	/*
>> +	 * If we have a VF on a non-multifunction bus, it must be a VF that is
>> +	 * detached from its parent PF.  We rely on firmware emulation to
>> +	 * provide underlying PF details.
>> +	 */
>> +	if (zdev->vfn && !zdev->zbus->multifunction)
>> +		pdev->detached_vf = 1;
>> +
>>   	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
>>   	zpci_fmb_enable_device(zdev);
>>   
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index d98843f..17845fc 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -406,7 +406,8 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
>>   	 * PF SR-IOV capability, there's therefore no need to trigger
>>   	 * faults based on the virtual value.
>>   	 */
>> -	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
>> +	return pdev->is_virtfn || pdev->detached_vf ||
>> +	       (cmd & PCI_COMMAND_MEMORY);
>>   }
>>   
>>   /*
> 
> Wouldn't we also want to enable the is_virtfn related code in
> vfio_basic_config_read() and at least the initial setting of the
> command register in vfio_config_init()?  Otherwise we're extending the
> incomplete emulation out to userspace.  Thanks,
> 

We had discussed doing this internally and I ultimately left it out of 
this patch to keep the changes small...  But I agree that it makes sense 
to fix the emulation for userspace.  I can add the changes you suggest + 
would also need to change vfio_restore_bar() with:

-       if (pdev->is_virtfn)
+       if (pdev->is_virtfn || pdev->detached_vf)
                 return;

to prevent the config changes from tripping the restore code.

I'll send a V2 with this included.
