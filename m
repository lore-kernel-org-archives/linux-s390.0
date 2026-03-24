Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346743147;
	Tue, 24 Mar 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396074; cv=none; b=NNtYaLJhKTSPUWSANg6BiygbIVwTrfoRNqN0csdOTNkT8xODbd2iYdBUbap42H/Kjt2E89GsNp38xth9X0oUHYXAuWfw7h0UJCKOCKdVv9KiN/N6Q1hhZEMrsIXCULFd8/GQ/jz2Z4HQkBNU6+nNqo1UWQ00jLSWpNio01WRtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396074; c=relaxed/simple;
	bh=pu0ogHri2cS8AUI1zpfJ+5/gLIBIptegvKXfdKWlRV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzsDW3kOYdZki09oKZcYBlFNe63PIF5arsJlGChcUyyz2TrStklXiMKZJDPP8YUpzACm37kLads0XZZIpkRJJcm2KH9JOPV5j/02wGH+Bv705kbnZgM8bXTIcjF2O4DHN7ev8hl5PzRntxO1n8UmWcYoQ+1k+riq+tFn65wXm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kPPS398b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kPPS398b"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OIoFl7538370;
	Tue, 24 Mar 2026 23:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JLoHlw
	Svy4QDlEzuZ1PSx80JAkSbMgYSCAtOZu6Tnec=; b=kPPS398b4VDU/Q4j8hcFui
	y/bycQmeYw6l2+JjQ7JixrTs71E7pSc5oXGVHRzNEFb1Djjt/0kY/sfsnHwtt8GC
	Pv948NSpfGybgTLOEKrXXuf0v9E418EE74oEzbVeVbxsqg9dMjP9+Zf7tucGB06k
	/8OrVceoYCYksZfuA1w6dI9HfZzvwr1mKK97ZFfwTf5i/5edSs5TDlBviXuCp/4w
	O6TbmozGfIBEGJmGd84GAreyYG4sGb5T5tURtSYlL1lopD2sf52djOsZTIJNu4+Y
	f1WKuTak6323t/CyStUpqcVO4bJS7ulqx38PpFRlCBp1SAhsGy016H+Bv0gN/r0g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxx4kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:47:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJSPoP008732;
	Tue, 24 Mar 2026 23:47:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnmb35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:47:45 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ONlhsk45351232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 23:47:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAAD5805D;
	Tue, 24 Mar 2026 23:47:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3AED58043;
	Tue, 24 Mar 2026 23:47:42 +0000 (GMT)
Received: from [9.61.253.153] (unknown [9.61.253.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 23:47:42 +0000 (GMT)
Message-ID: <2676f787-4373-4f5f-8be8-b84815903ef2@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:47:40 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/9] s390/pci: Add architecture specific resource/bus
 address translation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20260324230641.GA1162880@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260324230641.GA1162880@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c322a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=dv-Jof5jEPWRgN2qFloA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NCBTYWx0ZWRfXy8Xijl+Ln6+1
 /wLF3j2JyIehdwD3+LFvUVYOwHv8mu6ev66f+ruJKe325FP8nQWGADAcc80tgDNSv8lH1mR4/kW
 9D3hFb+0q0wEaV/rKMwih5YJpQ2a6lZC85H0uDYowQ8OJ6HuOACvZvpRPMBn6q80Oj7ddjJz1Wq
 XneTWlR997zGfYNkcTBz9MKzilpKYqHzTo+8e0DxjRPfObxnyv7kYAe8JXiBbLjrTq63WwiUEIp
 E5RuxW2eqJDWp9NP9+hz0aYKMmSYhJAxgk6vilhtLgoMeuIPG28wNLk4oPiMmEmCosi7NJXhO0y
 M7RS/5xMzizreoMnTghI38kO+6k3OKzfcvfIDFDo8NGfhTXcxFAx9wHmXFfpDMninQo/0yY5ais
 p6qY3tDhtG0OLMmu30iFXj+6DcPMFZyokPnWb174xzqbEXK+ECCIguJZK249pNTGlMFKdW1RvfZ
 9idYVH2t6RYl5j5bzbw==
X-Proofpoint-GUID: RkZCQLgPRdSyNqVorahqrw2X1boE8r2X
X-Proofpoint-ORIG-GUID: RkZCQLgPRdSyNqVorahqrw2X1boE8r2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240184


On 3/24/2026 4:06 PM, Bjorn Helgaas wrote:
> [+cc Ilpo just for awareness; I assume there's nothing Linux can
> actually *do* with s390 PCI resources?]
>
> On Mon, Mar 16, 2026 at 12:15:37PM -0700, Farhan Ali wrote:
>> On s390 today we overwrite the PCI BAR resource address to either an
>> artificial cookie address or MIO address. However this address is different
>> from the bus address of the BARs programmed by firmware. The artificial
>> cookie address was created to index into an array of function handles
>> (zpci_iomap_start). The MIO (mapped I/O) addresses are provided by firmware
>> but maybe different from the bus addresses. This creates an issue when
>> trying to convert the BAR resource address to bus address using the generic
>> pcibios_resource_to_bus().
>>
>> Implement an architecture specific pcibios_resource_to_bus() function to
>> correctly translate PCI BAR resource addresses to bus addresses for s390.
>> Similarly add architecture specific pcibios_bus_to_resource function to do
>> the reverse translation.
> 1) It's not clear to me *why* we need these arch-specific versions.
> We went to a lot of trouble to make these interfaces generic, and I'll
> be really sad if they have to be arch-specific again.  I don't see any
> direct uses of these in the series.  In any case, some reference to
> the user and the actual problem this solves would help.

