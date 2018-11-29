From: David Hildenbrand <david@redhat.com>
Date: Thu, 29 Nov 2018 13:02:26 +0000
Subject: Re: [PATCH v3 04/12] KVM: s390: factor out nullify_gisa()
Message-Id: <9dd22a39-8deb-c6f7-3b3e-8fb4a79a3e41@redhat.com>
In-Reply-To: <20181128101943.155542-5-mimu@linux.ibm.com>
References: <20181128101943.155542-5-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28.11.18 11:19, Michael Mueller wrote:
> This function will be used by the GIB alert handler and during
> the GISA clear operation. Thus it gets factored out here.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 5d20a0ce8a30..97e5da9a0814 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2886,11 +2886,16 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>  	return n;
>  }
>  
> +static void nullify_gisa(struct kvm_s390_gisa *gisa)
> +{
> +	memset(gisa, 0, sizeof(struct kvm_s390_gisa));
> +	gisa->next_alert = (u32)(u64)gisa;
> +}

Just wondering if this should be rather named "reset_gisa" or
"gisa_reset" similar as you are also resetting the next_alert.

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

> +
>  void kvm_s390_gisa_clear(struct kvm *kvm)
>  {
>  	if (kvm->arch.gisa) {
> -		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
> -		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
> +		nullify_gisa(kvm->arch.gisa);
>  		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>  	}
>  }
> 


-- 

Thanks,

David / dhildenb
