Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0B3E3C5A;
	Mon,  4 May 2026 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914059; cv=none; b=h1XLWP2ILzlbuLriu82CycRJ0UppYct6JjKaZ6d5J1aX/mw/X5BURysy3imYhUiy7PtKWfDUNw/2rN2f63MeVPTRtxmGZXtaNpYPwTjbdmHgbGyfWZe7qAOoGFpiU1ptV86ClYxtsYRdzbsRZLUkkzXj3HT3vlt5/rZZ5usD1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914059; c=relaxed/simple;
	bh=rp+Jhejjuatd0hbki8yxt6aiHUP4PQ/nbRQzaS23LZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxV00e9Lmz4u3NOvfJSQ5N1fiQqE78FfjlcleQ+tq80poD3MFV5UdI5m49jPTX+nv6iqJZQ3KYHhx4du1tmg6HpAUJuc5gEfA4vNOCrIK1c1UaN/TCVZ8wEKWru6PX5SJGtR12WGJaEbPoyFe5a/TPOMmkgL3Uw4UmpgtP64ukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HfcNBqXA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HfcNBqXA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Df3dF2245623;
	Mon, 4 May 2026 17:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lx4Snl
	k0mfRM24bKTPYx5f4XjyIDQ3zq0XQb9GvE2Mk=; b=HfcNBqXAj5afnXfE5vEiAX
	+KbGOK4J4Mi7HOdm441jFTIha+k1TpYzmn3KEo5MjuKNWwLlh5odyF2h43RPfEg3
	sZbN1nVNKxkJOtJ5/aSzh3ZU204ib6W1czzn5Cu0q4QGjTnhGLpdJ9D7hZ2UA5hl
	HkNWGjZcR0aT1tQ//yCWQ9aDseMtocAQGWMK8dGfbbecIIO6P9ZzbMX4+o4MQiHg
	I0ZH+3uO9pbKSNf0E60iHZJSE4aLIsW9C8/tmPndkbReD4fzavnqlic3SKGFp8fH
	IkZW2PsydE1FApRirJkLO/0WybWEBd7gyZwvutyhRpFIN79oPnb9G0vykC59g0/Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y183s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 17:00:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644Eir8V018285;
	Mon, 4 May 2026 17:00:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y5t6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 17:00:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644H0c9h23069274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 17:00:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ABB358043;
	Mon,  4 May 2026 17:00:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5726758060;
	Mon,  4 May 2026 17:00:37 +0000 (GMT)
Received: from [9.61.240.249] (unknown [9.61.240.249])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 17:00:37 +0000 (GMT)
Message-ID: <536665e8-47fa-48d7-b22b-1d7133001f74@linux.ibm.com>
Date: Mon, 4 May 2026 10:00:36 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/7] PCI: Allow per function PCI slots to fix slot
 reset on s390
To: Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org
References: <20260421163031.704-1-alifm@linux.ibm.com>
 <20260421163031.704-2-alifm@linux.ibm.com>
 <e8758975c7e5007306096a165d05cf1ebf10ccec.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <e8758975c7e5007306096a165d05cf1ebf10ccec.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yAQLfe-BNZp_qQIabfh9_bNVLJgAxnsg
X-Proofpoint-GUID: yAQLfe-BNZp_qQIabfh9_bNVLJgAxnsg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NCBTYWx0ZWRfX85tOrVNWsZzk
 pDCdUx57yGVfGEoCX27sOwD4gYfj0ht1Z8N2frmXeXzuYlPYRwBGnX58MNfRx/GFCnxF6tVjXyX
 zrcUQ1EAXuw8zkalBAyvZR8CYQ+XOpaP+huSRPhfBd8QBmOyz5iG9fMs/grllRGSllwqt/AXLoa
 b4DwrNanmBC9nJOc9RKPS5M6sIYGR5/sWDLzDsffJbezRnyrNW5XbnOUzh8vuLkKC+tcv0fjEik
 6ESEVgKHi+4+vo3Rbx9ix5dHCzsuB/bG2KoTrUAHZSHv4FS6Ql7d+ReEFF8xS5n8ZwpMeBEGwq5
 YWmfmTLYLQ76C99yRgou+fxPgLMUQYqVWujXVNJCDtGyNXewf/ysZxdmJiNyflLQ8nuQsNQfo23
 8hIL/fZUbsorbMkfoWwbAFmckSr6IPQg4fbb/GYYtrhe6nflxtlnATYLAt2ecPVNcfqHiKbDTpH
 h/Mu8+MGpd63jmrK0iA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f8d0b7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7oLPNsgWg75vrdFgU7cA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040154


