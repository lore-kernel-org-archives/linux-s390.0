Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A251DEFE8;
	Tue, 24 Mar 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391429; cv=none; b=U2zdJgbPY1zQuuzHlKhf0bki1dUrvwYOwUkIgYulX0joS40TFgl/j5mHpGuqPxf3TC6OzML/9oKx/18P5WED+bjhBmeN6vJA+ispGlBBIGgmxheCM0Ha20N6MTSDt1pA5V5gFqfS6dtMipW6DpHxs4FQT8PEBKcbnr6OPVgSkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391429; c=relaxed/simple;
	bh=ygftK4s+3fx3lLXi9ZkGtZ5s6KmB+6hqi79m1N/yDBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alkYAgWHd9gZJttZ8pjwAgw6JQ4QUzseMBwnnh09BfLxBzloa0bSpZhlnmbpZOTqdAzSSGYDQs1EB4PJhoyy9vE2cKR7+Ltz1bGur23XiNUDIJy4M2qI2769FIekLbYtaLGO448DjwcrhAeR89oO3dG1H3FLH7T0u4nK/AQSfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JgrTsycM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JgrTsycM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCSF1v2322759;
	Tue, 24 Mar 2026 22:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SOdfEz
	9ubfISmg58IsZ5LIkzlTs6RbtoXLpjb1KCkTg=; b=JgrTsycMwDtQ8YkJILAu97
	sU7Lpfbv0KTh5PSswHrmeRSINFJO5WabeE/UHUERDvktanVCEFW6dC8qns5+Z2+l
	Cjnc7NwzQYAwLubiY80qlCX4puZX0alYeGj65F9cWtCEw2GAAY7C89UMwd4pdjtg
	SRjfpDqGwYSfWXxBJN20cav6pysCwNsVJQ8GlJZ5NZqEzASgL/Fcmg75rGsT6MNp
	27zcjhFS5J3YgadQwEf5/N9fYxsKrTqnI2jnGagmJf17gVtZLPd8PzgvRX2MjHv7
	htLmnSxj6IJEMb+5mKZBHI/xWnscwIUKRioPmBs7BpGyEGzrvNsXOtZMjR5btfZA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuw99e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:30:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OKo3xZ004407;
	Tue, 24 Mar 2026 22:30:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c23v0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:30:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OMTtNp27984584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:29:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35EF158055;
	Tue, 24 Mar 2026 22:30:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58D0558059;
	Tue, 24 Mar 2026 22:30:18 +0000 (GMT)
