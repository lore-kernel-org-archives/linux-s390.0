Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBA43CE46;
	Fri, 31 Jul 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521736; cv=none; b=jBsefwsf+MI6LkyhQgOSatKyTyXTbmbpjfRmRMT9pr86/yqLPC7JIsoZ1jiKj5Lbk/egJaAUNQdga621jK10JJbCPwmJfxY20Gmz8QSXG89odsJ20UQvEs5SuIhBL7G0viUkCvRS2bEYNkO4cYnnijHQLGvv/SpnP3UTPKX3FoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521736; c=relaxed/simple;
	bh=4WvLEtigxrVa8d5dHkHjLxLLTLwzaS0OzaekrU07+oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOeOocfBT33y/Bdcde7yXUO33nFGb4f8gcouj8psnntE7cD4f39lq215xGSRcNW8rMoxbEroqPGK4cDlzdDJ/u9+0Wa25K+Gr2X/1/SMHYL72hzvEQ2t8hASvzT3OVHTtuUtwq/wucTTarEBGorMyLsT6sbACOuq0efhVo/VuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IIurIWtL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IIurIWtL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFm6WE2312119;
	Fri, 31 Jul 2026 18:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vdECai
	oijrSW5fhHomiGEyvuCeNrMFXXXSUQcsGxm8Q=; b=IIurIWtLruz1kG0LJJw67s
	g3K+4UXnG7hZbstNTFzCnMq9YDMula/hUmObXZxRPDjpycM87k8SN4SMyAZyJ+Oa
	2CtSLYP41ubOg0+15F6jLUtv7q4ryKCOgB/YkVA4vlgcSNmMmJZpNH/MNfLTYmfb
	5fk9UJDg9K+XDA5vvoqCfKQU1Y4Kr1s5Elzu0qFhehFCvbSx0iPgYyRCj2fSft2d
	gYBsej5mLopH3Kg0VQz4dnFMeczDe9cfErfsvpS75//Q5PMTVIN53pwzgDPlPCHR
	eQBFMHxgGvP6+fND80ZtmJ3xFW7YATovJm4B9iK1xdVT7nfSgWnupqm+CNEvOxrA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdddgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 18:15:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VIBNvE003758;
	Fri, 31 Jul 2026 18:15:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkh3hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 18:15:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VIFIA941484898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 18:15:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 443A25805C;
	Fri, 31 Jul 2026 18:15:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CC3358059;
	Fri, 31 Jul 2026 18:15:17 +0000 (GMT)
