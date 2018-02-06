From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: take care of clock-comparator sign control
Date: Tue, 6 Feb 2018 11:34:49 -0500
Message-ID: <f3db97d6-4eed-0b60-0573-21f301f87a56@linux.vnet.ibm.com>
References: <20180205104030.643-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180205104030.643-1-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/05/2018 05:40 AM, David Hildenbrand wrote:
> Missed when enabling the Multiple-epoch facility. If the facility is
> installed and the control is set, a sign based comaprison has to be
> performed.
>
> Right now we would inject wrong interrupts and ignore interrupt
> conditions. Also the sleep time is calculated in a wrong way.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> We might be able to drop the checks for "test_kvm_facility(vcpu->kvm, 139)",
> as the architecture states:
>
> "When the multiple-epoch facility is not installed in the configuration
> and the clock-comparator sign control is one, it is unpredictable whether
> the comparison follows the rules of unsigned or signed binary arithmetic."

I would drop the MEF check.  We only compare the ckc with the 64-bit 
TOD-Clock
regardless if the facility is present or not.


>
> Have no machine to test this with :(
>
>   arch/s390/kvm/interrupt.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 024ad8bcc516..6566a853c0b8 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -170,7 +170,16 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
>
>   static int ckc_irq_pending(struct kvm_vcpu *vcpu)
>   {
> -	if (vcpu->arch.sie_block->ckc >= kvm_s390_get_tod_clock_fast(vcpu->kvm))
> +	int64_t ckc, tod;
> +
> +	if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul &&
> +	    test_kvm_facility(vcpu->kvm, 139)) {
> +		ckc = vcpu->arch.sie_block->ckc;
> +		tod = kvm_s390_get_tod_clock_fast(vcpu->kvm);
> +		if (ckc >= tod)
> +			return 0;
> +	} else if (vcpu->arch.sie_block->ckc >=
> +		   kvm_s390_get_tod_clock_fast(vcpu->kvm))
>   		return 0;
>   	return ckc_interrupts_enabled(vcpu);
>   }
> @@ -1011,13 +1020,24 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
>
>   static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
>   {
> -	u64 now, cputm, sltime = 0;
> +	u64 now, cputm, ckc, sltime = 0;
> +	int64_t ckc_signed, now_signed;
>
>   	if (ckc_interrupts_enabled(vcpu)) {
> -		now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
> -		sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
> -		/* already expired or overflow? */
> -		if (!sltime || vcpu->arch.sie_block->ckc <= now)
> +		if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul &&
> +		    test_kvm_facility(vcpu->kvm, 139)) {
> +			now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
> +			ckc = vcpu->arch.sie_block->ckc;


Shouldn't you be using now_signed and ckc_signed here?


> +			if (ckc < now)
> +				sltime = tod_to_ns(now - ckc);
> +		} else {
> +			now_signed = kvm_s390_get_tod_clock_fast(vcpu->kvm);
> +			ckc_signed = vcpu->arch.sie_block->ckc;

and the unsigned ones here?

Also you could just compare vcpu->arch.sie_block->ckc and 
kvm_s390_get_tod_clock_fast(vcpu->kvm)

> +			if (ckc_signed < now_signed)
> +				sltime = tod_to_ns(now_signed - ckc_signed);


Shouldn't we only calculate sleep time if ckc is greater than now (in 
both cases)?


> +		}
> +		/* already expired */
> +		if (!sltime)
>   			return 0;
>   		if (cpu_timer_interrupts_enabled(vcpu)) {
>   			cputm = kvm_s390_get_cpu_timer(vcpu);

Other than that, this is a heck of a lot easier to read than what we had 
before.

-- 
- Collin L Walling
