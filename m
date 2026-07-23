Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FCB2BCF46;
	Thu, 23 Jul 2026 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769704; cv=none; b=KOSIIpQNCwOjOHZ1ZIkn+tUECNmtEo1IcVbyCJQ7FaokqTWSqXS6fHddHzX3EznrYbUKEiVXfI3uuag64q1CFl28aB3j/FpcYlLzzHWjiVXBhOpQmtdbV7LRxQCN5FPvyOTMfl3wbMx/nxKZZCDKX02JDu/JEwEKm39vj/lit3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769704; c=relaxed/simple;
	bh=/4WK5zroedOfaaEfh4bRDb6yVMphiJLBs7FVuWMIXgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjgOu5pmBC5x3X4G28GnmUxWscIs5fpzHMdiEqHgEdPquXPDjAAnx0wST+tYhnwieND8zLRMfAV39QJ0UbWOSOMqyiqA0dqnlds/6J2n3mT1PXhbXsoOW44BSxLA1V2oeG9ObcLMZsURgkdzJL7+abv0VS+VKBTNXkndBOUE9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cg6Ooe6q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cg6Ooe6q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0gLpx1529893;
	Thu, 23 Jul 2026 01:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LpCzxm
	6qpwL/i0Oh2ovMitcsykAvLEFh9PXNoNPhDHg=; b=cg6Ooe6qRnrA/T9rNhNKFk
	/c4b5t2Cl8eu1jKnQq0qy5POQ/yW2poE5XKgV+siX8S00cxwicjG+7Fzw93CzGsy
	nO3uabFPGev4IN438EvammFyYNOnyELT8wTZH4TjuG/uaOm12IwOpcqehUe/cJ2S
	TkSd65EZRQrKzGvgx6lwy2suKJczVSh9UulEC5CuSeTLWVsKZwr+sy7gcbQobUK8
	zLMcaXLsdkGsx8w0yQ09ZZPGDhDZ1Ufu9t+Fb8Uqwjo1Fp7Cadc/UavjL6MyWDAC
	3yI09X9ahQuyyA/4Fkj9fOxReSWxiEJM/uMjvVT3A2tw73uGCQ9VavHSNuZKKl4A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahcks7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 01:21:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N1JkJU009640;
	Thu, 23 Jul 2026 01:21:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyhqsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 01:21:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N1LaNK60293460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 01:21:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E2B58067;
	Thu, 23 Jul 2026 01:21:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E02B58065;
	Thu, 23 Jul 2026 01:21:35 +0000 (GMT)
Received: from [9.61.243.141] (unknown [9.61.243.141])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 01:21:35 +0000 (GMT)
Message-ID: <fd385a3b-7dae-40ec-8b7f-7f981944a0fe@linux.ibm.com>
Date: Wed, 22 Jul 2026 18:21:33 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org
References: <20260722223231.GA801609@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260722223231.GA801609@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d5gSVyhkDZEO5Q3lGTohbcwslEGiJ8o0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAwOSBTYWx0ZWRfX4YtKahbzjsaW
 8L49t96n6eu8cdE++ZoUs6tAPidrnnHIbtm5Kr1+HnexvcN9V4yW5O+uFfKowIof8dakDz5Z+f6
 o87YFfgvywX1VHGv8T+hUHv8BWJk9FDy8HbaC/12QXVKaYj8SyO8gdla0GLOsjuKeM0gdQl/FTN
 9jWcjYoY1JmFycvH1GfsSV2FCpjqpM0x+8L4EtSLAtbueHaLHr2uFkJ9UwqO7A4qBYm6f2OslJD
 ZShiuUmLBt9C8YIu4hCHZCzv6ajYYZINe7nOcn+JVgT9XmMh0sSmH5R4/TTUgrE2hCA1z0DjM7l
 y2VgOF+6ua/Xh3w8u0czZLz4Odmh1dzsF9cTXHBXB9+A3Udvu5YAol8dXzO15sJw7jzRaTARolk
 o2c6mIZR8rzS+yxi2SxQkas4X0I3cAvQEdBQRFX3SVsMF5HS2MP7nZXiy9w/cjZfoKlkV4H5Yqh
 rXBIGZb3V0XJgVH9vdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAwOSBTYWx0ZWRfX+jH4UVZG6wUG
 7cdJBP8/yGlOTlafx9Vzir+F1ALMHcVE1IwdpO5tTRZPPEFfNqCWwvqIuzzjrgJ7WJdGptChPmN
 TIU0L/TmTmNyp4hzaif5nV4Eu/WWR28=
X-Proofpoint-GUID: d5gSVyhkDZEO5Q3lGTohbcwslEGiJ8o0
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a616ca2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=fKvCKPnV1Suih4e517sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230009


