Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352A42AB7;
	Mon,  1 Dec 2025 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626528; cv=none; b=NnosYUyEwZk6eiNDnW2Vv+F+h1KYta6VPN2TzL2Nhg59HDJrhXeB3Qdyfs4bLF3sGE8AwRiYDY3lq64egWgdbBxKTlDr6P7dnggKQteFM23Lg1lACkry3B+lO4NHijm9lHEqCkXzvEs3oak9UXJVpV8z5lisWICRyKxmN2nYXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626528; c=relaxed/simple;
	bh=x89q7oWULK/vJ9LPYD/SMv+1pDR8P52wJ4KKynJrhok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwGlnKHNxkt4h/hBic8rmgyDTNNwsPdNxeu5Vcff8q2/gs2eCFA1IRpEVioSJ4y0A+uVz916wFe9XsiqgmdQ89e51/32lJv+vu/y1unrEbPA3kuL6h4jC32t/yDi0dTG11cvCc0XNryV6v0jaBRcCbnM17bFxJo8UA28AvFJfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhP1fT+3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhP1fT+3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1C2CTk008307;
	Mon, 1 Dec 2025 22:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gBjWkG
	C7Z9TmXvgeaHayznfVA5TjTMmR/cgj6MVtAjM=; b=MhP1fT+3Gwo5kBcTemzFJt
	eCXSQ8x/Pt+IaP7kYWtPBpi5bYXOqwL9dFrcggNRfmsZTkuZH0B/p5ZLWEOw97s7
	9fgCPgPOeizeuSxs8zUoZ41w12bxZFW9TAKDdPW5ZE85M86pC1ka2W7IM7QGpmgs
	953N7lwYEUw6nl6oYSGi6sTPrQD8Zk3kgeWRQKyE/w0NWysGSt/saCEyiTbAAfov
	oxHVukaNAuQWVcSaZKWh8wekcwB+CeWKRw7ZsiCyOtzx29WSc4fuwRPNs58Jhvab
	C496cRxopjHSPPmYk7rxZpUJlBJvCNZeC7ts3BxA+h21htF6A48IR4PQfuRMSxqQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg1r2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:02:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1K4kmn003847;
	Mon, 1 Dec 2025 22:01:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjgngr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:01:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M1wB132375498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:01:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62AA558054;
	Mon,  1 Dec 2025 22:01:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0FC45803F;
	Mon,  1 Dec 2025 22:01:56 +0000 (GMT)
Received: from [9.61.245.160] (unknown [9.61.245.160])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:01:56 +0000 (GMT)
Message-ID: <940e2044-24be-4eba-b14d-aa996c93f9d5@linux.ibm.com>
Date: Mon, 1 Dec 2025 14:01:56 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
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
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
 <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fGdygZPGFXYGbxAc73VaW5loc1HMO_d0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXyD+3lRIplPeV
 QF5jdIPMiF1Zstsk7kElV+Q4pV2ZM1Dr57p0un531JkTuv3ObO6qiHaucwerVtKs4Rkr8m9yibI
 vyPlNpN2mNg3vNP6x7BA0gVF2pGX61JmUoWFNVgWZqvi77bRZvNtVR5lPE32n77IzPuNh2+ImpO
 f9Nu8XTnh1uLRkyJSS1PmCd9Q/nYrOkCdT+C/fnv3KOhv36mP0k5BsyEn3kr4z62kGrcrcqIjOh
 HxnKqN0yHA+uTlxPWuZfsMVmTrBeoldnCh3kx5if2HiyZ/8bvvb7/HmYu4UgOjhXoCvi4kzIijf
 +ok42OvJHZDWK2JW1qRtR3m9ZsbHtYyADsdhBGxg38U74j866Keb5Do/HD+QnP0wqR9DKUHi7Zb
 138YMf8MXTNDQJvTXlrH5a2qwPqrpg==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692e1058 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-BCE6OF5axh-7YMQz7QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fGdygZPGFXYGbxAc73VaW5loc1HMO_d0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016


On 11/27/2025 7:07 AM, Tobias Schumacher wrote:
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
> Signed-off-by: Tobias Schumacher<ts@linux.ibm.com>
> ---
>   arch/s390/Kconfig           |   1 +
>   arch/s390/include/asm/pci.h |   5 +
>   arch/s390/pci/pci.c         |   6 +
>   arch/s390/pci/pci_bus.c     |  18 ++-
>   arch/s390/pci/pci_irq.c     | 310 ++++++++++++++++++++++++++++----------------
>   5 files changed, 224 insertions(+), 116 deletions(-)

LGTM and testing this patch it does fix the issue found in v6.

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



