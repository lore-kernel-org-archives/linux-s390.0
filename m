Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB1388E49;
	Fri,  5 Jun 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684876; cv=none; b=GtvXZMQHdf4pI/Z7Wk2sfSv0iapKlPwBKNtUWvvCveqWwOteZ4hz3F/McYLYNCEhBQURr/n9V5sVbD/sA1W1FpumSd54/ZMT+Yoqjw8nRDeb1zoUo2CNZ3hAhBN69OU+6zvpYgAsUGqO1BeEiRQF0rMtQgKnontx4Kd52Q5gl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684876; c=relaxed/simple;
	bh=nXm2CjoivUlPSvEfUuKTSR9U8Ovxfed1YPfUjKEiXu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8TgZjuFWf8krYeUnk4IjA79ulP48u2uE+C94ylKiyEyZ1y0xGRw4XBSQIf51ybROLmMA/lCKC4tW73MsWBsz22mhB34MJdUVMhUitNqXwl0Rtx38X++VLsHlfWfpGlqahf2Okw7i8/RjG/HDQBYQluoJxYDWbVt79/bnARKUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gIkDY6cS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gIkDY6cS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655DEwEj1089524;
	Fri, 5 Jun 2026 18:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/TxWvB
	F6mp0BynOxXFDqtolzketO6PuErjvU2x1l3SE=; b=gIkDY6cSvzDE6nCoK7j3kX
	A1V8fzew6dORjr5TRLRrCgxPvoOnrDCBaYHWHqU2KJFHGMOYy45OoErnNJJIqFjI
	xXJY01y2RuP7Bkb+yXEQM1SS3TuBQaTOyUoD2cbpBe0v3e0nkqgBdk2HcO6xS7aa
	SGSO093ByqaFVRPv/NZfUinOKP/8ijzf9jOhDudPDkuc9OgfFnNEYWAn7iL9v/30
	LSdZVlYynDQ2ypmcadPPti7wrDDjfWs1/WsaNPY03smcY7xj98sAj0rvaB4rHQ5g
	d3dn3ShQG2+Co+sbB7U4WAQXJcRbgSIBpNcL/41SE3MtfCXj3eUkjrQT56vK+HOA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqnrdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 18:41:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655IOCpB024384;
	Fri, 5 Jun 2026 18:41:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kk119-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 18:41:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655If8ig8127224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 18:41:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F4B258052;
	Fri,  5 Jun 2026 18:41:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F015805D;
	Fri,  5 Jun 2026 18:41:07 +0000 (GMT)
Received: from [9.61.250.71] (unknown [9.61.250.71])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 18:41:07 +0000 (GMT)
Message-ID: <8d1cbef7-f7d9-4796-a6a1-460956adfb39@linux.ibm.com>
Date: Fri, 5 Jun 2026 11:41:07 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
To: Keith Busch <kbusch@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, helgaas@kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com> <aiE3I0bL0TX1nOec@kbusch-mbp>
 <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
 <aiHjIyYB_8ogbxfz@kbusch-mbp>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <aiHjIyYB_8ogbxfz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U3iKX27nvOtZ5nkZAyFiVbK6Jrx1v6_N
X-Proofpoint-GUID: U3iKX27nvOtZ5nkZAyFiVbK6Jrx1v6_N
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a231847 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=hgAYPKTpvbEeOaY8OBcA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE4MyBTYWx0ZWRfX+Y8yPDLwqb2E
 GMBvF4RNaW4Le+5/JwuxW9bCdboivSWxTI/nNsxk/JXJSEY3y/F+OYYGf+XRHSR9IBNy6gmciO3
 JysR8hioQgwE5cXbBt+scVHUDDl4gFtIL0oRFX+OCCg54wuN8uA4+dVsYRStM/jjC6o1RrV9B8a
 3SCtp6k7Jna1zuR4t9lP1ND7CCZsMQtuXChcT04O2OEobnrow9r0/gmnPz9Vj2YoYmG4qpHPQPs
 KYRakY6ZU8sm5fLf0fTNjgnJXZVe9qQ9pFNq7/R7obllNJj9R1ClzC3D6iKU0HX6kNXDhDXPuIz
 0okKZ1+HCLTjZgVlIQkqvE/d4qP9iJ+sTLwP+yJpkzGhJk7LqCrxFOQ5FIQ0T/I2sIx12xwfegu
 jOfRli7Pe96yniYGk2EQGgi+l4oatN3andA081okaSzrljWR+LADv54eYO8zT9eGknMdS51rXMP
 AAY1QiQ2GikJqxKuFrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050183


On 6/4/2026 1:42 PM, Keith Busch wrote:
> On Thu, Jun 04, 2026 at 10:17:04AM -0700, Farhan Ali wrote:
>> On 6/4/2026 1:28 AM, Keith Busch wrote:
>>> On Wed, Jun 03, 2026 at 11:24:14AM -0700, Farhan Ali wrote:
>>>> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
>>>> +{
>>>> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
>>>> +
>>>> +	if (!vdev->pci_saved_state)
>>>> +		return;
>>>> +
>>>> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
>>>> +	pci_restore_state(pdev);
>>>> +}
>>> Shouldn't there be a cooresponding user space notification that the
>>> device has been restored? There's an eventfd on the error detected side
>>> so user space can know the device needs recovery, but how does it come
>>> to know that the reset is completed?
>> I think if the VFIO_DEVICE_RESET ioctl completes successfully it should be
>> an indication that the reset has completed?
> But isn't this reset initiated by the kernel via the kernel's AER
> handler? The user space driven ioctl has nothing to do with it, unless
> I'm missing something. I'm just mentioning it as I was recently asked to
> look into DPC and AER handling for vfio, and I think there needs to be
> coordination with userspace here for a more reliable recovery.

The approach I have taken for s390x, is on an error for PCI devices 
bound to vfio, we bypass host recovery completely so the kernel doesn't 
drive the reset (see patch 1 of this series). The recovery will then 
have to be driven by userspace. The error_detected() callback and 
eventfd notifies userspace on an error, and then userspace can drive the 
recovery via VFIO_DEVICE_RESET. For our primary use case of QEMU, once 
notified it then injects this error into the VM so device drivers in the 
VM can take recovery actions. For example for a passthrough NVMe device, 
the VM's OS NVMe driver will access the device. At this point the VM's 
NVMe driver's error_detected() will drive the recovery by returning 
PCI_ERS_RESULT_NEED_RESET, and the s390x error recovery in the VM's OS 
will try to do a reset. Resets are privileged operations and so the VM 
will need intervention from QEMU to perform the reset. QEMU will invoke 
the VFIO_DEVICE_RESET ioctl to now notify the host that the VM is 
requesting a reset of the device. The vfio-pci driver on the host will 
then perform the reset on the device to recover it. This also aligns 
architecturally for us as on s390 as PCI devices are exposed as 
functions to the OS, so an OS can issue resets per function (with 
platform firmware doing the heavy lifting). But I am curious to learn 
about your thoughts for DPC/AER with vfio for other platforms 
(x86/ARM?). Thanks

Farhan