On 7/22/2026 3:32 PM, Bjorn Helgaas wrote:
> On Thu, Jul 16, 2026 at 11:15:33AM -0700, Farhan Ali wrote:
>> On 7/15/2026 4:34 PM, Bjorn Helgaas wrote:
>>>> On s390 systems, which use a machine level hypervisor, PCI devices are
>>>> always accessed through a form of PCI pass-through which fundamentally
>>>> operates on a per PCI function granularity. This is also reflected in the
>>>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>>>> functions. Its reset_slot() function, which is a wrapper for
>>>> zpci_hot_reset_device(), thus also resets individual functions.
>>>>
>>>> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
>>>> to multifunction devices.
>>> PCI_SLOT() doesn't assign pci_slot objects; I guess they're assigned
>>> by some code that*uses* PCI_SLOT().  Since this says "currently," I
>>> assume you're changing that code, so we should mention where it is to
>>> help readers out.
>> Thanks for your response! I can re-word the commit message, how about
>> something like this:
>>
>> Currently, the pci_create_slot() assigns the same pci_slot object to
>> multifunction devices.
>>
>>> I see some Sashiko comments; those also need to be addressed or
>>> explained away.
>> Regarding Sashiko's comments for this patch, it mentions 2 issues:
>>
>> New issues: - [High] Unconditional enablement of `per_func_slot` on S390
>> breaks standard PCI hotplug (e.g., pciehp, shpchp) slot matching and resets.
>>
>> I believe this is not applicable as on s390 we don't support any other PCI
>> hotplug drivers given the unique nature of zPCI architecture.
> Makes sense.
>
>> Pre-existing issues:
>> - [High] Lockless access to `dev->slot` in `pci_dev_reset_slot_function` can
>> lead to Use-After-Free if a hotplug driver is concurrently unbound.
>>
>> Sashiko identified this as a pre-existing issue, so I don't think should be
>> addressed with this patch.
> Right, we don't need to fix pre-existing issues in this series, but I
> meant there were Sashiko comments on other patches in this series that
> look like they *should* be addressed, e.g.,
>
>    [PATCH v21 2/4] PCI: Avoid saving config space state if inaccessible
>
>      - [High] pci_dev_save_and_disable() skips disabling the device if
>        config space is momentarily inaccessible, potentially leaving
>        DMA and interrupts enabled.

I am not sure if this is an issue? If we want to check if the device is 
momentarily inaccessible, then we would need to poll and do something 
similar to pci_dev_wait(). Please correct me if I am wrong. FWIW this 
doesn't even show up as an error anymore in v22 even though its the same 
code.

https://lore.kernel.org/all/20260720194254.E6B811F000E9@smtp.kernel.org/

>      - [Low] String literal passed to a non-const `char *` pointer in
>        `pci_dev_config_accessible()`.

I wasn't sure if this is something that is strictly enforced. But I can 
fix this if we want to enforce it.


>      https://lore.kernel.org/all/20260630170754.093021F00A3A@smtp.kernel.org
>
>    [PATCH v21 3/4] PCI: Fail FLR when config space is inaccessible
>
>      - [High] Un-ratelimited pci_warn() in pci_dev_config_accessible()
>        allows an attacker to flood the host kernel log.

Since we bailout early with -ENOTTY, we should at least try the other 
reset methods such as bus reset. So AFAIU we shouldn't be spamming the logs.

>      - [High] Early bailout in pcie_flr() when config space is
>        inaccessible skips the Function Level Reset and the subsequent
>        wait, allowing device assignment to continue without reset,
>        leaking state.
>
>      https://lore.kernel.org/all/20260630171310.F25D41F000E9@smtp.kernel.org

The idea with early bailout was to make sure we can try the other reset 
methods as currently if FLR is inaccessible/fails we don't try any other 
reset methods. So we should be trying the other reset methods and it 
shouldn't leak state. I think we probably are leaking the state today, 
as we don't try any other reset methods to reset the device.


>
>    [PATCH v21 4/4] PCI/MSI: Enable memory decoding before restoring MSI-X messages
>
>      - [Medium] Blindly restoring a stale PCI_COMMAND value introduces
>        a TOCTOU race window that can erase concurrent modifications to
>        the register.
>
>      https://lore.kernel.org/all/20260630171255.20BD91F000E9@smtp.kernel.org

I am not sure if this something we should fix?


>
> Annoyingly, on v22, Sashiko complained about *different* things and
> didn't complain about some of these even though the v22 patches are
> identical to v21.  Sigh.

Yeah, for this series Sashiko has been a little inconsistent in the 
issues it identifies :)

Thanks

Farhan


