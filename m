Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FB207A32;
	Fri, 21 Nov 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749915; cv=none; b=VmpoPQtkxjt/xUksmHVyr1Fz1M31uZGwtzzizphOFKCqRsM4JyowVty3g/YEE7VDoDCOvlrqqbKFrT438tGl1+kLxz3mGEXffHQ1gvvuW19X310rz4LFy242fwruCqdcNiMzsbJ2fonLIxavhu1sOsqR09Rkjp34ZThcru3SHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749915; c=relaxed/simple;
	bh=TvAEixNfOt78z8o80EslzLNn6abZGPvJ5ah9WTtU6yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aighZs0/E6kWIhAdBmoLoKHTlGEyzZjekSw62ZU/XSX+/pG+RgsZwhwyDACkKE2vb+emgfJcbniUeGU3u+E7EGxJijJ6Dim9/PFqFaJwkMqj50rRuh1cmcOdHxsuWOGReV/bDSPnmkiAVcV0GxIUvQ+3LiHDM4U4eMK04d+eFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MJleUdyg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MJleUdyg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEXLmS002769;
	Fri, 21 Nov 2025 18:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f4cRXM
	E0GpFBHviJk6gtAbbLE+FMj0I7hmoJxcZtBYg=; b=MJleUdygi/SE+JnW3DGgKm
	XpG3BeAZ6SVHuPO8uAsfQU+X2vThPUX+J0xNQJ1PgnnZoojmaHfnTuiUDREg4Y1i
	dg8QaYrqRPHxyB2t3Z6Fo1O1nan5lwEo97XlKheBqEtJefwHaV5G7l3ifcP3KUyf
	PgndB0X5DdA8zKDJOBW4pYGs0NVOL9VM/SJ2pgiGQyeZhldxI8y3nQ2EL90VE4+u
	yvYnO8TcEqRTMY9BZneQ1weSUXFAEIqvHibe664hLsMVQxP+SdRGzI684UGPQiDT
	4d8UUNfOsNZ5D86F3wQ+0x3VQnQxcDwmkmTmLuHQrEerteiO5UsL/IPhuCSDkiSw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjuc36x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 18:31:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALGkpKM007031;
	Fri, 21 Nov 2025 18:31:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62jwpn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 18:31:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALIVmL920906692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:31:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E126358066;
	Fri, 21 Nov 2025 18:31:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CD758063;
	Fri, 21 Nov 2025 18:31:46 +0000 (GMT)
Received: from [9.61.252.112] (unknown [9.61.252.112])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 18:31:45 +0000 (GMT)
Message-ID: <7c854615-8ff7-4f76-8e5c-aa895e9d4adb@linux.ibm.com>
Date: Fri, 21 Nov 2025 10:31:45 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
 <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z1oYYotvjXkooAHlbXCpqSft2Qx8nF6w
X-Proofpoint-ORIG-GUID: z1oYYotvjXkooAHlbXCpqSft2Qx8nF6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8Rk9B+unEfjZ
 WsPoLsHahbwyo3KmkPVC+6vMBc2fs/hKiYMJo165XNZtoFlRZx3tlUXsFUvzlhd5nHWuOjdhlRx
 mE1qeCpCJINU9Z/+WKy7cpmo/lYjJMA4UKFZl4LRUBYja4dwVuWmL4w4JAQ2NtaFxWi6jrcIkTq
 NoC986xlHU87E44DjpsfNkZZoa3hJ6MZOYFm5hSmNALw2s+ubCX2mqWzsbnb6IvTDKHmssqqrqw
 uDlk7ZTeQrWiyP/JG6vmtOgium2lly36rYecanPRrcWd63U6dctcNYwJH/+hsiWpo0Ksc12Kr8x
 VUmTQBzglGdZc0k1waOUx5AMDuCg6mrXe9C6+MeUqIvMDG0NFaGS5ddSEk6bLesIfKP7UprhjyO
 NFXtuW/YqG15TbCBmJHp1hyGezLzQw==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=6920b016 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-BCE6OF5axh-7YMQz7QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032


On 11/21/2025 7:45 AM, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>
> In detail, create an MSI parent domain for each PCI domain. When a PCI
> device sets up MSI or MSI-X IRQs, the library creates a per-device IRQ
> domain for this device, which is used by the device for allocating and
> freeing IRQs.
>
> The per-device domain delegates this allocation and freeing to the
> parent-domain. In the end, the corresponding callbacks of the parent
> domain are responsible for allocating and freeing the IRQs.
>
> The allocation is split into two parts:
> - zpci_msi_prepare() is called once for each device and allocates the
>    required resources. On s390, each PCI function has its own airq
>    vector and a summary bit, which must be configured once per function.
>    This is done in prepare().
> - zpci_msi_alloc() can be called multiple times for allocating one or
>    more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
>    number in the kernel and the hardware IRQ number.
>
> Freeing is split into two counterparts:
> - zpci_msi_free() reverts the effects of zpci_msi_alloc() and
> - zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
>    called once when all IRQs are freed before a device is removed.
>
> Since the parent domain in the end allocates the IRQs, the hwirq
> encoding must be unambiguous for all IRQs of all devices. This is
> achieved by encoding the hwirq using the devfn and the MSI index.
>
> Reviewed-by: Niklas Schnelle<schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher<ts@linux.ibm.com>
> ---
>   arch/s390/Kconfig           |   1 +
>   arch/s390/include/asm/pci.h |   4 +
>   arch/s390/pci/pci_bus.c     |  18 ++-
>   arch/s390/pci/pci_irq.c     | 304 ++++++++++++++++++++++++++++----------------
>   4 files changed, 212 insertions(+), 115 deletions(-)

Most of the changes in v6 were minor changes. Idk if you plan on 
spinning a new revision for Heiko's comment, but the rest of the patch 
looks good to me

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