I came across this issue when in one of the previous version of this 
series I was using pci_restore_bars() which calls pci_resource_to_bus() 
to get the bus address. Given how we were updating the resource address 
in s390, we were programming the BARs with invalid addresses. I also 
think a patch from Ilpo, which was later reverted, also exposed this 
issue [1]

[1] 
https://lore.kernel.org/all/62669f67-d53e-2b56-af8c-e02cdff480a8@linux.intel.com/ 




>
> 2) I'm kind of concerned that the "unusual" s390 PCI resources will be
> unintelligible to people who are used to reading lspci or dmesg logs
> from non-s390 systems, and they might confuse the PCI core resource
> assignment code.  I guess there's not really a concept of a PCI host
> bridge on s390, there's no bus hierarchy, and no visible PCI-to-PCI
> bridges, so no windows?  Can you use PCIe switches at all?

On the host kernel we don't expose any of the information such as bus 
hierarchy, topology etc. This is all handled by firmware including the 
use PCIe switches. Host kernel interfaces with firmware through a set of 
instructions. As somewhat alluded to in patch 1, firmware exposes 
individual PCI functions to the host. So the host kernel has no idea 
about actual topology.


>
> 3) Maybe this patch should be reordered to be closer to the patch that
> needs these?  I don't think it's related to the "PCI: Avoid saving
> config space state if inaccessible" and PCI: Add additional checks for
> flr reset" patches.

Currently this patch is not needed by this series. It just fixes a gap 
on s390 on how we handle the resources, I could remove this patch from 
the series and have it as a separate patch.

Thanks

Farhan

>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/host-bridge.c |  8 ++---
>>   2 files changed, 78 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 2a430722cbe4..87077e510266 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -272,6 +272,80 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>>   	return 0;
>>   }
>>   
>> +void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
>> +			     struct resource *res)
>> +{
>> +	struct zpci_bus *zbus = bus->sysdata;
>> +	struct zpci_bar_struct *zbar;
>> +	struct zpci_dev *zdev;
>> +
>> +	region->start = res->start;
>> +	region->end = res->end;
>> +
>> +	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
>> +		int j = 0;
>> +
>> +		zbar = NULL;
>> +		zdev = zbus->function[i];
>> +		if (!zdev)
>> +			continue;
>> +
>> +		for (j = 0; j < PCI_STD_NUM_BARS; j++) {
>> +			if (zdev->bars[j].res->start == res->start &&
>> +			    zdev->bars[j].res->end == res->end &&
>> +			    res->flags & IORESOURCE_MEM) {
>> +				zbar = &zdev->bars[j];
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (zbar) {
>> +			/* only MMIO is supported */
>> +			region->start = zbar->val & PCI_BASE_ADDRESS_MEM_MASK;
>> +			if (zbar->val & PCI_BASE_ADDRESS_MEM_TYPE_64)
>> +				region->start |= (u64)zdev->bars[j + 1].val << 32;
>> +
>> +			region->end = region->start + (1UL << zbar->size) - 1;
>> +			return;
>> +		}
>> +	}
>> +}
>> +
>> +void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>> +			     struct pci_bus_region *region)
>> +{
>> +	struct zpci_bus *zbus = bus->sysdata;
>> +	struct zpci_dev *zdev;
>> +	resource_size_t start, end;
>> +
>> +	res->start = region->start;
>> +	res->end = region->end;
>> +
>> +	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
>> +		zdev = zbus->function[i];
>> +		if (!zdev || !zdev->has_resources)
>> +			continue;
>> +
>> +		for (int j = 0; j < PCI_STD_NUM_BARS; j++) {
>> +			if (!zdev->bars[j].size)
>> +				continue;
>> +
>> +			/* only MMIO is supported */
>> +			start = zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_MASK;
>> +			if (zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_TYPE_64)
>> +				start |= (u64)zdev->bars[j + 1].val << 32;
>> +
>> +			end = start + (1UL << zdev->bars[j].size) - 1;
>> +
>> +			if (start == region->start && end == region->end) {
>> +				res->start = zdev->bars[j].res->start;
>> +				res->end = zdev->bars[j].res->end;
>> +				return;
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>   void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>>   			   pgprot_t prot)
>>   {
>> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
>> index be5ef6516cff..aed031b8a9f3 100644
>> --- a/drivers/pci/host-bridge.c
>> +++ b/drivers/pci/host-bridge.c
>> @@ -49,8 +49,8 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_set_host_bridge_release);
>>   
>> -void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
>> -			     struct resource *res)
>> +void __weak pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
>> +				    struct resource *res)
>>   {
>>   	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>>   	struct resource_entry *window;
>> @@ -74,8 +74,8 @@ static bool region_contains(struct pci_bus_region *region1,
>>   	return region1->start <= region2->start && region1->end >= region2->end;
>>   }
>>   
>> -void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>> -			     struct pci_bus_region *region)
>> +void __weak pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>> +				    struct pci_bus_region *region)
>>   {
>>   	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>>   	struct resource_entry *window;
>> -- 
>> 2.43.0
>>
