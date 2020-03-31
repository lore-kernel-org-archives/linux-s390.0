Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in
 struct mmu_gather
References: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
 <20200330121654.GL20696@hirez.programming.kicks-ass.net>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <9c75a85e-5d80-0286-1ce5-89479d49170e@huawei.com>
Date: Tue, 31 Mar 2020 16:15:49 +0800
MIME-Version: 1.0
In-Reply-To: <20200330121654.GL20696@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, schwidefsky@de.ibm.com
Cc: npiggin@gmail.com, will.deacon@arm.com, mingo@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arm@kernel.org, xiexiangyou@huawei.com

Hi Peter,

On 2020/3/30 20:16, Peter Zijlstra wrote:
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

Thanks for your explanation. I can understand now.

>> I'm very confused about this. Which is wrong? Or is there something
>> I understand wrong?
> 
> I agree the s390 case is puzzling, Martin does s390 need a PTE level
> invalidate for removing a PTE table or was this a mistake?
> 

Then we should wait for @ Martin's reply.  Though s390 has never used
this value, I think we still should correct it if this is a mistake.

Thanks,
Zhenyu
