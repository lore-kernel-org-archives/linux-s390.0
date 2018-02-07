From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 4/6] KVM: s390: consider epoch index on TOD clock
 syncs
Date: Wed, 7 Feb 2018 17:43:53 -0500
Message-ID: <65719abd-37bb-c9ca-88d5-ecb230696a04@linux.vnet.ibm.com>
References: <20180207114647.6220-1-david@redhat.com>
 <20180207114647.6220-5-david@redhat.com>
 <438d8539-44fa-2661-ea04-a0642c48c9fa@linux.vnet.ibm.com>
 <402a12fb-28ec-c11a-de72-222fde27517b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <402a12fb-28ec-c11a-de72-222fde27517b@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/07/2018 04:35 PM, David Hildenbrand wrote:
> On 07.02.2018 21:08, Collin L. Walling wrote:
>> On 02/07/2018 06:46 AM, David Hildenbrand wrote:
>>> For now, we don't take care of over/underflows. Especially underflows
>>> are critical:
>>>
>>> Assume the epoch is currently 0 and we get a sync request for delta=1,
>>> meaning the TOD is moved forward by 1 and we have to fix it up by
>>> subtracting 1 from the epoch. Right now, this will leave the epoch
>>> index untouched, resulting in epoch=-1, epoch_idx=0, which is wrong.
>>>
>>> We have to take care of over and underflows, also for the VSIE case. So
>>> let's factor out calculation into a separate function.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    arch/s390/kvm/kvm-s390.c | 32 +++++++++++++++++++++++++++++---
>>>    1 file changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index d007b737cd4d..c2b62379049e 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -179,6 +179,28 @@ int kvm_arch_hardware_enable(void)
>>>    static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
>>>    			      unsigned long end);
>>>
>>> +static void kvm_clock_sync_scb(struct kvm_s390_sie_block *scb, u64 delta)
>>> +{
>>> +	u64 delta_idx = 0;
>>> +
>>> +	/*
>>> +	 * The TOD jumps by delta, we have to compensate this by adding
>>> +	 * -delta to the epoch.
>>> +	 */
>>> +	delta = -delta;
>>> +
>>> +	/* sign-extension - we're adding to signed values below */
>>> +	if ((s64)delta < 0)
>>> +		delta_idx = 0xff;
>>> +
>>> +	scb->epoch += delta;
>>> +	if (scb->ecd & ECD_MEF) {
>>> +		scb->epdx += delta_idx;
>>> +		if (scb->epoch < delta)
>>> +			scb->epdx += 1;
>>> +	}
>>> +}
>>> +
>> Is the sync always a jump forward? Do we need to worry about a borrow
>> from the epdx in case of underflow?
> I can jump forward and backwards, so delta can be positive or negative,
> resulting in -delta being positive or negative.
>
> The rules of unsigned addition should make sure that all cases are
> covered. (I tried to find a counter example but wasn't able to find one)

Agreed. I just wrote down a few edge cases myself... it seems to check 
out nicely.

>
> (Especially, this is the same code pattern as found in
> arch/s390/kvm/vsie.c:register_shadow_scb(), which also adds two signed
> numbers.)
>
>>>    /*
>>>     * This callback is executed during stop_machine(). All CPUs are therefore
>>>     * temporarily stopped. In order not to change guest behavior, we have to
>>> @@ -194,13 +216,17 @@ static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
>>>    	unsigned long long *delta = v;
>>>
>>>    	list_for_each_entry(kvm, &vm_list, vm_list) {
>>> -		kvm->arch.epoch -= *delta;
>>>    		kvm_for_each_vcpu(i, vcpu, kvm) {
>>> -			vcpu->arch.sie_block->epoch -= *delta;
>>> +			kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
>>> +			if (i == 0) {
>>> +				kvm->arch.epoch = vcpu->arch.sie_block->epoch;
>>> +				kvm->arch.epdx = vcpu->arch.sie_block->epdx;
>> Are we safe by setting the kvm epochs to the sie epochs wrt migration?
> Yes, in fact they should be the same for all VCPUs, otherwise we are in
> trouble. The TOD has to be the same over all VCPUs.
>
> So we should always have
> - kvm->arch.epoch == vcpu->arch.sie_block->epoch
> - kvm->arch.epdx == vcpu->arch.sie_block->epdx
> for all VCPUs, otherwise their TOD could differ.

Perhaps then this could be shortened to calculate the epochs only once, 
then set
each vcpu to those values instead ofcalculating on each iteration?

I imagine the number of iterations would never be large enough to cause any
considerable performance hits, though.

>
> This is also guaranteed by the way we calculate and update these numbers.
>
> The only special case is if somebody would be using
> set_on_reg/get_one_reg with KVM_REG_S390_EPOCHDIFF, setting different
> values - very unlikely and bad.
>
>>> +			}
>>>    			if (vcpu->arch.cputm_enabled)
>>>    				vcpu->arch.cputm_start += *delta;
>>>    			if (vcpu->arch.vsie_block)
>>> -				vcpu->arch.vsie_block->epoch -= *delta;
>>> +				kvm_clock_sync_scb(vcpu->arch.vsie_block,
>>> +						   *delta);
>>>    		}
>>>    	}
>>>    	return NOTIFY_OK;
>


-- 
- Collin L Walling
