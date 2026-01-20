Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32356202C48;
	Tue, 20 Jan 2026 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935380; cv=none; b=suZEg2kzSvj36LAtt6pLeioIb9ygOl3mfIZTqBIZLI+k8r8lyf2bt4ChitcN82v6qda0I6Vg6KbmXpcdNF8/5sFH/Bx4di0XRbqVPks4yh7MOHu6pXef8aJlmlA7iiUeTR8FPhX8tPxPPQL3f9VNvTEAw6cnZL+5ffmsTRuaGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935380; c=relaxed/simple;
	bh=eErp0S6os9v/Rn+k1cDr5y3HwwsfY7sOBjLAqxzQXDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGf5jtIE3DLBPjifGnBoke5ZUnBrIH6IVvwShtA58mshSK135Zyeh6opWs18L5Qih9wD2GEROgtEn5rglrzQbBq7EUk2iJIPxkCV2NsQ+EU1cV2rsVgaKxNbwVQoqKxKNzBEOjA77OhDPCYqTpuAL9cDfCMtcg0kAD376d7ajeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JfRphyqx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JfRphyqx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KElIhh022132;
	Tue, 20 Jan 2026 18:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C3mPVg
	t8LUgdxZxYnCbdAa813Umhbt9Ayb6BVH7cBsk=; b=JfRphyqxFnNZHZQidBqp0X
	tTMt9k8ztG59AekY1FD6NOoP6WgApUkP3d4/hfes/mycMHuA+uI41hUR0bQxCLn4
	6g7IMqrJMd86o2qBnMMlPKS9yNy2kCX7SkT9vArIQqzxb7j1yC2s5SCSysvkuhD3
	rS1+OB5ttvxwnAkE5yqrEzawbkMJRGZm8klveiT4A9B7YSWAfp53A8KcTdvyv8cM
	TTkHBHNTOsJsmReqZIl0/N0rdzXxipResyPJVz8K0ViVaihiTIOwGZG438s7kXTg
	K65NIM6r0IfsvFM4ISZn2VjWMKM9ALUcrfHEcK37pRDg1gl/XVQW2hhZvtm0jyTg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufey7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 18:56:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KI18gx024614;
	Tue, 20 Jan 2026 18:56:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarnesq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 18:56:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KIu9Nt24773168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 18:56:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A213A5805A;
	Tue, 20 Jan 2026 18:56:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A4CD5805F;
	Tue, 20 Jan 2026 18:56:08 +0000 (GMT)
Received: from [9.61.246.96] (unknown [9.61.246.96])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 18:56:08 +0000 (GMT)
Message-ID: <0920028c-8084-4a1c-841e-90e0d5485d4a@linux.ibm.com>
Date: Tue, 20 Jan 2026 10:56:07 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
To: Julian Ruess <julianr@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260107183217.1365-1-alifm@linux.ibm.com>
 <20260107183217.1365-10-alifm@linux.ibm.com>
 <DFSQ35HIT6YT.3DTUUNUOEEDHM@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <DFSQ35HIT6YT.3DTUUNUOEEDHM@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T0mPbojh4hBzIYTTgwRHi9zgte-eVeMT
X-Proofpoint-ORIG-GUID: T0mPbojh4hBzIYTTgwRHi9zgte-eVeMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE1NyBTYWx0ZWRfX2woT2qKwTkkW
 vKcaq/Lkg1pNSmUBNgpU20B5D44QaPxOkL6NtXbZdvF7LmEo50/3P5/d/OoL9uEgIDpfKjrr3kF
 uu1NI7HV/u8EfOtp3LbBG7fjk/KchpZ31DJuGpLRpP0BBOBkHoBUSr48NK00CFKevGyicdIcMI+
 iFbRczpMkDvsnjhHwZ7bMWX4NZ6Bl3z2cQt4Szdw7tXCzRoHSmqNKFF6/tXphsSgdl9OFegJQE+
 EmCu9lU74D3BIsBxsCg4/3L65ljCBeSS+720XZV2OzzVdIH+cCxjMnFrOIFQsGvS16IJFMBbkEn
 2829DJhtdOgNz25j4rfoTPe6YcJRJN5uxNtXmbBZ+TcNtVrn7Fb1+MnW/pX1g3DSrKR7jQTYus5
 hYqR2enhEjYcqpfTAe8qO8Eujfq0Ms0Il1c5uqyuqmyHhqmd2zWfMhNYqBRrmtKqoSeN26cIisy
 nX1CQflYpzmnDO9ZRQw==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696fcfcb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=q_SdFccrKIupyLLHt0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200157


On 1/19/2026 8:56 AM, Julian Ruess wrote:
> On Wed Jan 7, 2026 at 7:32 PM CET, Farhan Ali wrote:
>> We are configuring the error signaling on the vast majority of devices and
>> it's extremely rare that it fires anyway. This allows userspace to be
>> notified on errors for legacy PCI devices. The Internal Shared Memory (ISM)
>> device on s390x is one such device. For PCI devices on IBM s390x error
>> recovery involves platform firmware and notification to operating system
>> is done by architecture specific way. So the ISM device can still be
>> recovered when notified of an error.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c  | 6 ++----
>>   drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index c92c6c512b24..0fdce5234914 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -778,8 +778,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>>   			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>>   		}
>>   	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
>> -		if (pci_is_pcie(vdev->pdev))
>> -			return 1;
>> +		return 1;
>>   	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
>>   		return 1;
>>   	}
>> @@ -1157,8 +1156,7 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>>   	case VFIO_PCI_REQ_IRQ_INDEX:
>>   		break;
>>   	case VFIO_PCI_ERR_IRQ_INDEX:
>> -		if (pci_is_pcie(vdev->pdev))
>> -			break;
>> +		break;
>>   		fallthrough;
> Isn't the fallthrough unreachable now?
>
> -- snip --

Yes indeed, I forget why I still had the fallthrough statement. But I 
don't think that's needed anymore, since we will have explicit break 
statements for all the valid cases.

Thanks

Farhan


