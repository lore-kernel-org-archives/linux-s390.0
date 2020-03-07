Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:2841 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgCGHFO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 7 Mar 2020 02:05:14 -0500
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
 <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
 <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c40d907a-b64b-ae0d-e58f-33dddf0e8edc@c-s.fr>
Date: Sat, 7 Mar 2020 08:05:09 +0100
MIME-Version: 1.0
In-Reply-To: <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



Le 07/03/2020 à 01:56, Anshuman Khandual a écrit :
> 
> 
> On 03/07/2020 06:04 AM, Qian Cai wrote:
>>
>>
>>> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>
>>> Hmm, set_pte_at() function is not preferred here for these tests. The idea
>>> is to avoid or atleast minimize TLB/cache flushes triggered from these sort
>>> of 'static' tests. set_pte_at() is platform provided and could/might trigger
>>> these flushes or some other platform specific synchronization stuff. Just
>>
>> Why is that important for this debugging option?
> 
> Primarily reason is to avoid TLB/cache flush instructions on the system
> during these tests that only involve transforming different page table
> level entries through helpers. Unless really necessary, why should it
> emit any TLB/cache flush instructions ?

What's the problem with thoses flushes ?

> 
>>
>>> wondering is there specific reason with respect to the soft lock up problem
>>> making it necessary to use set_pte_at() rather than a simple WRITE_ONCE() ?
>>
>> Looks at the s390 version of set_pte_at(), it has this comment,
>> vmaddr);
>>
>> /*
>>   * Certain architectures need to do special things when PTEs
>>   * within a page table are directly modified.  Thus, the following
>>   * hook is made available.
>>   */
>>
>> I can only guess that powerpc  could be the same here.
> 
> This comment is present in multiple platforms while defining set_pte_at().
> Is not 'barrier()' here alone good enough ? Else what exactly set_pte_at()
> does as compared to WRITE_ONCE() that avoids the soft lock up, just trying
> to understand.
> 


Argh ! I didn't realise that you were writing directly into the page 
tables. When it works, that's only by chance I guess.

To properly set the page table entries, set_pte_at() has to be used:
- On powerpc 8xx, with 16k pages, the page table entry must be copied 
four times. set_pte_at() does it, WRITE_ONCE() doesn't.
- On powerpc book3s/32 (hash MMU), the flag _PAGE_HASHPTE must be 
preserved among writes. set_pte_at() preserves it, WRITE_ONCE() doesn't.

set_pte_at() also does a few other mandatory things, like calling 
pte_mkpte()

So, the WRITE_ONCE() must definitely become a set_pte_at()

Christophe
