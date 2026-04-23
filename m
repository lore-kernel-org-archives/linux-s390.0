Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6D3BC68D;
	Thu, 23 Apr 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947323; cv=none; b=MfOsA8IAgLrBjVXs0ZmzoRIioC7uO1/3uoj647LXXYWJ++Z7OVAzxwsMdITIJ0X5ZF3Jl32QhGeJghsWVkEWSenDv5ULs5KKAaDyr4tTJIfL+4miPRW83tp/NHBjzr3UcvgynCxhbWxI6ReOYT7QT+vGP0C9WhyweBiWMdre/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947323; c=relaxed/simple;
	bh=yVM0QbW06QLnorRyM1N2xteg5fnH+jiSgChRAkclbBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e37JZ05YL9k5NFdsUzk7PqtEBVzHnCLbcdw9vLSan/LW2yzSmRHDDN65XRYZpA7jVD6GkgWnv3AaCXMsT1aMBiB2SXefTqRZeIuK4uCRxw8g+lS9JmOtWKLk9EfwxqQq4rcjp8+ynOK1/Q+NS3fcp9vDNHZwo/ro+/QS0tCROhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiFeh/F7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiFeh/F7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8GbIt3229166;
	Thu, 23 Apr 2026 12:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eZ//8CUsg3YgmcZgZkiMB1VNBvReL1
	BsscQ9yLvC0Jw=; b=DiFeh/F7cH9LfYfJbVoJY1OxWTpb3EZVVibQskvrqgQnO2
	QXJsCnL44tHdocMYWlWSfDDEFg/8BWmrzY68Htj+GQWAR8/pteOeDA8gBNuohmPR
	gfbEavkJngTeM3aNO1ZZ7chIdNrnEDYpvJkEcz4bjBGeLJyHlha3mgMG9rz2hfiI
	Efur5qdscsaEnjmmut3FGxhEvAyg8iNNcSaECblu3q2mWJeLArcRe5I/T5I+vK/4
	MHY7c/TYh/A+OXZdAhgddlAdIeQC2V1LVokSpnRx7v5zMLNZ0WDvH5j8yofPzgpy
	iff1f0KrkNvv9t/Jkx6JK4zYkP/6A0ouseRdHWXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28jx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:28:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NCKYta002519;
	Thu, 23 Apr 2026 12:28:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkypj28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:28:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NCSRrp61800758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 12:28:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FD8320043;
	Thu, 23 Apr 2026 12:28:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E968E20040;
	Thu, 23 Apr 2026 12:28:26 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Apr 2026 12:28:26 +0000 (GMT)
Date: Thu, 23 Apr 2026 14:28:24 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260423122824.10371E07-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xPLVnJ-L3DAeJDxXIhJkt9NDhD-R0bRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMiBTYWx0ZWRfX9h+ZXNXWPXl8
 kXaYglAvdcDRXPPMA5suMbrlpNintAZvArzEDUahXk97tClt3O3NARpcLT3WnfEsBjRfOs+GFKI
 Uuuz8ei+Qr4nonvcCiXBUaWg/3dhte5xLsEpWYi+iP3ieldh/AFvg6HE+YnwPPvWnEtvbBZVah9
 14kef4dNkJZASGxDaKE4kjVFM2CUkGfp57yspVfgWlk1vp0mglHPcSAUyvibv2AwUMQEQjXfYrS
 R0uHhvCOSCsN/0WQfMZxJo2p8Gy7TdLvvSP3ksJFfeGcNxCPRKACrDUXeAoW31Z2aFkJT4MaSHZ
 WH7n7VGNuKXfDyLGn2LvP8ju6MuaxTSODwzwITiITuqUoa/fYVLCYSurpTqdIQKXhsERoIjG8PY
 BqfQm8xrXP6xKCH0cUZhLwvwdjPI1S0kDXWGm/EXXRTnwFuVmuV1sht4Rh9E5fLE4UwX3yJTJ/2
 DKYoQnwgUSfndkkQfow==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea1070 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pKooZQRL900cGpT7Ur0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xPLVnJ-L3DAeJDxXIhJkt9NDhD-R0bRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230122

On Wed, Apr 15, 2026 at 05:01:23PM +0200, Alexander Gordeev wrote:
> Make use of the IPTE instruction's "Additional Entries" field to
> invalidate multiple PTEs in one go while in lazy MMU mode. This
> is the mode in which many memory-management system calls (like
> mremap(), mprotect(), etc.) update memory attributes.
> 
> To achieve that, the set_pte() and ptep_get() primitives use a
> per-CPU cache to store and retrieve PTE values and apply the
> cached values to the real page table once lazy MMU mode is left.
> 
> The same is done for memory-management platform callbacks that
> would otherwise cause intense per-PTE IPTE traffic, reducing the
> number of IPTE instructions from up to PTRS_PER_PTE to a single
> instruction in the best case. The average reduction is of course
> smaller.
> 
> Since all existing page table iterators called in lazy MMU mode
> handle one table at a time, the per-CPU cache does not need to be
> larger than PTRS_PER_PTE entries. That also naturally aligns with
> the IPTE instruction, which must not cross a page table boundary.
> 
> Before this change, the system calls did:
> 
> 	lazy_mmu_mode_enable_pte()
> 	...
> 	<update PTEs>		// up to PTRS_PER_PTE single-IPTEs
> 	...
> 	lazy_mmu_mode_disable()
> 
> With this change, the system calls do:
> 
>     lazy_mmu_mode_enable_pte()
>     ...
>     <store new PTE values in the per-CPU cache>
>     ...
>     lazy_mmu_mode_disable()	// apply cache with one multi-IPTE

