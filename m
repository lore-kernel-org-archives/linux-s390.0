Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13C27AC41;
	Tue,  6 May 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535975; cv=none; b=n0gEiJPctL2FaBVVh13NZ9c/e/g5jSgJK8z4JwgYguP6YuCEM717sUf/9Y39kxp0IoNNGbHVlCg6JvrqqLobs992g14MsWSXpp7ESax/TkmL0FUgfoqlmphJm59WntuK0YLd3LlUjqp6GHWWsMU6llBPl3pnROtcWZyH413hs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535975; c=relaxed/simple;
	bh=Sx1HQ7uHIfpU0TlWJZVounK32E3CzZjtpC0aD4TCBPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxGHDp0qJuMhw36uLugjinrnmEVB2jx/RwxVaDMm+PzqiPWUlw8zU85xuzuBLmB4aNDhiIzjEzGSz3D/tfURlt9EVr/BVPMP8WrXPu7jAZw3BAVd7GyNb69LecL13EH6v22DqFEvsaCEksxDBut/1lxmlMFrMQnRsFKCXv7RG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YV75fVWt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YV75fVWt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546A4LD5010869;
	Tue, 6 May 2025 12:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vf/iktNQ2AmPr6Q+t9oVj3VwPkiNre
	+eTtQgMcG2xLo=; b=YV75fVWtSIa23tOBBZTVeryB3RAgsG8/ABpwx2Hhk51vEG
	vaV05eCLrN6aq/boU+MNjCU4JVtfC7lvGRzv80TtDcJep4KUm+NN4XnvehB/vaHe
	weB5y6lG6DZxWgNZphhKAquOmPELgiBG1oLiNahNItzEh6SYnDbgDfKq8DJARjkx
	Q91o5Tn7PRcw6uEgtsIg+SkpuUAdeYWL3p3ZOZtOUt41CbjWdZiXvxN6q5iZjLuq
	MHvFtPe859ikr7UlWXp738Jf6VD54A/pzMt/jv7Ba9shv0n0mbJZbKuReaHRwXj6
	SAnXkVpmn7s3p9NrslafnjfwGBahmlJUiLKEzwHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgbj8qtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 12:52:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546CcINK023452;
	Tue, 6 May 2025 12:52:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgbj8qtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 12:52:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546Clu3q025798;
	Tue, 6 May 2025 12:52:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyukcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 12:52:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546CqetV31392038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 12:52:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318F520049;
	Tue,  6 May 2025 12:52:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B9D20040;
	Tue,  6 May 2025 12:52:39 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 May 2025 12:52:39 +0000 (GMT)
Date: Tue, 6 May 2025 14:52:38 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aBoGFr5EaHFfxuON@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1745940843.git.agordeev@linux.ibm.com>
 <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
 <aBFbCP9TqNN0bGpB@harry>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBFbCP9TqNN0bGpB@harry>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4mfBGix7teZnrAIMT1_J1PZGjukJuupJ
X-Proofpoint-GUID: r_eyKJ4ve2-qsexXr878tGFbuP5SgN2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEyMSBTYWx0ZWRfX1DxlGgzeC0aF JQ/5DcOy3odI/Dd+ROZjOyED+46ICWdau37TqDtYWEofa6iLl3mpgmzHOoYuoNr3WJUq0V02aru gCZ133BgoUazqXZS4HQ51IyN7PxIvUObSwXH5Y5p1I76B5eFNVnyGkLG3x4G/3Kd1i/eGt4IT0Z
 trK35FPPLh2Ao3pEtwq1Ag3GVH/6+bMjXbYgPxjy43BrnXwBSXwYX5irW17UInf6nwnAff/SMue X+PvIPh+YLYQppXVPuLlmy/rinOGUhALTsMPKJne9twXgzH1h1UAoG1XzaJ+KUqDKbcIFTAQCGY c/vifDFNr24bTXfYTqnoNpibUtGYhRi31EuhOhYt3N8wLlsImmMc/cNtDxGLs+/BM260qJ7Jjpd
 oDVx19qIncXAMtAXcoJMvczC+N+1Z7j+KBLP8RVZLK3CM1Dude0tdVlsgKsL4rfRu9OoloD1
