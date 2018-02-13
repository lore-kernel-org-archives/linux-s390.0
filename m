From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Tue, 13 Feb 2018 15:59:04 +0100
Message-ID: <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.02.2018 15:54, Janosch Frank wrote:
> On 13.02.2018 15:36, David Hildenbrand wrote:
>> On 09.02.2018 10:34, Janosch Frank wrote:
>>> For later migration of huge pages we want to write-protect guest
>>> PMDs. While doing this, we have to make absolutely sure, that the
>>> guest's lowcore is always accessible when the VCPU is running. With
>>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
>>> the invalidation notification bit and kicking the guest out of the SIE
>>> via a notifier function if we need to invalidate such a page.
>>>
>>> With PMDs we do not have PGSTEs or some other bits we could use in the
>>> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
>>> time a host pmd will be invalidated, we will check if the respective
>>> gmap PMD has the bit set and in that case fire up the notifier.
>>>
>>> In the first step we only support setting the invalidation bit, but we
>>> do not support restricting access of guest pmds. It will follow
>>> shortly.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>
>> [...]
>>
>>> +
>>> +/**
>>> + * gmap_pmd_split - Split a huge gmap pmd and use a page table instead
>>> + * @gmap: pointer to guest mapping meta data structure
>>> + * @gaddr: virtual address in the guest address space
>>> + * @pmdp: pointer to the pmd that will be split
>>> + *
>>> + * When splitting gmap pmds, we have to make the resulting page table
>>> + * look like it's a normal one to be able to use the common pte
>>> + * handling functions. Also we need to track these new tables as they
>>> + * aren't tracked anywhere else.
>>> + */
>>> +static int gmap_pmd_split(struct gmap *gmap, unsigned long gaddr, pmd_t *pmdp)
>>> +{
>>> +	unsigned long *table;
>>> +	struct page *page;
>>> +	pmd_t new;
>>> +	int i;
>>> +
>>
>> That's interesting, because the SIE can now suddenly work on these
>> PGSTEs, e.g. not leading to intercepts on certain events (like setting
>> storage keys).
>>
>> How is that intended to be handled? I assume we would somehow have to
>> forbid the SIE from making use of the PGSTE. But that involves clearing
>> certain interception controls, which might be problematic.
> 
> Well, cmma is disabled and storage keys should only be a problem, when
> the pte is invalid without the pgste lock, which should never be the
> case for split pmds.
> 

Are you sure? Because the SIE would suddenly stark working on guest
storage keys stored in the PGSTE if I am not mistaking? So I would
assume that there would have to be some kind of a sync.

But I don't have any documentation at hand, so i can't tell :)

-- 

Thanks,

David / dhildenb
