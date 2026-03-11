Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FA2D94A0;
	Wed, 11 Mar 2026 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232907; cv=none; b=kLleIbZ2bG8f/zw/38ilrvaKnxAmGRXRhm4QYHmUUcDxITDMwswl/3p91yBPUcWB+fdYBcIsT/oCuF8lWUqCFLGVRiep9vv7nFf8zLdg7z+W1/W61mdeoaEW4IQGHfFOCZ34PyfpAwbqLXPhUV4Y1O5xfSEed2RaUyp5YMB3bJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232907; c=relaxed/simple;
	bh=6h/x6Aa2Gj5DAxOEdnBQnINbbouMbd8Zg9ZEubKZTFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tf0ynx9pekQel+1HYFe81HPlro5OTQiaiTGgnG2ffpu9MxYxUsfN/mDq9UPsoIbDtkZS1nBTR9ru3YnVixtDkVFBaV+5DwyZBmbAMmIFMQDo0VbE4zl/VlspvjzQtFNn0A54RB9+tlSNYLA5jIycapmrxIG14EaqX1zat++1Nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=es3UVyKu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="es3UVyKu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B1nX5x1973470;
	Wed, 11 Mar 2026 12:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EMdXKm
	Oh0SZLHijCdCAN5cUgJGeht054Y1uPHLOACH4=; b=es3UVyKuE/Uy91otvdMKvl
	El3cEmVcH38Yc0lR+pkN65vaiiU5AUOBVODcbzAdvhXNFnFGKia5mOjQoWyVFMiN
	RxLd/QDyEE1LeujepDthzJucQBDY6K+NeSLItk0ru2GlveiqRtxq5kQGSUS/Awgk
	SaBXc6f+lZT03rR8WJFhbIltqGU/EThz9Z/djoKDo+53xTVKy7y+4klz0vtRQLa0
	1dl3wNk/HdwyIHlSGgfF1vxtidwyHC8Mk/8/eczXdpuOHnSOrZswbGT4KKi4TgwW
	pS1UBpyzLwZkCBTNfyhRHYhxvocMUW1sdjam+lnsDh4IRQkBq7Rw3REVzZ17GUIA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyftx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:41:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BBbrVA021150;
	Wed, 11 Mar 2026 12:41:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbswhdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:41:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BCfNc2852914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 12:41:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D871958054;
	Wed, 11 Mar 2026 12:41:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DCA058060;
	Wed, 11 Mar 2026 12:41:18 +0000 (GMT)
Received: from [9.43.80.48] (unknown [9.43.80.48])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 12:41:18 +0000 (GMT)
Message-ID: <ef7212dd-429c-4b64-bad6-4c37d27775d5@linux.ibm.com>
Date: Wed, 11 Mar 2026 18:11:16 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/page_table_check: Pass mm_struct to
 pxx_user_accessible_page()
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <cover.1772812343.git.agordeev@linux.ibm.com>
 <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b162f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Z4Rwk6OoAAAA:8 a=C7LtFB5Z-NQoCHpHwbYA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwNiBTYWx0ZWRfXwcCCldWzVDrG
 7o7iMLZYb7kQOlg32zY2UqTY9DPqvnM6y8Bk2/cr3PMT/yH8FztampVLRo/axBrij/uazvBwbbL
 OSBgHEm17RRmqKoz9BF5LHviaHhCIC5lLB+dYWg4vv0NpgNKgtWjPtCXkWspHemP/ZmdCJgfe9U
 FnuW7/liUax+2s3CKK7wIgFI6IAnsmFZTYV7+cV8hfCChVNIrH8xDjrzEXpZ/nq3hGeJOCYfqar
 7Ds5BAvSQqNrVCXyj9KNI0Cjx1y2lJ89dQGG2Ky1Q6QQFjhdJn7YZh2llki2B5j05eubegnjUBD
 YphNGtXsQOIaOvL8JEMH1bLL7hg6/tkfQsSx1ZiiEiZq0hO798oKR6Of95OhpDnuPwCX0wLhrKm
 TkQMKOTZrTTpmUx4Cg4+ONSk8oCkJ8j2wZUpkHnTitaBBThPS55m41oRe7N+WNnhMp5cLms3wVz
 aeNFL14xyhQ+CVkc9PA==
