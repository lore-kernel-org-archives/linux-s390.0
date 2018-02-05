From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: take care of clock-comparator sign control
Date: Mon, 5 Feb 2018 14:49:43 +0100
Message-ID: <46f04587-a7aa-af93-0af5-93733863d4a1@redhat.com>
References: <20180205104030.643-1-david@redhat.com>
 <7eba1a30-7881-0b05-3ab0-8fe5fe17a088@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <7eba1a30-7881-0b05-3ab0-8fe5fe17a088@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05.02.2018 13:46, Christian Borntraeger wrote:
> Adding Collin. 
> 
> On 02/05/2018 11:40 AM, David Hildenbrand wrote:
>> Missed when enabling the Multiple-epoch facility. If the facility is
>> installed and the control is set, a sign based comaprison has to be
>> performed.
>>
>> Right now we would inject wrong interrupts and ignore interrupt
>> conditions. Also the sleep time is calculated in a wrong way.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> We might be able to drop the checks for "test_kvm_facility(vcpu->kvm, 139)",
>> as the architecture states:
>>
>> "When the multiple-epoch facility is not installed in the configuration
>> and the clock-comparator sign control is one, it is unpredictable whether
>> the comparison follows the rules of unsigned or signed binary arithmetic."
>>
>> Have no machine to test this with :(
> 
> It will be somewhat hard to test anyway since the compare only differs for the
> case where one value (TOD or CKC) is before the 2042 date and the other one is
> after. have to think about a good test without needing an LPAR that is close
> to the wraparound.
> 

You can set the TOD in the guest to a certain value just before/after
overflowing. But you would also need a guest that actually makes use of
the overflow bit. Could be done in a unit test (e.g. kvm-unit-tests).

>>
>>  arch/s390/kvm/interrupt.c | 32 ++++++++++++++++++++++++++------
>>  1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 024ad8bcc516..6566a853c0b8 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -170,7 +170,16 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
>>
>>  static int ckc_irq_pending(struct kvm_vcpu *vcpu)
>>  {
>> -	if (vcpu->arch.sie_block->ckc >= kvm_s390_get_tod_clock_fast(vcpu->kvm))
>> +	int64_t ckc, tod;
>> +
>> +	if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul &&
>> +	    test_kvm_facility(vcpu->kvm, 139)) {
>> +		ckc = vcpu->arch.sie_block->ckc;
>> +		tod = kvm_s390_get_tod_clock_fast(vcpu->kvm);
>> +		if (ckc >= tod)
>> +			return 0;
>> +	} else if (vcpu->arch.sie_block->ckc >=
>> +		   kvm_s390_get_tod_clock_fast(vcpu->kvm))
>>  		return 0;
> 
> Instead of changing the compare depending on another compare, maybe adding
> 0x8000000000000000 to the unsigned values makes the change easier to grasp.

Not sure if that is easier to understand, but would also work.

> On the other hand your code is closer to POP.
> 

Thanks!

-- 

Thanks,

David / dhildenb
