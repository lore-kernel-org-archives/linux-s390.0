Return-Path: <owner-linux-mm@kvack.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v2 5/5] mm: teach platforms not to zero struct pages memory
In-Reply-To: <20170327060032.GB5092@osiris>
References: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com> <1490383192-981017-6-git-send-email-pasha.tatashin@oracle.com> <20170327060032.GB5092@osiris>
Date: Fri, 07 Apr 2017 11:45:23 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bms8rbes.fsf@skywalker.in.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, davem@davemloft.net, willy@infradead.org
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens <heiko.carstens@de.ibm.com> writes:

> On Fri, Mar 24, 2017 at 03:19:52PM -0400, Pavel Tatashin wrote:
>> If we are using deferred struct page initialization feature, most of
>> "struct page"es are getting initialized after other CPUs are started, and
>> hence we are benefiting from doing this job in parallel. However, we are
>> still zeroing all the memory that is allocated for "struct pages" using the
>> boot CPU.  This patch solves this problem, by deferring zeroing "struct
>> pages" to only when they are initialized.
>> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>  arch/powerpc/mm/init_64.c |    2 +-
>>  arch/s390/mm/vmem.c       |    2 +-
>>  arch/sparc/mm/init_64.c   |    2 +-
>>  arch/x86/mm/init_64.c     |    2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index eb4c270..24faf2d 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -181,7 +181,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>>  		if (vmemmap_populated(start, page_size))
>>  			continue;
>> 
>> -		p = vmemmap_alloc_block(page_size, node, true);
>> +		p = vmemmap_alloc_block(page_size, node, VMEMMAP_ZERO);
>>  		if (!p)
>>  			return -ENOMEM;
>> 
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index 9c75214..ffe9ba1 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -252,7 +252,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>>  				void *new_page;
>> 
>>  				new_page = vmemmap_alloc_block(PMD_SIZE, node,
>> -							       true);
>> +							       VMEMMAP_ZERO);
>>  				if (!new_page)
>>  					goto out;
>>  				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
>
> s390 has two call sites that need to be converted, like you did in one of
> your previous patches. The same seems to be true for powerpc, unless there
> is a reason to not convert them?
>

vmemmap_list_alloc is not really struct page allocation right ? We are
just allocating memory to be used as vmemmmap_backing. But considering
we are updating all the three elements of the sturct, we can avoid that
memset . But instead of VMEMMAP_ZERO we can just pass false in that case
?

-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
