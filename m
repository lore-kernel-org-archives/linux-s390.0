From: David Hildenbrand <david@redhat.com>
Date: Thu, 29 Nov 2018 13:11:19 +0000
Subject: Re: [PATCH v3 07/12] KVM: s390: factor out __find_vcpu_for_floating_irq()
Message-Id: <a18a98c6-05aa-4280-66c5-3b8028c45346@redhat.com>
In-Reply-To: <9c6611fb-55dc-7a54-d124-838b2bdd8455@linux.ibm.com>
References: <9c6611fb-55dc-7a54-d124-838b2bdd8455@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28.11.18 11:19, Michael Mueller wrote:
> This function will be used as well to find a suitable vcpu
> to wakeup in GIB alert interruption context.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 97e5da9a0814..251d01f1e9bf 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1723,18 +1723,14 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>  	return 0;
>  }
>  
> -/*
> - * Find a destination VCPU for a floating irq and kick it.
> - */
> -static void __floating_irq_kick(struct kvm *kvm, u64 type)
> +static struct kvm_vcpu *__find_vcpu_for_floating_irq(struct kvm *kvm)
>  {
>  	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> -	struct kvm_vcpu *dst_vcpu;
>  	int sigcpu, online_vcpus, nr_tries = 0;
>  
>  	online_vcpus = atomic_read(&kvm->online_vcpus);
>  	if (!online_vcpus)
> -		return;
> +		return NULL;
>  
>  	/* find idle VCPUs first, then round robin */
>  	sigcpu = find_first_bit(fi->idle_mask, online_vcpus);
> @@ -1744,10 +1740,22 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
>  			fi->next_rr_cpu = (fi->next_rr_cpu + 1) % online_vcpus;
>  			/* avoid endless loops if all vcpus are stopped */
>  			if (nr_tries++ >= online_vcpus)
> -				return;
> +				return NULL;
>  		} while (is_vcpu_stopped(kvm_get_vcpu(kvm, sigcpu)));
>  	}
> -	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> +	return kvm_get_vcpu(kvm, sigcpu);
> +}
> +
> +/*
> + * Find a destination VCPU for a floating irq and kick it.
> + */
> +static void __floating_irq_kick(struct kvm *kvm, u64 type)
> +{
> +	struct kvm_vcpu *dst_vcpu;
> +
> +	dst_vcpu = __find_vcpu_for_floating_irq(kvm);
> +	if (!dst_vcpu)
> +		return;
>  
>  	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
>  	switch (type) {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
