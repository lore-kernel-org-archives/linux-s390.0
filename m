Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207F3D4131;
	Fri, 24 Apr 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036259; cv=none; b=UGv89kVkwHP7+blEI1TgmRIxsasavd8tIzp9xTjiiYyv302YxQi8psBoi09cxsx8qS+h9NO5udsApLIdI6JeBjALkn235UdpeVMuzoW1EbbGhglG+FvLgpc2ObxD8+sTkq+V8aDKOJtj9XpAKBl+gW5QVkPrx58B6dfTpFoSqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036259; c=relaxed/simple;
	bh=hyv6SBGFwVcqhO/vUb2hYokoqYG3uUc/lIwk/HiP97g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbvwpeoTLu2O3uy6a21WPyW1qrQsktr0dNDIXjflsWDmyEaEBTghpSkLbjT+GqpJjEVoy5qXOfxY0LIW8+Y3vNngSFAOF2m4JNdhX396uWJJ3buvo9/ZhVlXo/rxpJkSY0urzxumkOvrzvlDMnKjbSVcHRjxMAn14t6XbobmCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YTAmPD3W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YTAmPD3W"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OBGS8e3515155;
	Fri, 24 Apr 2026 13:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0VJF5BjvS8GM7djuAFT86Cb8dz+hP6
	1H/1uuQ57XP3A=; b=YTAmPD3Wmg2PQaipZOvsnJb7SY++Bpnqb1Oi6OJcGW1hGt
	TS9RehSuAvuS7iv4S/u8YuU34r99pMIVz9xASqoUFYSlTCeeSek54vT8IQhsvuYY
	fLdpMS5vPYsfRlLo+OZWxBEhkk/bY8655c6YjL5gLhwQ4/g6y89glRqUnsK5lhyJ
	AfjOudcf0T0ULBjtTM8uvXIUex+IFvqUDlEd8NTEyiY0fJin4fj5cEFisJzJkE2B
	TpaguipZqlUn2oUXKeIJKifjQT9W5uWCw4Efh37crGRd8UpVhY/Wf8CkoLUJBxyp
	X6eNAfru+EUgRoFKLZpjcXqCRu1VipA2Yx1XG+Ww==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2dyte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 13:10:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OD5cBx019335;
	Fri, 24 Apr 2026 13:10:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyjxqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 13:10:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63ODAhVO35324326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 13:10:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9369620043;
	Fri, 24 Apr 2026 13:10:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 623922004B;
	Fri, 24 Apr 2026 13:10:43 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Apr 2026 13:10:43 +0000 (GMT)
Date: Fri, 24 Apr 2026 15:10:42 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <104cde89-2a33-4b54-aa2a-86b58bd713d7-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
 <20260423122824.10371E07-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122824.10371E07-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEyMyBTYWx0ZWRfX1RjtwAJWWSsz
 qpmScXILjjYAnDBlPvSxlu9Ahvo+udPgOE5YLGKhK04WbsnzVX+haD313eZ38E2zmfgsnNCyU9Y
 U3D+C61I24pI5nhE4aupbfmeNUUM4X658nMhAruTWOLOCjzZuGVhD+ZWydlZvO7qJY3qqMmccV9
 LnX31tGec0BytswQfa2Evzj//gs5TQYCkyqVJshoJB2+sJvRwRA3wwQbC7tKa5XdpPvgci2DAZa
 F5s13/oajuYvoQ+0SvJFZuXw5dxW/xgcxdST9RjX2rAReUZ9QYAwLnTY6PbcZFAV/Vg/Zm0IuLb
 SYwzHLFx9hyLCNpPor3VBfIZ4uh3lG36kus2D9GxAlqMbbMq3/rFMNyVLdbsx/39HzRfXvwRaND
 GvDVic16C+d1OG31NrVuAPUlm4ch8cJ9yitC5zEX/6jlk1qrkrZ7ca6TPmCluNBrfWs6+1J44Si
 dtKGbhwmpDl7UmCmHkA==
X-Proofpoint-ORIG-GUID: ujEY3gnrsjTdVDKXFi_ARkVKSRXL0MSB
X-Proofpoint-GUID: ujEY3gnrsjTdVDKXFi_ARkVKSRXL0MSB
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69eb6bd8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=dDrd5Kku_41XiNK6VLMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240123

On Thu, Apr 23, 2026 at 02:28:24PM +0200, Heiko Carstens wrote:

Hi Heiko!

...
> > With this change, the system calls do:
> > 
> >     lazy_mmu_mode_enable_pte()
> >     ...
> >     <store new PTE values in the per-CPU cache>
> >     ...
> >     lazy_mmu_mode_disable()	// apply cache with one multi-IPTE
> 
> I think what is not necessarily immediately obvious: this approach must assure
> that within such a lazy mmu section there is not a single occurrence of code
> which doesn't use the above mentioned modified primitives to dereference page
> table entry pointers.
> 
> Directly dereferencing such pointers would bypass the cache and lead to
> incorrect results. Therefore we do need some mechanism which makes sure this
> cannot happen. Preferebly that would happen at compile time with static code
> analysis. Alternatively your Kasan implementation would be helpful to find
> something like that after-the-fact.
> 
> However in any case we need something to address this problem.

