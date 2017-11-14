From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x/mm: cleanup gmap_pte_op_walk()
Date: Tue, 14 Nov 2017 17:28:04 +0100
Message-ID: <5120e5e3-8972-b259-0b7a-c41386638bb7@redhat.com>
References: <20171110151805.7541-1-david@redhat.com>
 <ba803651-3177-ef92-9378-001f4bdf0489@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ba803651-3177-ef92-9378-001f4bdf0489@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 13.11.2017 16:19, Janosch Frank wrote:
> This is KVM, not qemu, subject s/x//
> 
> 
> On 10.11.2017 16:18, David Hildenbrand wrote:
>> gmap_mprotect_notify() refuses shadow gmaps. Turns out that
>> a) gmap_protect_range()
>> b) gmap_read_table()
>> c) gmap_pte_op_walk()
>>
>> Are never called for gmap shadows. And never should be. This dates back
>> to gmap shadow prototypes where we allowed to call mprotect_notify() on
>> the gmap shadow (to get notified about the prefix pages getting removed).
>> This is avoided by always getting notified about any change on the gmap
>> shadow.
>>
>> The only real function for walking page tables on shadow gmaps is
>> gmap_table_walk().
>>
>> So, essentially, these functions should never get called and
>> gmap_pte_op_walk() can be cleaned up. Add some checks to callers of
>> gmap_pte_op_walk().
> 
> This already made sense when discussing, but I traced the callers anyhow
> to make sure we didn't accidentally forget one.
> 
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com> with one nit below
> 

Thanks!

>> @@ -889,7 +879,6 @@ static void gmap_pte_op_end(spinlock_t *ptl)
>>   *
>>   * Called with sg->mm->mmap_sem in read.
>>   *
>> - * Note: Can also be called for shadow gmaps.
> 
> How about also getting rid of the line above this one?
> 

Sure, can the person picking this up fix that one up?

-- 

Thanks,

David / dhildenb
