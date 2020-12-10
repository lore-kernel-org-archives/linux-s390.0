Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390483AbgLJP1L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 10:27:11 -0500
Subject: Re: [RFC 1/4] s390/pci: track alignment/length strictness for
 zpci_dev
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
 <1607545670-1557-2-git-send-email-mjrosato@linux.ibm.com>
 <20201210113318.136636e2.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <15132f7f-cad7-d663-a8b9-90f417e85c81@linux.ibm.com>
Date: Thu, 10 Dec 2020 10:26:22 -0500
MIME-Version: 1.0
In-Reply-To: <20201210113318.136636e2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/20 5:33 AM, Cornelia Huck wrote:
> On Wed,  9 Dec 2020 15:27:47 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> Some zpci device types (e.g., ISM) follow different rules for length
>> and alignment of pci instructions.  Recognize this and keep track of
>> it in the zpci_dev.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h     | 3 ++-
>>   arch/s390/include/asm/pci_clp.h | 4 +++-
>>   arch/s390/pci/pci_clp.c         | 1 +
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 2126289..f16ffba 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -133,7 +133,8 @@ struct zpci_dev {
>>   	u8		has_hp_slot	: 1;
>>   	u8		is_physfn	: 1;
>>   	u8		util_str_avail	: 1;
>> -	u8		reserved	: 4;
>> +	u8		relaxed_align	: 1;
>> +	u8		reserved	: 3;
>>   	unsigned int	devfn;		/* DEVFN part of the RID*/
>>   
>>   	struct mutex lock;
>> diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
>> index 1f4b666..9fb7cbf 100644
>> --- a/arch/s390/include/asm/pci_clp.h
>> +++ b/arch/s390/include/asm/pci_clp.h
>> @@ -150,7 +150,9 @@ struct clp_rsp_query_pci_grp {
>>   	u16			:  4;
>>   	u16 noi			: 12;	/* number of interrupts */
>>   	u8 version;
>> -	u8			:  6;
>> +	u8			:  4;
>> +	u8 relaxed_align	:  1;	/* Relax length and alignment rules */
>> +	u8			:  1;
>>   	u8 frame		:  1;
>>   	u8 refresh		:  1;	/* TLB refresh mode */
>>   	u16 reserved2;
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index 153720d..630f8fc 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -103,6 +103,7 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
>>   	zdev->max_msi = response->noi;
>>   	zdev->fmb_update = response->mui;
>>   	zdev->version = response->version;
>> +	zdev->relaxed_align = response->relaxed_align;
>>   
>>   	switch (response->version) {
>>   	case 1:
> 
> Hm, what does that 'relaxed alignment' imply? Is that something that
> can apply to emulated devices as well?
> 
The relaxed alignment simply loosens the rules on the PCISTB instruction 
so that it doesn't have to be on particular boundaries / have a minimum 
length restriction, these effectively allow ISM devices to use PCISTB 
instead of PCISTG for just about everything.  If you have a look at the 
patch "s390x/pci: Handle devices that support relaxed alignment" from 
the linked qemu set, you can get an idea of what the bit changes via the 
way qemu has to be more permissive of what the guest provides for PCISTB.

Re: emulated devices...  The S390 PCI I/O layer in the guest is always 
issuing strict? aligned I/O for PCISTB, and if it decided to later 
change that behavior it would need to look at this CLP bit to decide 
whether that would be a valid operation for a given PCI function anyway. 
  This bit will remain off in the CLP response we give for emulated 
devices, ensuring that should such a change occur in the guest s390 PCI 
I/O layer, we'd just continue getting strictly-aligned PCISTB.