Will try to come up with something.

...
> 
> > +bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> > +					  unsigned long addr, pte_t *ptep,
> > +					  int *res);
> 
> Could you change this to something like:
> 
> bool __ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> 					    unsigned long addr, pte_t *ptep,
> 					    int *res);
> 
> static inline
> bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> 					  unsigned long addr, pte_t *ptep,
> 					  int *res)
> {
> 	if (__is_defined(__DECOMPRESSOR))
> 		return false;
> 	return __ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, res);
> }
> 
> ? This avoids the ifdef and makes the code easier to read and change.

Yes, I also like it much better and had something similar in early versions.
But backed off to keep the whole header style intact. Anyway, will do.

> > +static inline void set_pte(pte_t *ptep, pte_t pte)
> > +{
> > +	if (!ipte_batch_set_pte(ptep, pte))
> > +		__set_pte(ptep, pte);
> > +}
> 
> Not sure if you analyzed it, but it looks like this might be the reason why
> you see the fork() slowdown: every page table operation now comes with a
> function call, even if is not needed.
> 
> I guess it would be helpful to add an early exit to the ipte_batch() inlines.
> E.g. going back to the example above:
> 
> static inline
> bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> 					  unsigned long addr, pte_t *ptep,
> 					  int *res)
> {
> 	if (__is_defined(__DECOMPRESSOR))
> 		return false;
> --->	if (unlikely(!ipte_batch_active()))
> --->		return false;
> 	return __ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, res);
> }
> 
> Where ipte_batch_active() would be an inline function which simply tests a bit
> in lowcore.

The bit check alone would not be enough - it should be done with the
preemption disabled. Then it would be something like lazy_mmu_mode(),
but with one or more values in the lowcore instead of percpu variable
(at least ::base_pte to check whether ptep falls into the active range).

...
> > +#define PTE_POISON	0
> 
> Is there a reason why the PTE_POISON value is zero? If it can be a different
> value, I would like to propose a PTE which has bit 11 set (the one which must
> be zero). If that would ever be transferred to page table, and it would be
> used, we would see that immediately :)

The main reason was to avoid explicit initialization of per-CPU arrays.
But yes, bit 11 sounds like a much better approach ;)

> > +struct ipte_batch {
> > +	struct mm_struct *mm;
> > +	unsigned long base_addr;
> > +	unsigned long base_end;
> > +	pte_t *base_pte;
> > +	pte_t *start_pte;
> > +	pte_t *end_pte;
> > +	pte_t cache[PTRS_PER_PTE];
> > +};
> > +
> > +static DEFINE_PER_CPU(struct ipte_batch, ipte_range);
> 
> This is ~1MB with 512 possible CPUs. I think it would make sense to allocate
> and free this data structure with CPU hotplug to avoid wasting too much
> memory.

Will do.

> > +static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
> > +{
> > +	pte_t pte = __ptep_get(start);
> > +	pte_t *ptep;
> > +
> > +	*valid = !(pte_val(pte) & _PAGE_INVALID);
> > +
> > +	for (ptep = start + 1; ptep < end; ptep++) {
> > +		pte = __ptep_get(ptep);
> > +		if (*valid) {
> > +			if (pte_val(pte) & _PAGE_INVALID)
> > +				break;
> > +		} else {
> > +			if (!(pte_val(pte) & _PAGE_INVALID))
> > +				break;
> > +		}
> > +	}
> > +
> > +	return ptep - start;
> > +}
> 
> Wouldn't it be possible to shorten this a bit? E.g.:

Will try.

> static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
> {
> 	unsigned long inv;
> 	pte_t *ptep;
> 
> 	inv = pte_val(__ptep_get(start)) & _PAGE_INVALID;
> 	*valid = !inv;
> 	for (ptep = start + 1; ptep < end; ptep++) {
> 		if (pte_val(__ptep_get(ptep)) & _PAGE_INVALID != inv)
> 			break;
> 	}
> 	return ptep - start;
> }
> 
> > +static void __invalidate_pte_range(struct mm_struct *mm, unsigned long addr,
> > +				   int nr_ptes, pte_t *ptep)
> > +{
> > +	atomic_inc(&mm->context.flush_count);
> > +	if (cpu_has_tlb_lc() &&
> > +	    cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
> 
> One line please. Yes, I know, this is more or less copy-pasted, but... :)

Will do.

> Just a general comment about the naming conventions: imho ipte_batch is not a
> nice choice, since the name of the facility is "ipte range". However I would
> abstract even more, since nobody knows if there will be a different
> instruction or facility to achieve all of this in a better way.
> 
> Anyway... maybe rename the file simply to mmu.c or tlb.c and change the
> function prefixes accordingly so we end up with shorter function names?

I would in turn suggest lazy_mmu_ prefix and lazy_mmu.c source name
to emphasize it implements the generic lazy mmu mode. At the same time
keep ipte_batch (or ipte_range rather) in the implementation itself.

Thanks a lot for the review!
