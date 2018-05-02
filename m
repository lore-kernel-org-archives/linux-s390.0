From: David Hildenbrand <david@redhat.com>
Date: Wed, 02 May 2018 14:30:29 +0000
Subject: Re: [PATCH v1 1/2] KVM: s390: vsie: fix < 8k check for the itdba
Message-Id: <99860769-ef66-3000-0caf-e27bba76e587@redhat.com>
In-Reply-To: <a4bffd7f-4f54-c856-3ca2-3c362fdda8d9@de.ibm.com>
References: <a4bffd7f-4f54-c856-3ca2-3c362fdda8d9@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02.05.2018 14:34, Christian Borntraeger wrote:
> 
> 
> On 05/02/2018 01:08 PM, David Hildenbrand wrote:
>> By missing an "L", we might detect some addresses to be <8k,
>> although they are not.
>>
>> e.g. for itdba = 100001fff
>> !(gpa & ~0x1fffU) -> 1
>> !(gpa & ~0x1fffUL) -> 0
>>
>> So we would report a SIE validity intercept although everything is fine.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Should be cc stable as is might break vsie if for some reason the block is
> aligned by 4G.

The only known user is KVM itself. As it has an offset in the sie_page,
this scenario can at least never happen with KVMs we know.

So I'll leave this decision to you. Thanks!

> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


-- 

Thanks,

David / dhildenb
