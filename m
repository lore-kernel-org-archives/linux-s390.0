Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbgDHIwK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 04:52:10 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0388XuB9174311
        for <linux-s390@vger.kernel.org>; Wed, 8 Apr 2020 04:52:09 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3091y9vrpc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2020 04:52:08 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 8 Apr 2020 09:51:53 +0100
Subject: Re: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in
 struct mmu_gather
References: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
 <20200330121654.GL20696@hirez.programming.kicks-ass.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 8 Apr 2020 10:51:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200330121654.GL20696@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <68affa6e-44cd-37e3-cdfc-8eec31c4097e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Zhenyu Ye <yezhenyu2@huawei.com>
Cc: npiggin@gmail.com, will.deacon@arm.com, mingo@kernel.org, torvalds@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arm@kernel.org, xiexiangyou@huawei.com, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>

Sorry, just saw that now..

On 30.03.20 14:16, Peter Zijlstra wrote:
> On Sat, Mar 28, 2020 at 12:30:50PM +0800, Zhenyu Ye wrote:
>> Hi all,
>>
>> commit a6d60245 "Track which levels of the page tables have been cleared"
>> added cleared_(ptes|pmds|puds|p4ds) in struct mmu_gather, and the values
>> of them are set in some places. For example:
>>
>> In include/asm-generic/tlb.h, pte_free_tlb() set the tlb->cleared_pmds:
>> ---8<---
>> #ifndef pte_free_tlb
>> #define pte_free_tlb(tlb, ptep, address)			\
>> 	do {							\
>> 		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
>> 		tlb->freed_tables = 1;				\
>> 		tlb->cleared_pmds = 1;				\
>> 		__pte_free_tlb(tlb, ptep, address);		\
>> 	} while (0)
>> #endif
>> ---8<---
>>
>>
>> However, in arch/s390/include/asm/tlb.h, pte_free_tlb() set the tlb->cleared_ptes:
>> ---8<---
>> static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>>                                 unsigned long address)
>> {
>> 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>> 	tlb->mm->context.flush_mm = 1;
>> 	tlb->freed_tables = 1;
>> 	tlb->cleared_ptes = 1;
>> 	/*
>> 	 * page_table_free_rcu takes care of the allocation bit masks
>> 	 * of the 2K table fragments in the 4K page table page,
>> 	 * then calls tlb_remove_table.
>> 	 */
>> 	page_table_free_rcu(tlb, (unsigned long *) pte, address);
>> }
>> ---8<---

adding Gerald and Vasily. Gerald can you have a look?

>>
>>
>> In my view, the cleared_(ptes|pmds|puds) and (pte|pmd|pud)_free_tlb
>> correspond one-to-one.  So we should set cleared_ptes in pte_free_tlb(),
>> then use it when needed.
> 
> So pte_free_tlb() clears a table of PTE entries, or a PMD level entity,
> also see free_pte_range(). So the generic code makes sense to me. The
> PTE level invalidations will have happened on tlb_remove_tlb_entry().
> 
>> I'm very confused about this. Which is wrong? Or is there something
>> I understand wrong?
> 
> I agree the s390 case is puzzling, Martin does s390 need a PTE level
> invalidate for removing a PTE table or was this a mistake?
> 
