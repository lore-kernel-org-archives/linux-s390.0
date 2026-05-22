Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEA400E1B;
	Fri, 22 May 2026 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464160; cv=none; b=K6r6M2o/NUeF8VrqALRFl1VSfBljUSQ1eCEIDgfARTjYYpqVKWKc7H1RDooDkz8+6FkJf7liWYgoOcPK4+SEQ4r9PS25ZgnmiR08LQuNbMEhSOxXJGpuJY+A2e3AS79b7ZxXzKxCCvhsvNKyQ0R38ORwsRDxZPGlqYC0jASdBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464160; c=relaxed/simple;
	bh=sUqS+RiVvz66OSblPd/7PIejIYT5taU4juyl1DXEeo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYfbR0H5IhSwqMEc+xPVms1Iti+qYJTObp4oqJED7IE5OoPK/CX/S82hmzP6Luvd1s/X7RpEK904MBAzTEMrGO7BxeYnukiXFzSWTF3TI8gKBGapXCu/AVKAlW3/XeD/8IeoOZA1ubPCvXtZNx94ILNPs1WAAoD12wOqBMGZ+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ni/FRil7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ni/FRil7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ME0gos1950620;
	Fri, 22 May 2026 15:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qfY64L
	188KHKxft4si1rfgi5ccweBhUDe5pqly6Wnjw=; b=ni/FRil7mHLX55OrqhjXY+
	M/R7s/pgQxNuJPQzgCKbwGVFH1LM5BmGYINmjDE24XX1swabU9etsIYHviLw7K6i
	Hk+qYMBDitwDhZaI/OEcxIVKkLLVla9EtRPAtQxcSDacXLV8rJ61D6Cfk8si5r35
	vSlj7PKp/tWfwwWOkW+ytOAvTXa1EgU3lFW4v69ufPwQ3BZnE6ZlEOPenUPu73+9
	pY6L1JADBvFB4a+UW2F+UdDDZamulPbrpzL1HgxQcM8si8Jy7tNXo16ktc7PnRQm
	W/xoG2RzC8qpez/Zozodtj5W7CdbdF6fD/NUia2vXQ8iqChTi/4lDd+Oe07IzBMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88u558-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:35:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFOFnG030408;
	Fri, 22 May 2026 15:35:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkhfwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:35:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MFZSqb30933594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 15:35:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 213335805D;
	Fri, 22 May 2026 15:35:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84CC75805A;
	Fri, 22 May 2026 15:35:26 +0000 (GMT)
Received: from [9.16.58.46] (unknown [9.16.58.46])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 15:35:26 +0000 (GMT)
Message-ID: <7ae97379-bb6b-4045-a795-95d8acd09c09@linux.ibm.com>
Date: Fri, 22 May 2026 10:35:24 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/20] [DO NOT MERGE] s390: Expose protected
 virtualization through cc_platform_has()
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-3-aneesh.kumar@kernel.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260522042815.370873-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 0CrITYD2KTwMiysGe5e3SKJRPfrwYCev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MCBTYWx0ZWRfX7p/KSlRKoYCk
 WdB0E9m9xZuL/rIjKRXD85Jkz1+SSkyISAJzmG9d3YJxMGle/4CAMAAqfefZiBqX2ySJgcyj6bH
 hiDq+D0NoF8LEzF21DcRRyYkBrbto3yMI19jcTQ+s10wfsZeno1234PxG+khmlpDstvyewyN1/i
 ITly3dMx3Zf8tONRkfzsZTNKkRcLK7iVp70TghSo8Z0NDP0K0rr5Fbww53B98wOKAvrY8VM4l8p
 V+tRqv3adk2Rg38XtAu7JXzlBf8asTVu/scrI1r8//2CbYKDzHpPdsXENFNUIpV640AWxUCRQ8c
 +/ePPRj5fI4dTZCm2Hm4hWMDdldz41mtCQRVyAaqlpzOF2yeMnGyZa++ELqTBRRCzAeCi5aOowi
 DQ3c1w1pWxFUtBoQnkOLcsfPTyM/3+zrEJe58blhgvu0ykDy9PUxfxjmfG5gV3XVWor9NafcNr3
 TQv3jJsiFQEx2DodgSA==
X-Proofpoint-GUID: h7hTqgwP-XCCJwt9xUz9Qqw26vagibFE
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a1077c3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=blRdvrxeXnuE--CKtYQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220150

On 5/21/2026 11:27 PM, Aneesh Kumar K.V (Arm) wrote:
> Protected virtualization guests use memory encryption, so advertise that to
> the rest of the kernel through cc_platform_has(CC_ATTR_MEM_ENCRYPT).
>
> s390 already forces DMA mappings to be unencrypted for protected
> virtualization guests through force_dma_unencrypted(). Add
> ARCH_HAS_CC_PLATFORM and provide the matching cc_platform_has()
> implementation
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Jaehoon  Kim <jhkim@linux.ibm.com>
> ---
>   arch/s390/Kconfig   |  1 +
>   arch/s390/mm/init.c | 14 ++++++++++++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..9b5e6029e043 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -87,6 +87,7 @@ config S390
>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>   	select ARCH_HAS_CC_CAN_LINK
> +	select ARCH_HAS_CC_PLATFORM
>   	select ARCH_HAS_CPU_FINALIZE_INIT
>   	select ARCH_HAS_CURRENT_STACK_POINTER
>   	select ARCH_HAS_DEBUG_VIRTUAL
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 1f72efc2a579..ad3c6d92b801 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -50,6 +50,7 @@
>   #include <linux/virtio_anchor.h>
>   #include <linux/virtio_config.h>
>   #include <linux/execmem.h>
> +#include <linux/cc_platform.h>
>   
>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
>   pgd_t invalid_pg_dir[PTRS_PER_PGD] __section(".bss..invalid_pg_dir");
> @@ -140,6 +141,19 @@ bool force_dma_unencrypted(struct device *dev)
>   	return is_prot_virt_guest();
>   }
>   
> +
> +bool cc_platform_has(enum cc_attr attr)
> +{
> +	switch (attr) {
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return is_prot_virt_guest();
> +
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cc_platform_has);
> +
>   /* protected virtualization */
>   static void __init pv_init(void)
>   {

Hello Aneesh,

Thanks for adding this s390 support patch.

The previous v4 series broke virtio initialization and caused boot
failures on s390. With this patch in v5, the issue is completely
resolved and virtio devices now initialize successfully and are
working well.

I'm going to do some more testing and will let you know if I run
into any issues.

Thanks,
Jaehoon.


