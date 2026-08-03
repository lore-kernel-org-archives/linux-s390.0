Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8B429CEB;
	Mon,  3 Aug 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789909; cv=none; b=oSkfntpqvVha2LD41pluXR1iEKPTx2NIu3nF9iBiWdqaNZJOKV8GI+e9gSz85solmtuJJR+6Gjiib32E6U7Cc4AMD9aI384OcklVNceqHJwPt6FpfNjy21PfZKEK3pNT+Q7iSALDFrXRHbTmeuyx2iEkuESh1T6al3C6S4nv4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789909; c=relaxed/simple;
	bh=Z5KJxGXWaa1iWEAIwKdncTkmQQbRb5gBUS0QmMSKD7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsKQWzktZx3zCraxJGAgFV2jnrgz9RR4wQdSZLOQbxSGGemnkl5no7O4CrhbywNFaUsL6nrLdS3nm94e2IUL3ya47oQ7hpE1nPkD6rOVYL7lX+LKT1Fw91Mlw6vthdmIulDDlOJMVJrHhvXsYAdRIBsBVbYv/DjuGxpbED69k+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hDOcvZaY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hDOcvZaY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JmUMs2975236;
	Mon, 3 Aug 2026 20:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LTbeyE
	eul4pt3WZ5zwBrXIGHf0F2gIZ7nJKmqvSaR6A=; b=hDOcvZaY7/lkd341UGb2ML
	4UPQABQFNkflJxTL+dsLAaSLos4ZCXm9SoSRpFlucKHfuhGpvXh0sWMOClekFuxH
	NDIDo/c7UVbZGXMKh53FTE463RGO9mwGSB+PsSVACDuczbdw0hwzBww1k/VjNhiL
	cqQOIjKaRSOIhwA65jcfCOS3P7+6OmjgcDBQ8VDcThDzigRCoCJpNvkSP+NJ917c
	FjFQZQIvyVR/mrLPio3V1I2kDO+Y3TGrZUTVZMkvqXRzLCaJxq4jyqpuDkWTOBQh
	lcZ1n8VDKp5lgGykS3pULLhD4gs+Z9O8TXuwLKkOi4jxdvX05E+5uF1qENyQToLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3tsfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 20:45:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673KfLPq006561;
	Mon, 3 Aug 2026 20:45:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg6wdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 20:45:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Kj0xk13435468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 20:45:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB4E58054;
	Mon,  3 Aug 2026 20:45:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5377C5804E;
	Mon,  3 Aug 2026 20:44:59 +0000 (GMT)
Received: from [9.61.254.189] (unknown [9.61.254.189])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 20:44:59 +0000 (GMT)
Message-ID: <a8f2af03-3242-40bf-bf89-e922f0768db3@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:44:58 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
To: Alex Williamson <alex@shazbot.org>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        borntraeger@linux.ibm.com, mattev@meta.com, schnelle@linux.ibm.com
References: <20260729181116.1373-1-alifm@linux.ibm.com>
 <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
 <46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
 <20260729143603.175f60a7@shazbot.org>
 <42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
 <20260729155021.64f7e1ba@shazbot.org>
 <c0e6803f-7e57-4dfa-a4cd-f2ee188070c8@linux.ibm.com>
 <20260803135415.2cfd37bb@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260803135415.2cfd37bb@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a70fdce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=CTMS0zTbMppP8V6aq1EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j-ibFgN7GGU-phX4ZOyJILITLSlJeLKt
X-Proofpoint-GUID: j-ibFgN7GGU-phX4ZOyJILITLSlJeLKt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3OSBTYWx0ZWRfX61j9Dip6eio5
 87fhpSV5WGV/AS2GsPtXciKADtAdxD9xlCwd7yuq/VcgyYnmx6imv2Iqg7BM47Yznq8xuT1Auan
 h2V4gtuEg1auXi3aWRrBrukxEzGHxys=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3OSBTYWx0ZWRfXxuBbRjkAWyMb
 6vZIjJahKJIxFFJVRwnLihFzB3V94IPolXGo0iUVGxFRs3BXxygj9NphiD9mf6/wnc8LoODXBH6
 wZL8j/dYXIVIi2Qw+Va+aiCn4NjCoTl67KrtO5E5N8XURu4N/mta/QMsmX8bREPTOnx6bg9rOYo
 WYVCXQXsI4AzRW1bWEFMyfH/HuqUFNzBmoWKReWCycdf1csehp1chlV813QCSFCxiIJ4RbduJ0W
 hyyEh/ds2IJC2Vtbr/Kg/F5/cQb8ISNM/Yx2wXR9dFChIuCIFaisXwrLvLgSEsw/WfVjXx/VR2x
 Df/8QeYZrFZKchTTBXVLmM+MO18i+u6ADyPrx/zaem12fORZwJNMVAGiFRAbe7+j4RvNsZR4ham
 97HmipwOOmqCMSX6ivVIafe592esvI0IFypjoxuE63nuUlJslz4+SIb6GFTfyTl/jFYsOA2vNm9
 YFY7oxhqJFfug8B5lAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030179


