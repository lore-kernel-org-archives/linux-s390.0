From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCHi v2] mm: do not drop unused pages when userfaultd is
 running
Date: Tue, 3 Jul 2018 07:23:12 +0200
Message-ID: <f40c57df-d8ea-d317-891b-89959ebf6353@de.ibm.com>
References: <20180702075049.9157-1-borntraeger@de.ibm.com>
 <20180702140638.eb3edfaa611ba9fa018f92eb@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702140638.eb3edfaa611ba9fa018f92eb@linux-foundation.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 07/02/2018 11:06 PM, Andrew Morton wrote:
> On Mon,  2 Jul 2018 09:50:49 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> KVM guests on s390 can notify the host of unused pages. This can result
>> in pte_unused callbacks to be true for KVM guest memory.
>>
>> If a page is unused (checked with pte_unused) we might drop this page
>> instead of paging it. This can have side-effects on userfaultd, when the
>> page in question was already migrated:
>>
>> The next access of that page will trigger a fault and a user fault
>> instead of faulting in a new and empty zero page. As QEMU does not
>> expect a userfault on an already migrated page this migration will fail.
>>
>> The most straightforward solution is to ignore the pte_unused hint if a
>> userfault context is active for this VMA.
>>
>> ...
>>
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -64,6 +64,7 @@
>>  #include <linux/backing-dev.h>
>>  #include <linux/page_idle.h>
>>  #include <linux/memremap.h>
>> +#include <linux/userfaultfd_k.h>
>>  
>>  #include <asm/tlbflush.h>
>>  
>> @@ -1481,7 +1482,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  				set_pte_at(mm, address, pvmw.pte, pteval);
>>  			}
>>  
>> -		} else if (pte_unused(pteval)) {
>> +		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {


>>  			/*
>>  			 * The guest indicated that the page content is of no
>>  			 * interest anymore. Simply discard the pte, vmscan
> 
> A reader of this code will wonder why we're checking
> userfaultfd_armed().  So the writer of this code should add a comment
> which explains this to them ;)  Please.
> 
Something like:                    /*
                         * The guest indicated that the page content is of no
                         * interest anymore. Simply discard the pte, vmscan
                         * will take care of the rest.
			 * A future reference will then fault in a new zero
			 * page. When userfaultfd is active, we must not drop
			 * this page though, as its main user (postcopy
			 * migration) will not expect userfaults on already
			 * copied pages.
                         */

?
