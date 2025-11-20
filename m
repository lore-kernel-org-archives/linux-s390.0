Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713536D4E9;
	Thu, 20 Nov 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663680; cv=none; b=Pqcm1iedPimuwUs4kkhLcqmcrfyaKUPh43ZF0sPuVW5vQBmmKehUDPHmVUGdqb4OSBPGcHSwD3XSCwgoL2yaHdD6KThZIvqZyaKibnXEj3/NGWWIbXcgo0xJh92kGYTQR/E4OLTN/Bx059j5WZvlnxrnnrAa8rXkKd6afBNjzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663680; c=relaxed/simple;
	bh=0ijppCF07jvoQQmZRTuXLcA8q6/Ti2u6o8n6pW6GotA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCAHmsvkhF4HNxWcVtLUr0OmDsandcMVAz4oKfjXnUma0FAi/cvjz2tM3lPSI/MOGzM2eNVELlPZehkY17IzqNyo3AF+3KvtLRz8N5tjh4JcHhdvXXUb4nur2qwvK3lBrdE+cP46IqfCgd0gMnMCg8shEE2tm+ak7R60ZVM2NXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nhxX2l0K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nhxX2l0K"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCOFDa021442;
	Thu, 20 Nov 2025 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PXk5pr
	TnP7iBmpblpOWvSOOMim7D8yKG2sAEkKOGx3c=; b=nhxX2l0Ki0RGd8iMGeAyV4
	XsaXf96AZR03YBozCaXRHd+agHXG83rgx9ZLRrdKUwB6VadO586jhjFQ4I09qN/K
	xTAHC5mICQKzsvn7erUvrFvPRirXKPnMaROqZfn2RVhHgzNk/49fXqb1Foqha3yM
	ULbH4U1ahbx9zjlQS1dC5NaYVoqcOvo4SD1XtXVUlwHk/ZDH+DMGKJjJ6jdDgcPo
	ym0f602J1PBoKlDHMM+utrDLXrbCz1FsYqpCwWSPc0bdIxGQ6TIVMewKnWqauFNP
	EiPm78sK+G8KUB6T55w5nH5VrD/NYbg9F6bC0UKLQC350qgHlzMhUs2SlKGqlhMA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwg3nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 18:34:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKH3KlT022354;
	Thu, 20 Nov 2025 18:34:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un80y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 18:34:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKIYXSd43647468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 18:34:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B26658062;
	Thu, 20 Nov 2025 18:34:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FDC95805E;
	Thu, 20 Nov 2025 18:34:32 +0000 (GMT)
Received: from [9.61.249.93] (unknown [9.61.249.93])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Nov 2025 18:34:32 +0000 (GMT)
Message-ID: <ce658d38-0bf7-446c-b225-d434ba6b1e1c@linux.ibm.com>
Date: Thu, 20 Nov 2025 10:34:31 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
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
References: <20251120-implement-msi-domain-v4-0-a01be58e158a@linux.ibm.com>
 <20251120-implement-msi-domain-v4-2-a01be58e158a@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251120-implement-msi-domain-v4-2-a01be58e158a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691f5f3b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-BCE6OF5axh-7YMQz7QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4nnx36oh5Zsz
 6Bzx7R7Q+wtxamS93CJFGA6Y7vsnkOCup9TaCy5kJNKf1d4SCd+DtR2iOt7KEBeI3gSmc8CwFMg
 zvbZQyh0TBtG+vtgsp0w4nB28S0QoE0hBwBxcEzEO92xV4/JtwQBDcEBPL7zc3yFaPcenmpdSp+
 CngJHXf264I0urd4AjL23tBKJhMkxZOcrE2qKcjqmt1VcZemkXEAEzX7u6byaTZvagAtL+GzOFP
 68B7omvBGdXt580T1ojcDUv410EEpBNsClTelOmlUP7cxK4Md8gxVofT45ES4ChIDQ3lFv/r3rV
 1Ux5Xe7yQBKeNXVhYWf3IWi1wddIEePsCUW5ggXk8pvJbo1xKce0m45aogxXo9RQtYJWIx/2Zge
 48iF5xJhO6nsiljhrbVmgyjcM0JgzA==
X-Proofpoint-GUID: CEAOEr6DbhtEZZ5SsZ3GFWomxdHSKFQl
X-Proofpoint-ORIG-GUID: CEAOEr6DbhtEZZ5SsZ3GFWomxdHSKFQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032


On 11/20/2025 2:27 AM, Tobias Schumacher wrote:
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
> achieved by encoding the hwirq using the PCI function id and the MSI
> index.
>
> Signed-off-by: Tobias Schumacher<ts@linux.ibm.com>
> ---
>   arch/s390/Kconfig           |   1 +
>   arch/s390/include/asm/pci.h |   4 +
>   arch/s390/pci/pci_bus.c     |  21 ++-
>   arch/s390/pci/pci_irq.c     | 335 +++++++++++++++++++++++++++-----------------
>   4 files changed, 229 insertions(+), 132 deletions(-)

Thanks for making the changes!

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