On 8/3/2026 12:54 PM, Alex Williamson wrote:
> On Mon, 3 Aug 2026 09:39:19 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 7/29/2026 2:50 PM, Alex Williamson wrote:
>>> On Wed, 29 Jul 2026 14:32:45 -0700
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>   
>>>> On 7/29/2026 1:36 PM, Alex Williamson wrote:
>>>>> On Wed, 29 Jul 2026 13:28:46 -0700
>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>>      
>>>>>> On 7/29/2026 12:41 PM, Matthew Rosato wrote:
>>>>>>> On 7/29/26 2:11 PM, Farhan Ali wrote:
>>>>>>>> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
>>>>>>>> all devices support having their BARs mapped by the CPU. The
>>>>>>>> non_mappable_bars flag indicates that a PCI device's BARs cannot be
>>>>>>>> accessed by the CPU. The ISM device on s390 is one such device. The BAR
>>>>>>>> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
>>>>>>>> to warnings:
>>>>>>>>
>>>>>>>> vmalloc_node_range for size 281474976714752 failed: Address range
>>>>>>>> restricted to 0x2110bab00000 - 0x21903ab00000
>>>>>>>>
>>>>>>>> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
>>>>>>>> is set by the PCI core at enumeration time and already serves the same
>>>>>>>> purpose in vfio_pci_probe_mmaps().
>>>>>>>>
>>>>>>>> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
>>>>>>>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>      drivers/vfio/pci/vfio_pci_core.c | 3 +++
>>>>>>>>      1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>>>>>>>> index 3f11a9624b9c..6a184588ff23 100644
>>>>>>>> --- a/drivers/vfio/pci/vfio_pci_core.c
>>>>>>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>>>>>>>> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>>>>>>>>      
>>>>>>>>      		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
>>>>>>>>      
>>>>>>>> +		if (pdev->non_mappable_bars)
>>>>>>>> +			continue;
>>>>>>>> +
>>>>>>> This would work for the ISM case at least, but I wonder: should we check
>>>>>>> vdev->bar_mmap_supported[bar] instead?
>>>>>>>
>>>>>>> My question boils down to: do we still want messages for some of the
>>>>>>> cases where we set vdev->bar_mmap_supported[bar] = false in
>>>>>>> vfio_pci_probe_mmaps()?
>>>>>> AFAIU vfio_pci_probe_mmaps() is only called in
>>>>>> vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called
>>>>>> in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(),
>>>>>> bar_mmap_supported would be false here for all devices. So I don't think
>>>>>> it would work here, unless I missed something?
>>>>> Also IO Port and sub-page MMIO BARs are things that do exist.  Thanks,
>>>> Just to clarify, are you suggesting we expand this check to also avoid
>>>> mapping IO port and sub-page MMIO BARs?
>>> Sorry, no, I'm not.  I think we're conflating that the barmap is
>>> related to mmap access.  The barmap itself is holding the iomap of the
>>> BAR, used for read/write.  The only real relation to the mmap is that
>>> we request the resource via this path as well.
>>>
>>> Therefore not only is the ordering of setting up bar_mmap_supported
>>> wrong, it's flagging entirely the wrong thing here and keying on it
>>> would entirely break IO port and sub-page MMIO BAR access.  Thanks,
>>>
>>> Alex
>> Hi Alex,
>>
>> I wanted some guidance on how we should proceed with this patch? The
>> warning messages are a regression on s390 for ISM devices, so we would
>> like to fix it.
> I think the original proposal is probably the correct one.  The
> non_mmapable_bars flag doesn't restrict its application to specific BAR
> types or access, at least not beyond "can't be mapped to CPU or peers."
>
> If we can't map the BAR to the CPU, then we don't need to request the
> region or perform the pci_iomap(), which is what I understand explodes
> here.  Therefore we really only need to establish the errno in the
> barmap here.

Yes, its the call to pci_iomap() that leads to the warning.

>
> The bar_mmap_supported flag describes something else, whether the BAR
> can be mapped into the user address space.  My intention was only to
> point out that there are BARs that cannot be mapped to the user address
> space because either they're not MMIO or we can't safely map the full
> page, therefore bar_mmap_supported is an invalid test for whether we
> should request the region or iomap the BAR.
>
> Is there still a gap with the original proposal that I'm missing?

AFAICT this fix should be sufficient. I think Matt's question was to see 
if there were other cases for which bar_mmap_supported were set to 
false, that we need to consider here. But I will let him clarify to see 
if he has any concerns.

Thanks

Farhan

