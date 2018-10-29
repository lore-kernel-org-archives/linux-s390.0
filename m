From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 29 Oct 2018 14:04:34 +0000
Subject: Re: [PATCH 06/10] KVM: s390: add kvm reference to struct sie_page2
Message-Id: <6b0e9186-aadd-0205-1077-b7c448e06108@linux.ibm.com>
In-Reply-To: <20181025123751.48809-7-mimu@linux.ibm.com>
References: <20181025123751.48809-7-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25/10/2018 14:37, Michael Mueller wrote:
> Adding the kvm reference to struct sie_page2 will allow to
> determine the kvm a given gisa belongs to:
> 
>    container_of(gisa, struct sie_page2, gisa)->kvm
> 
> This functionality will be required to process a gisa in
> gib alert interruption context.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 3 ++-
>   arch/s390/kvm/kvm-s390.c         | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index a9ec2da399b5..b5f671d7d167 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -793,7 +793,8 @@ struct sie_page2 {
>   	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
>   	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
>   	struct kvm_s390_gisa gisa;			/* 0x0900 */
> -	u8 reserved920[0x1000 - 0x920];			/* 0x0920 */
> +	struct kvm *kvm;				/* 0x0920 */
> +	u8 reserved928[0x1000 - 0x928];			/* 0x0928 */
>   };
>   
>   struct kvm_s390_vsie {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 213d16e5b16a..3b358b62bf55 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2128,6 +2128,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   	if (!kvm->arch.sie_page2)
>   		goto out_err;
>   
> +	kvm->arch.sie_page2->kvm = kvm;
>   	kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
>   
>   	for (i = 0; i < kvm_s390_fac_size(); i++) {
> 

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