X-Authority-Analysis: v=2.4 cv=FJcbx/os c=1 sm=1 tr=0 ts=681a061c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=-ziGmjT95ElobUBgwqYA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=679 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060121

On Wed, Apr 30, 2025 at 08:04:40AM +0900, Harry Yoo wrote:

Hi Harry,

> On Tue, Apr 29, 2025 at 06:08:41PM +0200, Alexander Gordeev wrote:
> > apply_to_pte_range() enters the lazy MMU mode and then invokes
> > kasan_populate_vmalloc_pte() callback on each page table walk
> > iteration. However, the callback can go into sleep when trying
> > to allocate a single page, e.g. if an architecutre disables
> > preemption on lazy MMU mode enter.
> 
> Should we add a comment that pte_fn_t must not sleep in
> apply_to_pte_range()?

See the comment in include/linux/pgtable.h

"In the general case, no lock is guaranteed to be held between entry and exit 
of the lazy mode. So the implementation must assume preemption may be enabled
and cpu migration is possible; it must take steps to be robust against this.
(In practice, for user PTE updates, the appropriate page table lock(s) are   
held, but for kernel PTE updates, no lock is held)."

It is Ryan Roberts who brougth some order [1] here, but I would go further
and make things simple by enforcing the kernel PTE updates should also assume
the preemption is disabled.

But that is a separate topic and could only be done once this patch is in.

