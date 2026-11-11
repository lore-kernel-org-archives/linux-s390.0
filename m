Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413398;
	b=P/vNArGmXh0gDDbBIKA0fqbMYYrlGBMZK94C/wJGA7B7inJAf8U/ScJmaV6bVMPK8HKK
	 HwqI7vZShfs3ymhL7KINYsANnxz0ut6C4DYBLFpQM3ltYugYcL0wTAe+ozUGmN5uFOhbf
	 PY9vMFO3tdietek066SgexdzMl8Lm7VOIrWTe4UfDez6Aotu7SjTNjzdC3/kdQ7Pxw4Kd
	 0P5eKX24QOwIMQjMSgYjbLgsNXsu+50nAewlLkb1W/bz5i1lVv7mWMTxiXIzs98ipc1fq
	 IEU+SQBAhkYqdGvzh0Sy+UuApb56Axfl9GUnjO6+rINdZzmfYprMdI1G6iI6eE6k8gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413398;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9/VN+AgBbN8CqhTFH+nrp9SHVQTjMtVz5W4ep8N/Oho=;
	b=MUKIhF5pcKpFM+W6KELKO+8LjNKz2sboPpIvMTvEJRx6O0N6Y8dFPw9uJl7yD/KvY04h
	 /AovUch2eUd6LALG4cdafXw0FNpyyHRbLFNq3oDAfpPMOtqixnOfCwUebY5+q85vK1OyG
	 SrKZlUXmSc6x92qRgaKV12Ex/EXdx8wjOLnOubspQFuT8dqZvrHBLlXhBoVqSNIHMSaqQ
	 5wRBKc/5ffHSf0YCG3aK1//030zr5tjmNrWZT689e5C2CN4oELF36sigF58uetM4wjpDl
	 P7SAl+t+MS9gD/i4DFurF1EVr3ZiFGKg3eiIycIHeIu5eb6tLdFmFsBjvtOsrqOflxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=An64Fz3G;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B3606A326
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 16:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=An64Fz3G
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFELNK1653138
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 16:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9/VN+AgBbN8CqhTFH+nrp9SHVQTjMt
	Vz5W4ep8N/Oho=; b=An64Fz3GvV/u2l+S/4C2CzwO6fxAhekUqMvEDtNCpPOoTE
	47D0Ut472QMHNGFi0ChEZC5eSWcjAoGuVGYfWwg2FAxdYMnJQxvur6We+rRLfC9C
	Vew1gUgfyC6CClalQ5svFIy21ME9pcM+KC8+Ohq5mbFsy7X3EtthpBdE5FajXUOk
	S02F+d3/3e/bV6b/9wQnEsFk4AgCJt8PfwySpUcG5yrT/I8PpIF+K0UotUuz5lF1
	LJl+7tMJIyQQ9od1E2D5UnZ+92XFrBlN/C7xBioDwWKe522Iz7cxFuo6UdYLVTyG
	q1NOQuAULyJn9bsoIH93Wha7IeXlnswXsQRy3pAQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6b8jk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 16:09:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF4xia3490875
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 16:09:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309n4bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 16:09:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABG9knx46924134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:09:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B22AC2004B;
	Wed, 11 Nov 2026 16:09:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A8EC20040;
	Wed, 11 Nov 2026 16:09:46 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Nov 2026 16:09:46 +0000 (GMT)
Date: Wed, 11 Nov 2026 17:09:45 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Allow hugepage migration for s390
Message-ID: <acdfe7cd-1f50-4a10-b9cf-5a4318fd582e-agordeev@linux.ibm.com>
References: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BQXNpTQZYRjs25DGGQJsq_wQ8jn6AzJ8
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af4934f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VmSZXfv4L0TOHCfstA4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: BQXNpTQZYRjs25DGGQJsq_wQ8jn6AzJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX1+MW9qDW0x3Q
 Vf5/PBLu1qBBzk9tix0cN9nYgpCyCYN7rgMRJHbjYpeZDgR/BnExMvyxWrgJDf3KxWcJfcnlJnt
 t3CL8Nvhbw4x3YQ4YtgikqXcir8f8fG1/c5bNN3evY2UtXOFJx9LcQrXEPZ9Mp/J+NJUGmbOuWz
 HPh8acus82PqIfemA6PBHOVY3rAsAyzqB8cigqzPtqw0KOuwPFA3tChUa+BWlMAmUGJJOZEu83q
 tyZUNCH4s5mmiWQ3NZVGD1EebKpYu3MQtFIEEVbEqnQYUYaIzSrgbOYABjmoC5Zg7wWdTW0aSXe
 nc1AbxAV6iTi32TdzlxzKR52XO6oC27gMG8OO2pPAL/SbRe8eNAEAONPZnV43xjk/bdr08jz3wx
 8SF5DmFD+A/6I6He8J8rt8fRhPhhPAzOMWnz70Se4ao4/KOYyRiq8EOjPT0cqNai/5azeuNDcQC
 rgKpN5KQk+aCTCDHBjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX0N/KG22cubt/
 EOWsWW5Pj6lUOYU4Ui3o2Y43/HeRl7cg5twm2NfUa19Fafm+4a/AGl+XzSBYZTRB5dDPiE5l6Ut
 jKOuXUlxxsvy6JpHdEN0yTwSDCYYUHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110062

On Fri, Nov 06, 2026 at 06:08:44PM +0100, Gerald Schaefer wrote:
> After hugetlbfs PTE_MARKER support for s390 introduced region-third
> and segment table swap entries, it is possible to also allow hugepage
> migration for s390.
> 
> This fixes the problem that hugetlbfs pages could not be allocated
> from ZONE_MOVABLE memory, which is often used in combination with
> memory hotplug. Therefore, without support for hugepage migration,
> a large portion of system memory could be unavailable for hugetlbfs
> page allocations.
> 
> Besides selecting ARCH_ENABLE_HUGEPAGE_MIGRATION, this only requires
> definition of arch_hugetlb_migration_supported(), which can make use
> of the existing arch_hugetlb_valid_size() function, similar to other
> architectures.
> 
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/s390/Kconfig               |  1 +
>  arch/s390/include/asm/hugetlb.h |  5 +++++
>  arch/s390/mm/hugetlbpage.c      | 14 +++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 612885228824..e3a704f423f3 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -83,6 +83,7 @@ config S390
>  	select ALTERNATE_USER_ADDRESS_SPACE
>  	select ARCH_32BIT_USTAT_F_TINODE
>  	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> +	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_HAS_PMD_SOFTLEAVES if TRANSPARENT_HUGEPAGE
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index aea754b67c89..356a18a75d99 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -17,6 +17,11 @@
>  
>  #define hugepages_supported()	cpu_has_edat1()
>  
> +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +bool arch_hugetlb_migration_supported(struct hstate *h);
> +#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
> +#endif
> +
>  #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t pte, unsigned long sz);
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index f84aa9265430..ce61f8738465 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *) pmdp;
>  }
>  
> -bool __init arch_hugetlb_valid_size(unsigned long size)
> +static bool __hugetlb_valid_size(unsigned long size)
>  {
>  	if (cpu_has_edat1() && size == PMD_SIZE)
>  		return true;
> @@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
>  
>  	return 0;
>  }
> +
> +bool __init arch_hugetlb_valid_size(unsigned long size)
> +{
> +	return __hugetlb_valid_size(size);
> +}
> +
> +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION

Could you please use IS_ENABLED() instead?

> +bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
> +	return __hugetlb_valid_size(huge_page_size(h));
> +}
> +#endif

Otherwise, LGTM.

Thanks!