I think what is not necessarily immediately obvious: this approach must assure
that within such a lazy mmu section there is not a single occurrence of code
which doesn't use the above mentioned modified primitives to dereference page
table entry pointers.

Directly dereferencing such pointers would bypass the cache and lead to
incorrect results. Therefore we do need some mechanism which makes sure this
cannot happen. Preferebly that would happen at compile time with static code
analysis. Alternatively your Kasan implementation would be helpful to find
something like that after-the-fact.

However in any case we need something to address this problem.

> +#if !defined(CONFIG_IPTE_BATCH) || defined(__DECOMPRESSOR)
> +static inline
> +bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep,
> +					  int *res)
> +{
> +	return false;
> +}

...

> +bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep,
> +					  int *res);

Could you change this to something like:

bool __ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
					    unsigned long addr, pte_t *ptep,
					    int *res);

static inline
bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
					  unsigned long addr, pte_t *ptep,
					  int *res)
{
	if (__is_defined(__DECOMPRESSOR))
		return false;
	return __ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, res);
}

? This avoids the ifdef and makes the code easier to read and change.

> +static inline void set_pte(pte_t *ptep, pte_t pte)
> +{
> +	if (!ipte_batch_set_pte(ptep, pte))
> +		__set_pte(ptep, pte);
> +}

Not sure if you analyzed it, but it looks like this might be the reason why
you see the fork() slowdown: every page table operation now comes with a
function call, even if is not needed.

I guess it would be helpful to add an early exit to the ipte_batch() inlines.
E.g. going back to the example above:

static inline
bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
					  unsigned long addr, pte_t *ptep,
					  int *res)
{
	if (__is_defined(__DECOMPRESSOR))
		return false;
--->	if (unlikely(!ipte_batch_active()))
--->		return false;
	return __ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, res);
}

Where ipte_batch_active() would be an inline function which simply tests a bit
in lowcore.

> diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
> index 193899c39ca7..0f6c6de447d4 100644
> --- a/arch/s390/mm/Makefile
> +++ b/arch/s390/mm/Makefile
> @@ -11,5 +11,6 @@ obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>  obj-$(CONFIG_PTDUMP)		+= dump_pagetables.o
>  obj-$(CONFIG_PFAULT)		+= pfault.o
> +obj-$(CONFIG_IPTE_BATCH)	+= ipte_batch.o

As already stated before: let's get rid of the Kconfig option. This will be
enabled anyway.

> +#define PTE_POISON	0

Is there a reason why the PTE_POISON value is zero? If it can be a different
value, I would like to propose a PTE which has bit 11 set (the one which must
be zero). If that would ever be transferred to page table, and it would be
used, we would see that immediately :)

> +struct ipte_batch {
> +	struct mm_struct *mm;
> +	unsigned long base_addr;
> +	unsigned long base_end;
> +	pte_t *base_pte;
> +	pte_t *start_pte;
> +	pte_t *end_pte;
> +	pte_t cache[PTRS_PER_PTE];
> +};
> +
> +static DEFINE_PER_CPU(struct ipte_batch, ipte_range);

This is ~1MB with 512 possible CPUs. I think it would make sense to allocate
and free this data structure with CPU hotplug to avoid wasting too much
memory.

> +static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
> +{
> +	pte_t pte = __ptep_get(start);
> +	pte_t *ptep;
> +
> +	*valid = !(pte_val(pte) & _PAGE_INVALID);
> +
> +	for (ptep = start + 1; ptep < end; ptep++) {
> +		pte = __ptep_get(ptep);
> +		if (*valid) {
> +			if (pte_val(pte) & _PAGE_INVALID)
> +				break;
> +		} else {
> +			if (!(pte_val(pte) & _PAGE_INVALID))
> +				break;
> +		}
> +	}
> +
> +	return ptep - start;
> +}

Wouldn't it be possible to shorten this a bit? E.g.:

static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
{
	unsigned long inv;
	pte_t *ptep;

	inv = pte_val(__ptep_get(start)) & _PAGE_INVALID;
	*valid = !inv;
	for (ptep = start + 1; ptep < end; ptep++) {
		if (pte_val(__ptep_get(ptep)) & _PAGE_INVALID != inv)
			break;
	}
	return ptep - start;
}

> +static void __invalidate_pte_range(struct mm_struct *mm, unsigned long addr,
> +				   int nr_ptes, pte_t *ptep)
> +{
> +	atomic_inc(&mm->context.flush_count);
> +	if (cpu_has_tlb_lc() &&
> +	    cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))

One line please. Yes, I know, this is more or less copy-pasted, but... :)

Just a general comment about the naming conventions: imho ipte_batch is not a
nice choice, since the name of the facility is "ipte range". However I would
abstract even more, since nobody knows if there will be a different
instruction or facility to achieve all of this in a better way.

Anyway... maybe rename the file simply to mmu.c or tlb.c and change the
function prefixes accordingly so we end up with shorter function names?
