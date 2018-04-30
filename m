From: David Hildenbrand <david@redhat.com>
Date: Mon, 30 Apr 2018 13:24:42 +0000
Subject: Re: [PATCH v1 3/3] KVM: s390: generalize kvm_s390_get_tod_clock_ext()
Message-Id: <d7e65659-73bb-27a7-77fe-e044f586445b@redhat.com>
In-Reply-To: <20180430151239.6e8d69c8.cohuck@redhat.com>
References: <20180430151239.6e8d69c8.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 27.04.2018 17:58, Collin Walling wrote:
> On 04/27/2018 08:36 AM, David Hildenbrand wrote:
>> Move the Multiple-epoch facility handling into it and rename it to
>> kvm_s390_get_tod_clock().
>>
>> This leaves us with:
>> - kvm_s390_set_tod_clock()
>> - kvm_s390_get_tod_clock()
>> - kvm_s390_get_tod_clock_fast()
>>
>> So all Multiple-epoch facility is hidden in these functions.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Aside from the one nit described below, looks good to me!
> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 
>> ---
>>  arch/s390/kvm/kvm-s390.c | 22 +++++++++-------------
>>  1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b3eee3cc6e78..fb753b9439fa 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1033,8 +1033,8 @@ static int kvm_s390_set_tod(struct kvm *kvm, struct kvm_device_attr *attr)
>>  	return ret;
>>  }
>>  
>> -static void kvm_s390_get_tod_clock_ext(struct kvm *kvm,
>> -					struct kvm_s390_vm_tod_clock *gtod)
>> +static void kvm_s390_get_tod_clock(struct kvm *kvm,
>> +				   struct kvm_s390_vm_tod_clock *gtod)
> 
> Nit: add one more whitespace for the second line of parameters

It only looks like it's wrong in the patch file. The end result is correct.

Thanks!


-- 

Thanks,

David / dhildenb
