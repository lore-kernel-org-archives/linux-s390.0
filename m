Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3F27BF7C;
	Thu,  4 Sep 2025 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019406; cv=none; b=nNrji5ebYq19gpULkeqy9Q18tIjcmWPE1z39ntp6S2Uk9GTdfQ9n8Dq2Ofp68Vq6LTYF6aa91y23kPZ05DyKvlqKTJyNRJBvX4ka8IBNE+cLiwA0R6AJwSnemna1St4sZ5Y145QE8HPqeyLhd25r0TjEaWY1b6Pa7Zxj4tIOzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019406; c=relaxed/simple;
	bh=0+JAO72bgTdLrUiNHlhx77p8w8ALu96O4sPB5B0ft8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOO6deL7tV4aGBqw9ViRtPa6s4lPyV/RTNTHwMpZjUYXwj4px623ZAhf+4I7PHrGwuEEEnKeMDJ3VL4GbrqNZYv9zM5penu6/6tMUW/f6ITxACWu2T5dy1uUYM9HQQ/0oQaJLFEfwU9lY95Dg4n6KiMzXftDnVp4OnlZgMhZUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QwkSruKp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QwkSruKp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584DXQ8M031307;
	Thu, 4 Sep 2025 20:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TC7gQc
	Jf7E1ELsGNLmFdV3fkZDlgqOqQ0M6PqkwBgTI=; b=QwkSruKpnr61Jjw1xo3JIf
	oLXFIDiyZJjGNFQFzFdEwlfAwFn/2+3M0H6/X0eTN9wPcN/r8bMMHDDyB0Th6Bvt
	9ZkYvLSJxeILMRAv2qOjoz1m6re7uM6CM8qfZT7j9eufNHOfSprcYWkxVDAFx/in
	RoKliKmUkPeLa5avQe8c25dDOAl/akuUmnjqpSgswoHx+XLI1RT+1R7QVmEhEM2Y
	d6+BtYw+R7WP/pWA+iLxGyJXJ+XnTpuv15EJ+nY8oJOb0KBq1LyRu+AytSGsqgpe
	Nm2WjcU6+QyB5DKWlhS7n1jM5G+GqaMUYwInj691b6MzfKKxu0ncVn7LwawoOl9w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurcnqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 20:56:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584JEVC0021205;
	Thu, 4 Sep 2025 20:56:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpxdr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 20:56:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584KuZE946661974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 20:56:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A31958054;
	Thu,  4 Sep 2025 20:56:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2A55804E;
	Thu,  4 Sep 2025 20:56:33 +0000 (GMT)
Received: from [9.61.17.116] (unknown [9.61.17.116])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 20:56:33 +0000 (GMT)
Message-ID: <f9e38796-bb97-4846-8f4c-b92421cadc2f@linux.ibm.com>
Date: Thu, 4 Sep 2025 16:56:32 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/s390: Make attach succeed when the device was
 surprise removed
To: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX3wXbKAEgOvtZ
 n64Hm2mRAa2fRoaLqIzK/YwmScqF3TMX780tnWyXvF2kQg5WvGW0WndoNE+951a8+/chXjfkofz
 ovYOr6THy6y5U5e0Bnsteo6+WxxV4YtwRl4ACWNOuk69Fjqr8DQJtTLw5LtL8xDD2F6EStAj67d
 y0C/BRQ0AVS8fMngssn2R4DyGt7Ul9rRKV+u8i6TYBS2bB5hJZDPADojr5AK8KztuqrelD47Hm+
 1fT/napTgVSCglUMkP4IeZXELlZTJMxOpsVujGJqoyFuTI/mFg3sG6D1w9fqNai/p2s4gNz2XxC
 g/RETt5sBjED7zytDryUGSYpMRCtPBrWprLslupUranxhOdiMX+vE5j2pgdy1pwNkk+FNbOromt
 YBhBo0FS
X-Proofpoint-GUID: 8clwZ2gKz53G0an8e24FueLFNBCkizo_
X-Proofpoint-ORIG-GUID: 8clwZ2gKz53G0an8e24FueLFNBCkizo_
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b9fd06 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8
 a=VnNF1IyMAAAA:8 a=f94wAlES5zcTxHjwagAA:9 a=QEXdDO2ut3YA:10
 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

On 9/4/25 4:59 AM, Niklas Schnelle wrote:
> When a PCI device is removed with surprise hotplug, there may still be
> attempts to attach the device to the default domain as part of tear down
> via (__iommu_release_dma_ownership()), or because the removal happens
> during probe (__iommu_probe_device()). In both cases zpci_register_ioat()
> fails with a cc value indicating that the device handle is invalid. This
> is because the device is no longer part of the instance as far as the
> hypervisor is concerned.
> 
> Currently this leads to an error return and s390_iommu_attach_device()
> fails. This triggers the WARN_ON() in __iommu_group_set_domain_nofail()
> because attaching to the default domain must never fail.
> 
> With the device fenced by the hypervisor no DMAs to or from memory are
> possible and the IOMMU translations have no effect. Proceed as if the
> registration was successful and let the hotplug event handling clean up
> the device.
> 
> This is similar to how devices in the error state are handled since
> commit 59bbf596791b ("iommu/s390: Make attach succeed even if the device
> is in error state") except that for removal the domain will not be
> registered later. This approach was also previously discussed at the
> link.
> 
> Handle both cases, error state and removal, in a helper which checks if
> the error needs to be propagated or ignored. Avoid magic number
> condition codes by using the pre-existing, but never used, defines for
> PCI load/store condition codes and rename them to reflect that they
> apply to all PCI instructions.
> 
> Cc: stable@vger.kernel.org # v6.2
> Link: https://lore.kernel.org/linux-iommu/20240808194155.GD1985367@ziepe.ca/
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci_insn.h | 10 +++++-----
>  drivers/iommu/s390-iommu.c       | 26 +++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 12 deletions(-)
>

Makes sense to me.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
