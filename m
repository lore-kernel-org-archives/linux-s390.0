From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 6/6] KVM: s390: generalize
 kvm_s390_get_tod_clock_ext()
Date: Thu, 15 Feb 2018 15:25:06 +0100
Message-ID: <895b24fa-f5ce-4f27-fa74-98add017cba4@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
 <20180207114647.6220-7-david@redhat.com>
 <20180215150833.56a4ba02.cohuck@redhat.com>
 <5618ed59-a3d9-6d5b-f9b7-855111391abd@redhat.com>
 <20180215151700.1e0c5ef2.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180215151700.1e0c5ef2.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 15.02.2018 15:17, Cornelia Huck wrote:
> On Thu, 15 Feb 2018 15:14:37 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 15.02.2018 15:08, Cornelia Huck wrote:
>>> On Wed,  7 Feb 2018 12:46:47 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> Move the Multiple-epoch facility handling into it and rename it to
>>>> kvm_s390_get_tod_clock().
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  arch/s390/kvm/kvm-s390.c | 22 +++++++++-------------
>>>>  1 file changed, 9 insertions(+), 13 deletions(-)  
>>>
>>> Looks correct, but I'm not sure what this buys us?  
>>
>> That we have functions that can be called without having to care about
>> multiple epoch facility
>>
>> Namely
>>
>> kvm_s390_set_tod_clock()
>> kvm_s390_get_tod_clock()
>> kvm_s390_get_tod_clock_fast()
>>
> 
> OK, that makes sense. Maybe add something like that to the patch
> description?
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Sure, can do! Thanks!

-- 

Thanks,

David / dhildenb