Received: from [9.61.254.127] (unknown [9.61.254.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 18:15:17 +0000 (GMT)
Message-ID: <08ce08f7-66fd-430a-8eea-6b1696f68de6@linux.ibm.com>
Date: Fri, 31 Jul 2026 11:15:16 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20260731002210.GA1521769@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260731002210.GA1521769@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SbFnyJyiiEWBeQZ9o3X-H2TMZslrFWUr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNiBTYWx0ZWRfX8t021t0VWdvO
 wZOvhEe8iwBTeqbcKQMzGVoUvagzWSIocPCTKI0NmD1e+36t8X+AIfqQpuEFx+8TTeyKkQI8Hp6
 kk1r+u2gIToxTidSSe2XdGU7Rc6IAbI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6ce638 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=TxOPuv4DIxgBshNE3IgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNiBTYWx0ZWRfXxIY5Jq+iWrah
 bBrim3MrGwgVYtyGC1TitsvycrB5R1Ea+lyfNfTxhOiGJXuN3kT8/53FSoL9Fks0+8doorYrug7
 zR/JnqN2r21XJ18WwVMZWpA6wvP0ay6/4pATGJOMCS2f9+/PV9sFAyTsYlZBnqSsybAw5u0/VKU
 mRwHgdPZdAB20WVPxchZinmDPjDpUrnXgWy6jJ9ReHGQl13vKqqNkT02B+VuI8/o9HLufoROZdb
 UIbMqWp1xqNxOXgVpmQ/TcyNoeFKjObN0+6vbY2gjG/QEjIgkEAjmeb/yhdEXUFinAwEtISFs6H
 04CW5zy6i5k9divf5flPIQiS6hlUIZppKd+/Do7+SQgtgDAMMno6C5DlWLMJ3B+0LvAUmfAryNv
 OV26dlOLOuJLQKs82x0yvs3fykMC5HLlG0TUczU+ZUZHZbkjgjZz68SWxheb/ovkMTl19DhWNLK
 nIizbUyRUEQS4V6nYMg==
X-Proofpoint-GUID: SbFnyJyiiEWBeQZ9o3X-H2TMZslrFWUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310136


On 7/30/2026 5:22 PM, Bjorn Helgaas wrote:
> [+cc Keith, just fyi since this is slightly related to 102c8b26b54e
> ("PCI: Allow all bus devices to use the same slot")]
>
> On Mon, Jul 20, 2026 at 12:25:02PM -0700, Farhan Ali wrote:
>> On s390 systems, which use a machine level hypervisor, PCI devices are
>> always accessed through a form of PCI pass-through which fundamentally
>> operates on a per PCI function granularity. This is also reflected in the
>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>> functions. Its reset_slot() function, which is a wrapper for
>> zpci_hot_reset_device(), thus also resets individual functions.
> I guess we must be talking about rpaphp?

No, this is the s390_pci_hpc driver.


>> Currently, the pci_create_slot() assigns the same pci_slot object to
>> multifunction devices.
> Can we say something about exactly where and why this reuse happens?
> Is this because most callers have stripped off the function number by
> using PCI_SLOT() before they pass it to pci_create_slot() as @slot_nr?
>
> If so, it seems like more a property of the *callers*, not of
> pci_create_slot() itself.

AFAIU in pci_create_slot() we will iterate through all the devices in 
the bus, and assign the same pci_slot object to devices that falls in 
the same slot as per PCI_SLOT(). So even if a caller provides different 
slot_nr, devices that fall in the same slot will be assigned the same 
object. In s390 hotplug driver case, it provides the devfn as the 
slot_nr. So for example devices with bdf 00:00.0 and bdf 00:00.2 will 
get assigned the same slot, when we create a slot for device 00:00.0. 
When we attempt to create a slot for device 00:00.2, we do indeed create 
a separate slot object, but don't update the device's pci_slot as 
PCI_SLOT(00:00.2) != 2.

I am open to suggestion on how we should re-word this. But i think it's 
pci_create_slot() that strips the devfn to a slot number.

>
>> This approach worked fine on s390 systems that only
>> exposed virtual functions as individual PCI domains to the operating
>> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> s390 supports exposing the topology of multifunction PCI devices by
>> grouping them in a shared PCI domain. This creates a problem when resetting
>> a function through the hotplug driver's slot_reset() interface.
>>
>> When attempting to reset a function through the hotplug driver, the shared
>> slot assignment causes the wrong function to be reset instead of the
>> intended one. It also leaks memory as we do create a pci_slot object for
>> the function, but don't correctly free it in pci_slot_release().
>>
>> Add a flag for struct pci_slot to allow per function PCI slots for
>> functions managed through a hypervisor, which exposes individual PCI
>> functions while retaining the topology. Since we can use all 8 bits for
>> slot 'number' (for ARI devices), change slot 'number' u16 to account for
>> special values -1 and PCI_SLOT_ALL_DEVICES.
> Sorry for the delay in reviewing this.  I always struggle to find
> my way through the PCI slot code, which has grown into a bit of a
> maze.  I keep hoping we can simplify it somehow.  I don't think that
> time is now, but the complexity does make changes messy.

Thank you for reviewing this! I appreciate you taking the time to help 
with the review.


>
>> Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/hotplug/rpaphp_slot.c |  2 +-
>>   drivers/pci/pci.c                 |  5 +++--
>>   drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
>>   include/linux/pci.h               |  8 ++++++--
>>   4 files changed, 35 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
>> index 67362e5b9971..92eabf5f61b9 100644
>> --- a/drivers/pci/hotplug/rpaphp_slot.c
>> +++ b/drivers/pci/hotplug/rpaphp_slot.c
>> @@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *slot)
>>   	struct hotplug_slot *php_slot = &slot->hotplug_slot;
>>   	u32 my_index;
>>   	int retval;
>> -	int slotno = -1;
>> +	int slotno = PCI_SLOT_PLACEHOLDER;
>>   
>>   	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
>>   		__func__, slot->dn, slot->index, slot->name,
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 77b17b13ee61..350bae907ebf 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4897,8 +4897,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
>>   
>>   static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>   {
>> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
>> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>> +	if (dev->subordinate || !dev->slot ||
>> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
>> +	    (dev->multifunction && !dev->slot->per_func_slot))
>>   		return -ENOTTY;
>>   
>>   	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index 6d5cd37bfb1e..894d6213ed30 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
>>   
>>   static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>>   {
>> -	if (slot->number == 0xff)
>> +	if (slot->number == (u16)PCI_SLOT_PLACEHOLDER)
> I think it might be worth splitting the PCI_SLOT_PLACEHOLDER addition
> and the relevant kernel-doc updates, which are mostly unrelated to
> this patch, to a separate no-functional-changes patch to simplify this
> patch.

I will take a look at splitting the PCI_SLOT_PLACEHOLDER out of this patch.


>>   		return sysfs_emit(buf, "%04x:%02x\n",
>>   				  pci_domain_nr(slot->bus),
>>   				  slot->bus->number);
>> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
>>   	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>>   }
>>   
>> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
>> +{
>> +	if (slot->per_func_slot)
>> +		return dev->devfn == slot->number;
>> +
>> +	return slot->number == PCI_SLOT_ALL_DEVICES ||
>> +		PCI_SLOT(dev->devfn) == slot->number;
>> +}
>> +
>> +static bool pci_slot_enabled_per_func(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_S390))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   static void pci_slot_release(struct kobject *kobj)
>>   {
>>   	struct pci_dev *dev;
>> @@ -82,8 +99,7 @@ static void pci_slot_release(struct kobject *kobj)
>>   
>>   	down_read(&pci_bus_sem);
>>   	list_for_each_entry(dev, &slot->bus->devices, bus_list)
>> -		if (slot->number == PCI_SLOT_ALL_DEVICES ||
>> -		    PCI_SLOT(dev->devfn) == slot->number)
>> +		if (pci_dev_matches_slot(dev, slot))
>>   			dev->slot = NULL;
>>   	up_read(&pci_bus_sem);
>>   
>> @@ -187,8 +203,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
>>   
>>   	mutex_lock(&pci_slot_mutex);
>>   	list_for_each_entry(slot, &dev->bus->slots, list)
>> -		if (slot->number == PCI_SLOT_ALL_DEVICES ||
>> -		    PCI_SLOT(dev->devfn) == slot->number)
>> +		if (pci_dev_matches_slot(dev, slot))
>>   			dev->slot = slot;
>>   	mutex_unlock(&pci_slot_mutex);
>>   }
> Update pci_create_slot() kernel-doc to mention PCI_SLOT_PLACEHOLDER
> instead of "-1" (several instances).
>
> In addition to PCI_SLOT_PLACEHOLDER or PCI_SLOT_ALL_DEVICES, and a
> 0-31 PCI_SLOT(devfn) value, I think @slot_nr can already be a 0-255
> value (e.g., from cpci module parameters or s390
> zpci_bus_add_device()).
>
> It seems like this patch also needs pci_slot.number to end up with a
> complete devfn in it so pci_dev_matches_slot() can use it, but I'm
> confused about how that happens, since it looks like
> rpaphp_register_slot() will pass either PCI_SLOT_PLACEHOLDER or a
> PCI_SLOT(...) value to pci_hp_register().

On s390 it happens via zpci_init_slot() in the 
drivers/pci/hotplug/s390_pci_hpc.c, which assigns a devfn as a slot_nr.


>
>> @@ -267,7 +282,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>   
>>   	mutex_lock(&pci_slot_mutex);
>>   
>> -	if (slot_nr == -1)
>> +	if (slot_nr == PCI_SLOT_PLACEHOLDER)
> No action for you here, but one thing that complicates this is the
> overloading of slot_nr for different purposes:
>
>    - Sentinel flags:
>
>      * PCI_SLOT_ALL_DEVICES (0xfe or 0xfeff) used by pciehp init_slot()
>
>      * PCI_SLOT_PLACEHOLDER (-1), used by rpaphp_register_slot()
>
>      * -1 may also be used by pnv_php_alloc_slot(); I don't know
>        exactly what it means
>
>    - Traditional (mostly) PCI device numbers:
>
>      * 0-31 derived by PCI_SLOT() in hv_pci_assign_slots(),
>        octep_hp_register_slot(), pnv_php_alloc_slot(),
>        rpaphp_register_slot()
>
>      * 0-255 from cpci (module parameters)
>
>      * 0-15 from cpq ((u8 from readb(SLOT_MASK) >> 4))
>
>      * 0 from ibmphp_ebda
>
>      * 0-255 from s390 zpci_bus_add_device()
>        (zdev->rid & ZPCI_RID_MASK_DEVFN), where ZPCI_RID_MASK_DEVFN is
>        0xff
>
>      * 0-255 for s390 per-function slots (this series)
>
>    - Arbitrary values:
>
>      * Sparc pcie_bus_slot_names() path uses unvalidated
>        'physical-slot#' DT property as slot_nr
>
>      * acpiphp uses the value of _ADR as slot_nr (per spec it should be
>        device number in bits 16-31, but not validated)
>
>>   		goto placeholder;
>>   
>>   	/*
>> @@ -298,6 +313,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>   	slot->bus = pci_bus_get(parent);
>>   	slot->number = slot_nr;
>>   
>> +	if (pci_slot_enabled_per_func())
>> +		slot->per_func_slot = 1;
>> +
>>   	slot->kobj.kset = pci_slots_kset;
>>   
>>   	slot_name = make_slot_name(name);
>> @@ -318,8 +336,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>   
>>   	down_read(&pci_bus_sem);
>>   	list_for_each_entry(dev, &parent->devices, bus_list)
>> -		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
>> -		    PCI_SLOT(dev->devfn) == slot_nr)
>> +		if (pci_dev_matches_slot(dev, slot))
>>   			dev->slot = slot;
>>   	up_read(&pci_bus_sem);
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 64b308b6e61c..6141787f7417 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -79,14 +79,18 @@
>>    * and, if ARI Forwarding is enabled, functions may appear to be on multiple
>>    * devices.
>>    */
>> -#define PCI_SLOT_ALL_DEVICES	0xfe
>> +#define PCI_SLOT_ALL_DEVICES	0xfeff
>> +
>> +/* Used to identify a slot as a placeholder */
>> +#define PCI_SLOT_PLACEHOLDER	-1
> Since this is eventually assigned to a u16, and you use "0xfeff" for
> PCI_SLOT_ALL_DEVICES, it seems like "0xffff" would be appropriate.
>
> I suppose you used -1 because the arguments to pci_hp_register() all
> the way down to pci_create_slot() are "int" and it's only inside
> pci_create_slot() where it gets chopped to u16 when it's stored in
> pci_slot.number.  But the mix of int/u16 and 0xfeff (a valid u16) and
> -1 (which needs to be int) seems like unnecessary complexity.

I kept it as -1 because it's an int up until pci_create_slot(). I can 
change it to 0xffff.

Thanks

Farhan

>
> AFAICT the only values we need to *store* in pci_slot are 0-255 and
> the "ALL_DEVICES" indication.
>
>>   /* pci_slot represents a physical slot */
>>   struct pci_slot {
>>   	struct pci_bus		*bus;		/* Bus this slot is on */
>>   	struct list_head	list;		/* Node in list of slots */
>>   	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
>> -	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
>> +	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
>> +	unsigned int		per_func_slot:1; /* Allow per function slot */
>>   	struct kobject		kobj;
>>   };
>>   
>> -- 
>> 2.43.0
>>