Received: from [9.61.253.153] (unknown [9.61.253.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:30:18 +0000 (GMT)
Message-ID: <1b43ef89-3924-4a49-b70d-0ae27823bab4@linux.ibm.com>
Date: Tue, 24 Mar 2026 15:30:16 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
References: <20260324212602.GA1151826@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260324212602.GA1151826@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tWaQgNQn3Ih4p4741VjAREe4FuOnowwh
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c3107e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=H1Zm4qlpSOXu0aC8RHUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3MiBTYWx0ZWRfX36APXw7Y36MO
 mLg+X9uCOKxcjr3lpDohZcmJdXVM4UZAxk7RVe0lYK1R92dGIGImXkiZQyiUC6eXNxLZHpVut0n
 FgRCjqL2wpHpj7uG8F0/5j1mYfrCsDHFv3FapKnOQuZ+j89t5NxKV2/74EtWzzvcouNFWnE30Xp
 dyd/8i/QoMYFt+tKeOll+/AuxlYKh5fA3dgHL3uVhCtTYNeU/FTPfL9jR8WaSpag9UALr95alUf
 uGShgduuRYvA0owwKiZbx/4H/gqObD+dhz5JEzMUoj/xzw4kamBuXrecWXaWf715AS5pmYNWQkw
 YN3LKjL9aDfAOW7MUpUKRJDDsgVqgklI2uiMzmIr1YaYTGGgpFo+BUAKmnjbD7S9A89fH/JQT5W
 bvqOgZFvSIkZVpqAV9e3NKi6Sh3B0AX5GdDMDLzQ268ep8pdXRQgj9eHQ3IH3J7NT8v9f/Z63Kl
 HQssw/mZAf4VMDm8uIw==
X-Proofpoint-GUID: tWaQgNQn3Ih4p4741VjAREe4FuOnowwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240172

Hi Bjorn,

On 3/24/2026 2:26 PM, Bjorn Helgaas wrote:
> On Mon, Mar 16, 2026 at 12:15:44PM -0700, Farhan Ali wrote:
>> We are configuring the error signaling on the vast majority of devices and
> Who is "we"?  If a function configures error signaling, can you
> mention the name?

Thanks for taking a look. By 'We' it would refer to userspace/QEMU that 
set up error notification for a vfio device. I took the message verbatim 
from Alex's suggestion[1].

>> it's extremely rare that it fires anyway. This allows userspace to
>> be notified on errors for legacy PCI devices. The Internal Shared
>> Memory (ISM) device on s390 is one such device.
> This commit log talks about things that could be done, but doesn't
> actually say what the patch does or what makes it safe and effective,
> and I'm not VFIO-literate enough for it to be clear.
>
> These pci_is_pcie() tests were added by dad9f8972e04 ("VFIO-AER:
> Vfio-pci driver changes for supporting AER"), so I suppose the
> dad9f8972e04 assumption was that AER was the only error reporting
> mechanism, and AER only exists on PCIe devices?

We don't have the context anymore why PCIe device check was added. Alex 
had suggested to remove the check entirely[1].

> But s390 can report errors for conventional PCI devices, and you want
> VFIO to support that as well?
>
> Obviously this change needs to be safe for all arches, not just s390.
> I suppose it's safe to report the VFIO_PCI_ERR_IRQ_INDEX info
> everywhere; it's just that it will never be used except on s390?  And
> I guess powerpc, which can get to vfio_pci_core_aer_err_detected() via
> eeh_report_failure().
>
> It looks like vfio_pci_driver provides vfio_pci_core_err_handlers
> whether the device is conventional PCI or PCIe, and s390 can already
> call vfio_pci_core_aer_err_detected() (the .error_detected() hook) via
> zpci_event_notify_error_detected(), so this patch makes it possible
> for the guest (QEMU, etc) to learn about it?

Yes, with this patch want to notify the userspace/QEMU about 
conventional PCI devices. I think it should be safe to report 
VFIO_PCI_ERR_IRQ_INDEX even for conventional PCI devices for other 
architectures. AFAIK other architectures would use the AER error 
handling mechanism to report the error and call 
vfio_pci_core_aer_err_detected().

>> For PCI devices on IBM s390 error
>> recovery involves platform firmware and notification to operating system
>> is done by architecture specific way. So the ISM device can still be
>> recovered when notified of an error.
> I guess this error recovery part would be done by the guest ISM
> driver, triggered when when something like QEMU receives the eventfd
> signal from vfio_pci_core_aer_err_detected()?

Yes, we wanted to be able to signal QEMU on an error, so that QEMU can 
appropriately notify the guest about the error. Today the ISM driver 
doesn't register error recovery callbacks. However we can still recover 
from the guest by writing to 'reset' sysfs file.

[1] 
https://lore.kernel.org/all/20250815144855.51f2ac24.alex.williamson@redhat.com/

>
>> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> I don't maintain VFIO, so I'm just kibbitzing here.  Hopefully Alex
> will chime in.
>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
>>   drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>>   2 files changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index f1bd1266b88f..cfd9a51cd194 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -786,8 +786,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>>   			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>>   		}
>>   	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
>> -		if (pci_is_pcie(vdev->pdev))
>> -			return 1;
>> +		return 1;
>>   	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
>>   		return 1;
>>   	}
>> @@ -1163,11 +1162,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>>   	switch (info.index) {
>>   	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
>>   	case VFIO_PCI_REQ_IRQ_INDEX:
>> -		break;
>>   	case VFIO_PCI_ERR_IRQ_INDEX:
>> -		if (pci_is_pcie(vdev->pdev))
>> -			break;
>> -		fallthrough;
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>> index 33944d4d9dc4..64f80f64ff57 100644
>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>> @@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
>>   	case VFIO_PCI_ERR_IRQ_INDEX:
>>   		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
>>   		case VFIO_IRQ_SET_ACTION_TRIGGER:
>> -			if (pci_is_pcie(vdev->pdev))
>> -				func = vfio_pci_set_err_trigger;
>> +			func = vfio_pci_set_err_trigger;
>>   			break;
>>   		}
>>   		break;
>> -- 
>> 2.43.0
>>
