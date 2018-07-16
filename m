From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Jul 2018 13:41:14 +0000
Subject: Re: [PATCH] KVM: s390/vsie: avoid sparse warning
Message-Id: <f808798a-9ac2-6eee-30fe-7bb1feda8871@redhat.com>
In-Reply-To: <91f6b4c2-600c-519b-7d2d-89a67fedb0ba@de.ibm.com>
References: <91f6b4c2-600c-519b-7d2d-89a67fedb0ba@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 16.07.2018 15:10, Christian Borntraeger wrote:
> 
> 
> On 07/16/2018 01:43 PM, David Hildenbrand wrote:
>> On 16.07.2018 10:37, Christian Borntraeger wrote:
>>> This is a non-functional change that avoids
>>> arch/s390/kvm/vsie.c:839:25: warning: context imbalance in 'do_vsie_run' - unexpected unlock
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  arch/s390/kvm/vsie.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 5dd9f7dc5b28..63844b95c22c 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -823,6 +823,8 @@ static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>   *          - < 0 if an error occurred
>>>   */
>>>  static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>> +	__releases(vcpu->kvm->srcu)
>>> +	__acquires(vcpu->kvm->srcu)
>>>  {
>>>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>>>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>>>
>>
>> Why isn't the same needed in __vcpu_run() ?
> 
> Because it first takes the lock. sparse complains if the first action is to release the lock.
> 

Indeed, I ignored the first lock outside of the loop.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
