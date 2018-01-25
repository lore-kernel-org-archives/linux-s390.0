From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 19/22] s390/mm: Split huge pages if granular
 protection is needed
Date: Thu, 25 Jan 2018 15:39:23 +0100
Message-ID: <c3eb3a5f-fbd7-6581-c88e-cace39bdfbcb@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
 <d886d2af-925b-47ef-300d-99ba9f088df7@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <d886d2af-925b-47ef-300d-99ba9f088df7@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 08:16, Janosch Frank wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
>> A guest can put DAT tables for a lower level guest in the same huge
>> segment as one of its prefixes or a g3 page. This would make it
>> necessary for the segment to be unprotected (because of the prefix)
>> and protected (because of the shadowing) at the same time. This is not
>> possible in this universe.
>>
>> Hence we split the affected huge segment, so we can protect on a
>> per-page basis. Such gmap segments are special and get a new software
>> bit, that helps us handling this edge case.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  arch/s390/include/asm/gmap.h    |  13 ++
>>  arch/s390/include/asm/pgtable.h |   7 +-
>>  arch/s390/mm/fault.c            |  10 +-
>>  arch/s390/mm/gmap.c             | 256 ++++++++++++++++++++++++++++++++++++----
>>  arch/s390/mm/pgtable.c          |  51 ++++++++
>>  5 files changed, 313 insertions(+), 24 deletions(-)
> 
>> @@ -1081,20 +1189,27 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
>>  	spinlock_t *ptl;
>>  	unsigned long vmaddr, dist;
>>  	pmd_t *pmdp, *hpmdp;
>> -	int rc;
>> +	int rc = 0;
>>
>>  	while (len) {
>>  		rc = -EAGAIN;
>>  		vmaddr = __gmap_translate(gmap, gaddr);
>>  		hpmdp = (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
>> +		if (!hpmdp)
>> +			BUG();
>>  		/* Do we need tests here? */
>>  		ptl = pmd_lock(gmap->mm, hpmdp);
>>
>>  		pmdp = gmap_pmd_op_walk(gmap, gaddr);
>>  		if (pmdp) {
>>  			if (!pmd_large(*pmdp)) {
>> -				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
>> -						      bits);
>> +				if (gmap_pmd_is_split(pmdp) &&
>> +				    (bits & GMAP_NOTIFY_MPROT)) {
>> +					pmd_val(*pmdp) |= _SEGMENT_ENTRY_GMAP_IN;
>> +				}
> 
> @David:
> This currently breaks my brain. There *was* a reason why I put this
> there and I was quite insistent that we needed it. Something about
> notification areas on splits, but I absolutely can't remember it. Sigh,
> should've made a comment.
> 
> This might be a leftover from earlier versions, but could also keep us
> from doing mprot notification on pte's.
> 

This is indeed confusing.

Somebody wants to protect are certain memory (e.g. PREFIX) and get
notified on changes to this subpart.

We have a split pmd
 -> we have huge pages in our user process tables
 -> we have 4k pages in our GMAP tables

Now, we protect a subpart of this huge page via PTEs. My assumption is,
that your "mirroring code" might reduce access rights to the PMD in the
user process tables.

So e.g. via user space tables -> 1MB write protected
Via GMAP: only 8K write protected


In addition, you are setting the _SEGMENT_ENTRY_GMAP_IN on the GMAP PMD.
This means, that the pmdp_notify_gmap() calls all notifiers
(gmap_call_notifier) in case the whole PMD is changed (e.g. by write
protecting for migration)

So if we get a gmap_pmdp_xchg(), we would see _SEGMENT_ENTRY_GMAP_IN and
trigger a notification. The PTEs remain unchecked (bad!).


Now, If I understand this correctly, what you would have to do:

gmap_pmdp_xchg() (or rather pmdp_notify_gmap()) has to check whether it
is a real huge page or a split pmd. If split, it has to call the PTE
invalidators of the page table accordingly.

This makes this manual hack unnecessary.

Hope this helps :)

-- 

Thanks,

David / dhildenb
