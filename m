Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A92F3C19;
	Wed, 29 Jul 2026 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360779; cv=none; b=cBDyqh75SICnxt8V+Ciia2cd63Tm1RkJNvm3sgpGQ3swQ4YRHyPfOL97hCUCVI+sjqRF4SkAd54SZu2ywANQvsL+F+/rGmPQfRF/ASSvVCNbFwuitEiiZefIQLPgcaNkxqST+6t+0j8DCCLOVih3PVSKSISp+s8eGeSZLu8jkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360779; c=relaxed/simple;
	bh=c40h7e6r/DLEC9DZU59NUpvgQvI1n1OyDKp1OFZSxlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGfc2PTqFuHENs9mJeL4A5brqvLQJvGm9MnwnSk3z+oMvC7f5/b3sryaDlPvnmUakgGssVBGna0rTJMF0KQiqDYKNWyCjL4mjBB5NbJJJmbCTUSvERG+ODDmiUYWQiWD4YAr6vzunObeNemk5sxqpBrxL6W+cP894c/7NOzPVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=apWQEugR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="apWQEugR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TLIdHS1053031;
	Wed, 29 Jul 2026 21:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/mb2ud
	WjvsXgO+DrRURXADlbaiEqxMmSdWVMz+jHCTc=; b=apWQEugRaazTgWPAycaeq4
	LOufgTkaAyNbDeWfwKAeY2zo80Gd+gH5VqE0Ql6DUhCHzxBm/3aKYbSgjzV0xEuS
	sUv4jrtsW2FeepIjLGXxW8RaheVKyAjo9A6a/+3n/oCYLrEwnrmiqGYoCT+VU1Hl
	/gBtKgllM9R5VDAWjAxSwfXojRfEMejmdEi4SQGPZW4VZOZLBA/QTJli2r0VhJLI
	UB5lr4TofJeGVoA4Zx7U2/4CavjTv0JWEfHe9vBthVOAWRPy/l8icnHl5T9i7rRV
	JZN2pTQFxNsujfdia2dXQyeJy2EC90ynefFbYCbQocMIHKPnM6+juM9oaDsRLEuw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nv0aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 21:32:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TLQK4A016406;
	Wed, 29 Jul 2026 21:32:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pggd27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 21:32:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TLWkNi39190918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 21:32:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A4E58064;
	Wed, 29 Jul 2026 21:32:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F67C58060;
	Wed, 29 Jul 2026 21:32:46 +0000 (GMT)
Received: from [9.61.253.71] (unknown [9.61.253.71])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 21:32:46 +0000 (GMT)
Message-ID: <42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
Date: Wed, 29 Jul 2026 14:32:45 -0700
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
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260729143603.175f60a7@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE2MSBTYWx0ZWRfXwEAWqsdj1dKg
 XvSbAlC+SIy5xwCV9jSCWNm/ER70v10742xy7SYEXjFvpkOojHYIBQwzN1ZixE4UdImp0GT4vE8
 fH0BKcyvX2MuFeMOuh1ZH3ZRAAsLhMA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE2MSBTYWx0ZWRfX+FPsXWejWhG+
 4O6TO/bdilduPWI2fGPnb0n0d1A5m7BYWuMtNQYrV2LTHtD/uxSSFqb38mwMf22KsadsKOOG/Ev
 pe3QaX2CXiVmfCzp+it67IpF7FnkClVfgYTiSXuxcHA1AjtwKiGsNwgr1vHx3APLvVBUo57oepb
 em6NzK9/cWhTJWWhUnFTaIyWfl2XRQNmMuxGvoI9KqNUWJ85x1FjyvyDUEBFXDfTcz+OAp67vL1
 9tY22YpQCQekNtLVbCGlGukhoTxE2q5lN32a+GDJD4X2tNnyzyumXB/5HizXeqNcR6lL9WNQ6bO
 OBnamR2d8b+HAfquLurrcW80rufhoNREn/A9PGnwupwZod1kBNT7MWY9bV+beLdErqSZbi4PD13
 F0irE4KnI8fVg8nFEAQw0FP9zAR4cNymPpXLX7NJxOvpFyoKa6wv3POGSC3UYOQd6Uwc9KmrfAP
 fmvsTMT/DtcPowXxjtw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a7180 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=UsrU7Yu2hTfJ4snfykwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kTYZ1g_ZrdMYkId-iKz4jMFxJK4mYmQb
X-Proofpoint-ORIG-GUID: kTYZ1g_ZrdMYkId-iKz4jMFxJK4mYmQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_08,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290161


On 7/29/2026 1:36 PM, Alex Williamson wrote:
> On Wed, 29 Jul 2026 13:28:46 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 7/29/2026 12:41 PM, Matthew Rosato wrote:
>>> On 7/29/26 2:11 PM, Farhan Ali wrote:
>>>> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
>>>> all devices support having their BARs mapped by the CPU. The
>>>> non_mappable_bars flag indicates that a PCI device's BARs cannot be
>>>> accessed by the CPU. The ISM device on s390 is one such device. The BAR
>>>> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
>>>> to warnings:
>>>>
>>>> vmalloc_node_range for size 281474976714752 failed: Address range
>>>> restricted to 0x2110bab00000 - 0x21903ab00000
>>>>
>>>> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
>>>> is set by the PCI core at enumeration time and already serves the same
>>>> purpose in vfio_pci_probe_mmaps().
>>>>
>>>> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
>>>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    drivers/vfio/pci/vfio_pci_core.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>>>> index 3f11a9624b9c..6a184588ff23 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_core.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>>>> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>>>>    
>>>>    		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
>>>>    
>>>> +		if (pdev->non_mappable_bars)
>>>> +			continue;
>>>> +
>>> This would work for the ISM case at least, but I wonder: should we check
>>> vdev->bar_mmap_supported[bar] instead?
>>>
>>> My question boils down to: do we still want messages for some of the
>>> cases where we set vdev->bar_mmap_supported[bar] = false in
>>> vfio_pci_probe_mmaps()?
>> AFAIU vfio_pci_probe_mmaps() is only called in
>> vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called
>> in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(),
>> bar_mmap_supported would be false here for all devices. So I don't think
>> it would work here, unless I missed something?
> Also IO Port and sub-page MMIO BARs are things that do exist.  Thanks,
>
> Alex

Just to clarify, are you suggesting we expand this check to also avoid 
mapping IO port and sub-page MMIO BARs?

Thanks

Farhan