X-Proofpoint-GUID: CsT0ogmetyAXCRGOSbmrtozIExz6Iu-E
X-Proofpoint-ORIG-GUID: CsT0ogmetyAXCRGOSbmrtozIExz6Iu-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110106


On 3/6/26 9:46 PM, Alexander Gordeev wrote:
> From: Tobias Huschle <huschle@linux.ibm.com>
>
> Unlike other architectures, s390 does not have means to
> distinguish kernel vs user page table entries - neither
> an entry itself, nor the address could be used for that.
> It is only the mm_struct that indicates whether an entry
> in question is mapped to a user space. So pass mm_struct
> to pxx_user_accessible_page() callbacks.
Changes looks fine to me
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> [agordeev@linux.ibm.com: rephrased commit message, removed braces]
>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   arch/arm64/include/asm/pgtable.h             |  6 +++---
>   arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>   arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
>   arch/powerpc/include/asm/pgtable.h           |  4 ++--
>   arch/riscv/include/asm/pgtable.h             |  6 +++---
>   arch/x86/include/asm/pgtable.h               |  6 +++---
>   mm/page_table_check.c                        | 15 ++++++---------
>   8 files changed, 24 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b3e58735c49b..ccf0e0638767 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1263,17 +1263,17 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>   #endif
>   
>   #ifdef CONFIG_PAGE_TABLE_CHECK
> -static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
> +static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
>   {
>   	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
>   }
>   
> -static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
> +static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
>   {
>   	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>   }
>   
> -static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
> +static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
>   {
>   	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>   }
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 001e28f9eabc..75195bb44d06 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -438,7 +438,7 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
>   	return true;
>   }
>   
> -static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
> +static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
>   {
>   	return pte_present(pte) && !is_kernel_addr(addr);
>   }
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 1a91762b455d..a56df313b585 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -549,7 +549,7 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
>   	return arch_pte_access_permitted(pte_val(pte), write, 0);
>   }
>   
> -static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
> +static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
>   {
>   	return pte_present(pte) && pte_user(pte);
>   }
> @@ -925,9 +925,9 @@ static inline bool pud_access_permitted(pud_t pud, bool write)
>   }
>   
>   #define pud_user_accessible_page pud_user_accessible_page
> -static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
> +static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
>   {
> -	return pud_leaf(pud) && pte_user_accessible_page(pud_pte(pud), addr);
> +	return pud_leaf(pud) && pte_user_accessible_page(mm, addr, pud_pte(pud));
>   }
>   
>   #define __p4d_raw(x)	((p4d_t) { __pgd_raw(x) })
> @@ -1096,9 +1096,9 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
>   }
>   
>   #define pmd_user_accessible_page pmd_user_accessible_page
> -static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
> +static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
>   {
> -	return pmd_leaf(pmd) && pte_user_accessible_page(pmd_pte(pmd), addr);
> +	return pmd_leaf(pmd) && pte_user_accessible_page(mm, addr, pmd_pte(pmd));
>   }
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index e6da5eaccff6..0665d0abe89f 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -249,7 +249,7 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
>   	return true;
>   }
>   
> -static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
> +static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
>   {
>   	return pte_present(pte) && !is_kernel_addr(addr);
>   }
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index dcd3a88caaf6..29ed509cd235 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -205,11 +205,11 @@ static inline bool arch_supports_memmap_on_memory(unsigned long vmemmap_size)
>   #endif /* CONFIG_PPC64 */
>   
>   #ifndef pmd_user_accessible_page
> -#define pmd_user_accessible_page(pmd, addr)	false
> +#define pmd_user_accessible_page(mm, addr, pmd)	false
>   #endif
>   
>   #ifndef pud_user_accessible_page
> -#define pud_user_accessible_page(pud, addr)	false
> +#define pud_user_accessible_page(mm, addr, pud)	false
>   #endif
>   
>   #endif /* __ASSEMBLER__ */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 08d1ca047104..affe46cf3bc5 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -984,17 +984,17 @@ static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>   }
>   
>   #ifdef CONFIG_PAGE_TABLE_CHECK
> -static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
> +static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
>   {
>   	return pte_present(pte) && pte_user(pte);
>   }
>   
> -static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
> +static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
>   {
>   	return pmd_leaf(pmd) && pmd_user(pmd);
>   }
>   
> -static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
> +static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
>   {
>   	return pud_leaf(pud) && pud_user(pud);
>   }
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 1662c5a8f445..f9353d5c7464 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1680,17 +1680,17 @@ static inline bool arch_has_hw_nonleaf_pmd_young(void)
>   #endif
>   
>   #ifdef CONFIG_PAGE_TABLE_CHECK
> -static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
> +static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
>   {
>   	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
>   }
>   
> -static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
> +static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
>   {
>   	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) && (pmd_val(pmd) & _PAGE_USER);
>   }
>   
> -static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
> +static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
>   {
>   	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) && (pud_val(pud) & _PAGE_USER);
>   }
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 2708c2b3ac1f..53a8997ec043 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -151,9 +151,8 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
>   	if (&init_mm == mm)
>   		return;
>   
> -	if (pte_user_accessible_page(pte, addr)) {
> +	if (pte_user_accessible_page(mm, addr, pte))
>   		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
> -	}
>   }
>   EXPORT_SYMBOL(__page_table_check_pte_clear);
>   
> @@ -163,9 +162,8 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>   	if (&init_mm == mm)
>   		return;
>   
> -	if (pmd_user_accessible_page(pmd, addr)) {
> +	if (pmd_user_accessible_page(mm, addr, pmd))
>   		page_table_check_clear(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT);
> -	}
>   }
>   EXPORT_SYMBOL(__page_table_check_pmd_clear);
>   
> @@ -175,9 +173,8 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>   	if (&init_mm == mm)
>   		return;
>   
> -	if (pud_user_accessible_page(pud, addr)) {
> +	if (pud_user_accessible_page(mm, addr, pud))
>   		page_table_check_clear(pud_pfn(pud), PUD_SIZE >> PAGE_SHIFT);
> -	}
>   }
>   EXPORT_SYMBOL(__page_table_check_pud_clear);
>   
> @@ -211,7 +208,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
>   
>   	for (i = 0; i < nr; i++)
>   		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep + i));
> -	if (pte_user_accessible_page(pte, addr))
> +	if (pte_user_accessible_page(mm, addr, pte))
>   		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
>   }
>   EXPORT_SYMBOL(__page_table_check_ptes_set);
> @@ -241,7 +238,7 @@ void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
>   
>   	for (i = 0; i < nr; i++)
>   		__page_table_check_pmd_clear(mm, addr + PMD_SIZE * i, *(pmdp + i));
> -	if (pmd_user_accessible_page(pmd, addr))
> +	if (pmd_user_accessible_page(mm, addr, pmd))
>   		page_table_check_set(pmd_pfn(pmd), stride * nr, pmd_write(pmd));
>   }
>   EXPORT_SYMBOL(__page_table_check_pmds_set);
> @@ -257,7 +254,7 @@ void __page_table_check_puds_set(struct mm_struct *mm, unsigned long addr,
>   
>   	for (i = 0; i < nr; i++)
>   		__page_table_check_pud_clear(mm, addr + PUD_SIZE * i, *(pudp + i));
> -	if (pud_user_accessible_page(pud, addr))
> +	if (pud_user_accessible_page(mm, addr, pud))
>   		page_table_check_set(pud_pfn(pud), stride * nr, pud_write(pud));
>   }
>   EXPORT_SYMBOL(__page_table_check_puds_set);
