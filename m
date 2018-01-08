From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] KVM: s390: drop use of spin lock in
 __floating_irq_kick
Date: Mon, 8 Jan 2018 13:10:38 +0100
Message-ID: <078285ca-7777-1870-dcd6-ecd683ec6c0e@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
 <20171220155300.102321-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-5-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 20.12.2017 16:52, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> It is not required to take to a lock to protect access to the cpuflags
> of the local interrupt structure of a vcpu as the performed operation
> is an atomic_or.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 024ad8bcc516..818aa4248b0f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1569,7 +1569,6 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
>  
>  	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
>  	li = &dst_vcpu->arch.local_int;
> -	spin_lock(&li->lock);
>  	switch (type) {
>  	case KVM_S390_MCHK:
>  		atomic_or(CPUSTAT_STOP_INT, li->cpuflags);
> @@ -1581,7 +1580,6 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
>  		atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
>  		break;
>  	}
> -	spin_unlock(&li->lock);
>  	kvm_s390_vcpu_wakeup(dst_vcpu);
>  }
>  
> 

I remember that being somehow used to avoid the target VCPU just
clearing the indicators via __reset_intercept_indicators().

But as far as I can see, this has no effect and
set_intercept_indicators() will take care of it. In the worst case, we
have too many flags set, simply resulting in a VCPU exit and the
superfluous flags getting cleared.

So this looks sane to me.

-- 

Thanks,

David / dhildenb
