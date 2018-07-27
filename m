From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 27 Jul 2018 09:15:56 +0000
Subject: Re: [kvms390:hlp_vsie 9/14] arch/s390/mm/pgtable.c:744:18: error: implicit declaration of function '
Message-Id: <f35446b1-4147-3e8e-f12f-b5016661504b@linux.ibm.com>
In-Reply-To: <20180727105551.72804e05@mschwideX1>
References: <20180727105551.72804e05@mschwideX1>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 27.07.2018 10:55, Martin Schwidefsky wrote:
> On Fri, 27 Jul 2018 10:13:42 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> On 27.07.2018 09:46, Christian Borntraeger wrote:
>>> This is with 
>>>
>>> # CONFIG_TRANSPARENT_HUGEPAGE is not set
>>> # CONFIG_HUGETLBFS is not set
>>>
>>> so we need to fence this.
>>> With hugetlbfs enabled this compiles (and also works fine).  
>>
>> We can either ifdef this three times or create a pmd_alloc_map in pgtable.h.
>>
>> I think that's Martin's call to make.
> 
> Hmm, we have a similar sequence in pgtable.c:test_and_clear_guest_dirty

We had a similar sequence, I removed it :)

> 
>         pgd = pgd_offset(mm, addr);
>         p4d = p4d_alloc(mm, pgd, addr);
>         if (!p4d)
>                 return false;
>         pud = pud_alloc(mm, p4d, addr);
>         if (!pud)
>                 return false;
>         pmd = pmd_alloc(mm, pud, addr);
>         if (!pmd)
>                 return false;
> 
> Why not refactor this sequence into a separate function local to pgtable.c?
> That way we can avoid using huge_pte_alloc in set_guest_storage_key.
> 

Will do
