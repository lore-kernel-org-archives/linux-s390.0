From: David Hildenbrand <david@redhat.com>
Date: Thu, 29 Nov 2018 13:09:16 +0000
Subject: Re: [PATCH v3 06/12] KVM: s390: add kvm reference to struct sie_page2
Message-Id: <760b0f1f-de7b-5640-041b-125b22ab0e29@redhat.com>
In-Reply-To: <20181128101943.155542-7-mimu@linux.ibm.com>
References: <20181128101943.155542-7-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28.11.18 11:19, Michael Mueller wrote:
> Adding the kvm reference to struct sie_page2 will allow to
> determine the kvm a given gisa belongs to:
> 
>   container_of(gisa, struct sie_page2, gisa)->kvm
> 
> This functionality will be required to process a gisa in
> gib alert interruption context.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 3 ++-
>  arch/s390/kvm/kvm-s390.c         | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 02227457945e..3e3225ea303b 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -802,7 +802,8 @@ struct sie_page2 {
>  	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
>  	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
>  	struct kvm_s390_gisa gisa;			/* 0x0900 */
> -	u8 reserved920[0x1000 - 0x920];			/* 0x0920 */
> +	struct kvm *kvm;				/* 0x0920 */
> +	u8 reserved928[0x1000 - 0x928];			/* 0x0928 */
>  };
>  
>  struct kvm_s390_vsie {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 46dcf9ea59d3..e00eae7ec0b8 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2219,6 +2219,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	if (!kvm->arch.sie_page2)
>  		goto out_err;
>  
> +	kvm->arch.sie_page2->kvm = kvm;
>  	kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
>  
>  	for (i = 0; i < kvm_s390_fac_size(); i++) {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
