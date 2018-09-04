From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 04 Sep 2018 09:41:54 +0000
Subject: Re: [PATCH] KVM: s390: Properly lock mm context allow_gmap_hpage_1m setting
Message-Id: <7b0b8d89-1f63-5084-b613-7d88a828af2d@de.ibm.com>
In-Reply-To: <24f9ee75-7094-e631-186a-c58896fbc804@de.ibm.com>
References: <24f9ee75-7094-e631-186a-c58896fbc804@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 08/30/2018 04:15 PM, Janosch Frank wrote:
> We have to do down_write on the mm semaphore to set a bitfield in the
> mm context.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: a4499382 ("KVM: s390: Add huge page enablement control")

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks applied and scheduled for 4.19.

> ---
>  arch/s390/include/asm/mmu.h | 8 +++++++-
>  arch/s390/kvm/kvm-s390.c    | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
> index f31a15044c24..a8418e1379eb 100644
> --- a/arch/s390/include/asm/mmu.h
> +++ b/arch/s390/include/asm/mmu.h
> @@ -16,7 +16,13 @@ typedef struct {
>  	unsigned long asce;
>  	unsigned long asce_limit;
>  	unsigned long vdso_base;
> -	/* The mmu context allocates 4K page tables. */
> +	/*
> +	 * The following bitfields need a down_write on the mm
> +	 * semaphore when they are written to. As they are only
> +	 * written once, they can be read without a lock.
> +	 *
> +	 * The mmu context allocates 4K page tables.
> +	 */
>  	unsigned int alloc_pgste:1;
>  	/* The mmu context uses extended page tables. */
>  	unsigned int has_pgste:1;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8c039e12cb24..ac5da6b0b862 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -695,7 +695,9 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>  			r = -EINVAL;
>  		else {
>  			r = 0;
> +			down_write(&kvm->mm->mmap_sem);
>  			kvm->mm->context.allow_gmap_hpage_1m = 1;
> +			up_write(&kvm->mm->mmap_sem);
>  			/*
>  			 * We might have to create fake 4k page
>  			 * tables. To avoid that the hardware works on
> 