On 5/4/2026 8:52 AM, Gerd Bayer wrote:
> On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
>> On s390 systems, which use a machine level hypervisor, PCI devices are
>> always accessed through a form of PCI pass-through which fundamentally
>> operates on a per PCI function granularity. This is also reflected in the
>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>> functions. Its reset_slot() function, which is a wrapper for
>> zpci_hot_reset_device(), thus also resets individual functions.
>>
>> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
>> to multifunction devices. This approach worked fine on s390 systems that
>> only exposed virtual functions as individual PCI domains to the operating
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
> Hi Farhan,
>
> sorry for jumping this late into reviewing this, but I think I'd prefer
> a different approach than extending the slot member to u16 to make the
> full range of 256 usable:
>
>> Add a flag for struct pci_slot to allow per function PCI slots for
>> functions managed through a hypervisor, which exposes individual PCI
>> functions while retaining the topology. Since we can use all 8 bits
>> for slot 'number' (for ARI devices), change slot 'number' u16 to
>> account for special values -1 and PCI_SLOT_ALL_DEVICES.
>>
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
>> index 8f7cfcc00090..d0c9f0166af5 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
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
>> index e0b7fb43423c..3f6e5dce27a0 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
>>   
>>   static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>>   {
>> -	if (slot->number == 0xff)
>> +	if (slot->number == (u16)PCI_SLOT_PLACEHOLDER)
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
>> @@ -176,8 +192,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
>>   
>>   	mutex_lock(&pci_slot_mutex);
>>   	list_for_each_entry(slot, &dev->bus->slots, list)
>> -		if (slot->number == PCI_SLOT_ALL_DEVICES ||
>> -		    PCI_SLOT(dev->devfn) == slot->number)
>> +		if (pci_dev_matches_slot(dev, slot))
>>   			dev->slot = slot;
>>   	mutex_unlock(&pci_slot_mutex);
>>   }
>> @@ -256,7 +271,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>   
>>   	mutex_lock(&pci_slot_mutex);
>>   
>> -	if (slot_nr == -1)
>> +	if (slot_nr == PCI_SLOT_PLACEHOLDER)
>>   		goto placeholder;
>>   
>>   	/*
>> @@ -287,6 +302,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>   	slot->bus = pci_bus_get(parent);
>>   	slot->number = slot_nr;
>>   
>> +	if (pci_slot_enabled_per_func())
>> +		slot->per_func_slot = 1;
>> +
>>   	slot->kobj.kset = pci_slots_kset;
>>   
>>   	slot_name = make_slot_name(name);
>> @@ -307,8 +325,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
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
>> index 2c4454583c11..d58982aa8730 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -78,14 +78,18 @@
>>    * and, if ARI Forwarding is enabled, functions may appear to be on multiple
>>    * devices.
>>    */
>> -#define PCI_SLOT_ALL_DEVICES	0xfe
>> +#define PCI_SLOT_ALL_DEVICES	0xfeff
>> +
>> +/* Used to identify a slot as a placeholder */
>> +#define PCI_SLOT_PLACEHOLDER	-1
>>   
>>   /* pci_slot represents a physical slot */
>>   struct pci_slot {
>>   	struct pci_bus		*bus;		/* Bus this slot is on */
>>   	struct list_head	list;		/* Node in list of slots */
>>   	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
>> -	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
>> +	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
>> +	unsigned int		per_func_slot:1; /* Allow per function slot */

Hi Gerd,


> How about you introduce two additional single-bit flag members here for
> - placeholder, and
> - slot_all_devices
> and avoid creating an artifically wide number member.
>
> Eventually, this means that the special cases "placeholder-slot" and
> "bus-wide slot" should be broken out of pci_create_slot().
>
>>   	struct kobject		kobj;
>>   };
>>
> Hope this makes any sense? It almost makes me wonder if this should be
> handled with a pre-cursor patch to this...

I would like to avoid doing this as part of this series, and not 
increase it's scope too much. I do see your point about having separate 
flags to indicate a placeholder/slot_all_devices, but I think we would 
still need the special numbers unless we want to change pci_create_slot 
API to pass in flags.

Thanks

Farhan

>
> Thanks,
> Gerd
