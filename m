From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: take care of clock-comparator sign control
Date: Tue, 6 Feb 2018 18:02:18 +0100
Message-ID: <6a30e2cc-0d55-df88-ed04-532284adfd4e@redhat.com>
References: <20180205104030.643-1-david@redhat.com>
 <f3db97d6-4eed-0b60-0573-21f301f87a56@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <f3db97d6-4eed-0b60-0573-21f301f87a56@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


>>   static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
>>   {
>> -	u64 now, cputm, sltime = 0;
>> +	u64 now, cputm, ckc, sltime = 0;
>> +	int64_t ckc_signed, now_signed;
>>
>>   	if (ckc_interrupts_enabled(vcpu)) {
>> -		now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
>> -		sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
>> -		/* already expired or overflow? */
>> -		if (!sltime || vcpu->arch.sie_block->ckc <= now)
>> +		if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul &&
>> +		    test_kvm_facility(vcpu->kvm, 139)) {
>> +			now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
>> +			ckc = vcpu->arch.sie_block->ckc;
> 
> 
> Shouldn't you be using now_signed and ckc_signed here?

Yes indeed.

> 
> 
>> +			if (ckc < now)
>> +				sltime = tod_to_ns(now - ckc);
>> +		} else {
>> +			now_signed = kvm_s390_get_tod_clock_fast(vcpu->kvm);
>> +			ckc_signed = vcpu->arch.sie_block->ckc;
> 
> and the unsigned ones here?
> 
> Also you could just compare vcpu->arch.sie_block->ckc and 
> kvm_s390_get_tod_clock_fast(vcpu->kvm)

That leads to ugly long lines (for the comparison and the calculation)

> 
>> +			if (ckc_signed < now_signed)
>> +				sltime = tod_to_ns(now_signed - ckc_signed);
> 
> 
> Shouldn't we only calculate sleep time if ckc is greater than now (in 
> both cases)?
> 

I think you're right!

(this was a 5min hack originally titled RFC, but I screwed up my command
line because I was sending a QEMU patch in between)

Will resend, thanks for having a look! :)

> 
>> +		}
>> +		/* already expired */
>> +		if (!sltime)
>>   			return 0;
>>   		if (cpu_timer_interrupts_enabled(vcpu)) {
>>   			cputm = kvm_s390_get_cpu_timer(vcpu);
> 
> Other than that, this is a heck of a lot easier to read than what we had 
> before.
> 


-- 

Thanks,

David / dhildenb
