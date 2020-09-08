Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59320 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731143AbgIHQKc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 12:10:32 -0400
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <70a3dcb5-5ed1-6efa-6158-d0573d6927da@de.ibm.com>
Date: Tue, 8 Sep 2020 14:09:01 +0200
In-Reply-To: <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>



On 08.09.20 07:06, Christophe Leroy wrote:
> 
> 
> Le 07/09/2020 à 20:00, Gerald Schaefer a écrit :
>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
>> code") introduced a subtle but severe bug on s390 with gup_fast, due to
>> dynamic page table folding.
>>
>> The question "What would it require for the generic code to work for s390"
>> has already been discussed here
>> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
>> and ended with a promising approach here
>> https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
>> which in the end unfortunately didn't quite work completely.
>>
>> We tried to mimic static level folding by changing pgd_offset to always
>> calculate top level page table offset, and do nothing in folded pXd_offset.
>> What has been overlooked is that PxD_SIZE/MASK and thus pXd_addr_end do
>> not reflect this dynamic behaviour, and still act like static 5-level
>> page tables.
>>
> 
> [...]
> 
>>
>> Fix this by introducing new pXd_addr_end_folded helpers, which take an
>> additional pXd entry value parameter, that can be used on s390
>> to determine the correct page table level and return corresponding
>> end / boundary. With that, the pointer iteration will always
>> happen in gup_pgd_range for s390. No change for other architectures
>> introduced.
> 
> Not sure pXd_addr_end_folded() is the best understandable name, allthough I don't have any alternative suggestion at the moment.
> Maybe could be something like pXd_addr_end_fixup() as it will disappear in the next patch, or pXd_addr_end_gup() ?
> 
> Also, if it happens to be acceptable to get patch 2 in stable, I think you should switch patch 1 and patch 2 to avoid the step through pXd_addr_end_folded()

given that this fixes a data corruption issue, wouldnt it be the best to go forward
with this patch ASAP and then handle the other patches on top with all the time that
we need?
> 
> 
>>
>> Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
>> Cc: <stable@vger.kernel.org> # 5.2+
>> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++++++++++++
>>   include/linux/pgtable.h         | 16 +++++++++++++
>>   mm/gup.c                        |  8 +++----
>>   3 files changed, 62 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 7eb01a5459cd..027206e4959d 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -512,6 +512,48 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
>>   }
>>   #define mm_pmd_folded(mm) mm_pmd_folded(mm)
>>   +/*
>> + * With dynamic page table levels on s390, the static pXd_addr_end() functions
>> + * will not return corresponding dynamic boundaries. This is no problem as long
>> + * as only pXd pointers are passed down during page table walk, because
>> + * pXd_offset() will simply return the given pointer for folded levels, and the
>> + * pointer iteration over a range simply happens at the correct page table
>> + * level.
>> + * It is however a problem with gup_fast, or other places walking the page
>> + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
>> + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
>> + * a stack variable, which cannot be used for pointer iteration at the correct
>> + * level. Instead, the iteration then has to happen by going up to pgd level
>> + * again. To allow this, provide pXd_addr_end_folded() functions with an
>> + * additional pXd value parameter, which can be used on s390 to determine the
>> + * folding level and return the corresponding boundary.
>> + */
>> +static inline unsigned long rste_addr_end_folded(unsigned long rste, unsigned long addr, unsigned long end)
> 
> What does 'rste' stands for ?
> 
> Isn't this line a bit long ?

this is region/segment table entry according to the architecture. 
On our platform we do have the pagetables with a different format that
next levels (segment table -> 1MB granularity, region 3rd table -> 2 GB
granularity, region 2nd table -> 4TB granularity, region 1st table -> 8 PB
granularity. ST,R3,R2,R1 have the same format and are thus often called
crste (combined region and segment table entry).