> > On s390 if make arch_enter_lazy_mmu_mode() -> preempt_enable()
> > and arch_leave_lazy_mmu_mode() -> preempt_disable(), such crash
> > occurs:
> > 
> >     [  553.332108] preempt_count: 1, expected: 0
> >     [  553.332117] no locks held by multipathd/2116.
> >     [  553.332128] CPU: 24 PID: 2116 Comm: multipathd Kdump: loaded Tainted:
> >     [  553.332139] Hardware name: IBM 3931 A01 701 (LPAR)
> >     [  553.332146] Call Trace:
> >     [  553.332152]  [<00000000158de23a>] dump_stack_lvl+0xfa/0x150
> >     [  553.332167]  [<0000000013e10d12>] __might_resched+0x57a/0x5e8
> >     [  553.332178]  [<00000000144eb6c2>] __alloc_pages+0x2ba/0x7c0
> >     [  553.332189]  [<00000000144d5cdc>] __get_free_pages+0x2c/0x88
> >     [  553.332198]  [<00000000145663f6>] kasan_populate_vmalloc_pte+0x4e/0x110
> >     [  553.332207]  [<000000001447625c>] apply_to_pte_range+0x164/0x3c8
> >     [  553.332218]  [<000000001448125a>] apply_to_pmd_range+0xda/0x318
> >     [  553.332226]  [<000000001448181c>] __apply_to_page_range+0x384/0x768
> >     [  553.332233]  [<0000000014481c28>] apply_to_page_range+0x28/0x38
> >     [  553.332241]  [<00000000145665da>] kasan_populate_vmalloc+0x82/0x98
> >     [  553.332249]  [<00000000144c88d0>] alloc_vmap_area+0x590/0x1c90
> >     [  553.332257]  [<00000000144ca108>] __get_vm_area_node.constprop.0+0x138/0x260
> >     [  553.332265]  [<00000000144d17fc>] __vmalloc_node_range+0x134/0x360
> >     [  553.332274]  [<0000000013d5dbf2>] alloc_thread_stack_node+0x112/0x378
> >     [  553.332284]  [<0000000013d62726>] dup_task_struct+0x66/0x430
> >     [  553.332293]  [<0000000013d63962>] copy_process+0x432/0x4b80
> >     [  553.332302]  [<0000000013d68300>] kernel_clone+0xf0/0x7d0
> >     [  553.332311]  [<0000000013d68bd6>] __do_sys_clone+0xae/0xc8
> >     [  553.332400]  [<0000000013d68dee>] __s390x_sys_clone+0xd6/0x118
> >     [  553.332410]  [<0000000013c9d34c>] do_syscall+0x22c/0x328
> >     [  553.332419]  [<00000000158e7366>] __do_syscall+0xce/0xf0
> >     [  553.332428]  [<0000000015913260>] system_call+0x70/0x98
> > 
> > Instead of allocating single pages per-PTE, bulk-allocate the
> > shadow memory prior to applying kasan_populate_vmalloc_pte()
> > callback on a page range.
> >
> > Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
> > 
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  mm/kasan/shadow.c | 65 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 49 insertions(+), 16 deletions(-)
> > 
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index 88d1c9dcb507..ea9a06715a81 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -292,30 +292,65 @@ void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> >  {
> >  }
> >  
> > +struct vmalloc_populate_data {
> > +	unsigned long start;
> > +	struct page **pages;
> > +};
> > +
> >  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> > -				      void *unused)
> > +				      void *_data)
> >  {
> > -	unsigned long page;
> > +	struct vmalloc_populate_data *data = _data;
> > +	struct page *page;
> > +	unsigned long pfn;
> >  	pte_t pte;
> >  
> >  	if (likely(!pte_none(ptep_get(ptep))))
> >  		return 0;
> >  
> > -	page = __get_free_page(GFP_KERNEL);
> > -	if (!page)
> > -		return -ENOMEM;
> > -
> > -	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
> > -	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
> > +	page = data->pages[PFN_DOWN(addr - data->start)];
> > +	pfn = page_to_pfn(page);
> > +	__memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
> > +	pte = pfn_pte(pfn, PAGE_KERNEL);
> >  
> >  	spin_lock(&init_mm.page_table_lock);
> > -	if (likely(pte_none(ptep_get(ptep)))) {
> > +	if (likely(pte_none(ptep_get(ptep))))
> >  		set_pte_at(&init_mm, addr, ptep, pte);
> > -		page = 0;
> 
> With this patch, now if the pte is already set, the page is leaked?

Yes. But currently it is leaked for previously allocated pages anyway,
so no change in behaviour (unless I misread the code).

> Should we set data->pages[PFN_DOWN(addr - data->start)] = NULL 
> and free non-null elements later in __kasan_populate_vmalloc()?

Should the allocation fail on boot, the kernel would not fly anyway.
If for whatever reason we want to free, that should be a follow-up
change, as far as I am concerned.

> > -	}
> >  	spin_unlock(&init_mm.page_table_lock);
> > -	if (page)
> > -		free_page(page);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> > +{
> > +	unsigned long nr_pages, nr_total = PFN_UP(end - start);
> > +	struct vmalloc_populate_data data;
> > +	int ret;
> > +
> > +	data.pages = (struct page **)__get_free_page(GFP_KERNEL);
> > +	if (!data.pages)
> > +		return -ENOMEM;
> > +
> > +	while (nr_total) {
> > +		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> > +		__memset(data.pages, 0, nr_pages * sizeof(data.pages[0]));
> > +		if (nr_pages != alloc_pages_bulk(GFP_KERNEL, nr_pages, data.pages)) {
> 
> When the return value of alloc_pages_bulk() is less than nr_pages,
> you still need to free pages in the array unless nr_pages is zero.

Same reasoning for not to free as above.

> > +			free_page((unsigned long)data.pages);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		data.start = start;
> > +		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> > +					  kasan_populate_vmalloc_pte, &data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		start += nr_pages * PAGE_SIZE;
> > +		nr_total -= nr_pages;
> > +	}
> > +
> > +	free_page((unsigned long)data.pages);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -348,9 +383,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
> >  	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
> >  	shadow_end = PAGE_ALIGN(shadow_end);
> >  
> > -	ret = apply_to_page_range(&init_mm, shadow_start,
> > -				  shadow_end - shadow_start,
> > -				  kasan_populate_vmalloc_pte, NULL);
> > +	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
> >  	if (ret)
> >  		return ret;
> >  
> > -- 
> > 2.45.2
> > 
> > 

1. https://lore.kernel.org/all/20250303141542.3371656-2-ryan.roberts@arm.com/#t

> -- 
> Cheers,
> Harry / Hyeonggon

Thanks!
