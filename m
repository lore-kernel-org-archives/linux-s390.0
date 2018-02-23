From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 11:10:12 +0000
Subject: Re: [PATCH 2/2] KVM: s390: add exit io request stats and simplify code
Message-Id: <5b4fa811-ef50-5d7a-1e28-1ac86c071393@de.ibm.com>
In-Reply-To: <20180223120920.2e511096.cohuck@redhat.com>
References: <20180223120920.2e511096.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/23/2018 12:08 PM, David Hildenbrand wrote:
> On 23.02.2018 12:04, Christian Borntraeger wrote:
>>
>>
>> On 02/23/2018 12:00 PM, David Hildenbrand wrote:
>>> On 23.02.2018 09:11, Christian Borntraeger wrote:
>>>> We want to count IO exit requests in kvm_stat. At the same time
>>>> we can get rid of the handle_noop function.
>>>>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>  arch/s390/include/asm/kvm_host.h |  1 +
>>>>  arch/s390/kvm/intercept.c        | 19 +++++--------------
>>>>  arch/s390/kvm/kvm-s390.c         |  1 +
>>>>  3 files changed, 7 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>> index 27918b15a8ba..22615af0b6e6 100644
>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>> @@ -294,6 +294,7 @@ struct kvm_vcpu_stat {
>>>>  	u64 exit_userspace;
>>>>  	u64 exit_null;
>>>>  	u64 exit_external_request;
>>>> +	u64 exit_io_request;
>>>>  	u64 exit_external_interrupt;
>>>>  	u64 exit_stop_request;
>>>>  	u64 exit_validity;
>>>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>>>> index 07c6e81163bf..cad2ea216007 100644
>>>> --- a/arch/s390/kvm/intercept.c
>>>> +++ b/arch/s390/kvm/intercept.c
>>>> @@ -50,18 +50,6 @@ u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
>>>>  	return ilen;
>>>>  }
>>>>  
>>>> -static int handle_noop(struct kvm_vcpu *vcpu)
>>>> -{
>>>> -	switch (vcpu->arch.sie_block->icptcode) {
>>>> -	case 0x10:
>>>> -		vcpu->stat.exit_external_request++;
>>>> -		break;
>>>> -	default:
>>>> -		break; /* nothing */
>>>> -	}
>>>> -	return 0;
>>>> -}
>>>> -
>>>>  static int handle_stop(struct kvm_vcpu *vcpu)
>>>>  {
>>>>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>>>> @@ -458,15 +446,18 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
>>>>  
>>>>  int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>>>>  {
>>>> -	int rc, per_rc = 0;
>>>> +	int rc = 0, per_rc = 0;
>>>>  
>>>>  	if (kvm_is_ucontrol(vcpu->kvm))
>>>>  		return -EOPNOTSUPP;
>>>>  
>>>>  	switch (vcpu->arch.sie_block->icptcode) {
>>>>  	case ICPT_EXTREQ:
>>>> +		vcpu->stat.exit_external_request++;
>>>> +		break;
>>>>  	case ICPT_IOREQ:
>>>> -		return handle_noop(vcpu);
>>>> +		vcpu->stat.exit_io_request++;
>>>> +		break;
>>>
>>> You now end up executing the code following this switch-case.
>>>
>>> But I assume vcpu->arch.sie_block->icptstatus will never indicate
>>> instruction fetching, so  this should be fine.
>>
>> To play safe I could replace the "break;" with "return 0;" ?
> 
> Yes, please do.
> 
> Can you also have a look if ICPT_KSS is correct?

will have a look, but this will be another patch if you are correct.

> 
> I can see that we don't retry the instruction. So
> vcpu->arch.sie_block->icptstatus might remain set.
> 
> 1. For ICPT_KSS, has the PSW been forwarded? I assume not.
> 2. Can ICPT_KSS even set the icptstatus?
> 
> As we're retrying, no event is to be injected.
> 
> I assume a "return kvm_s390_skey_check_enable(vcpu)" can't hurt.
> 
