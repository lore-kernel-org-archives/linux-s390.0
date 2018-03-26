From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 26 Mar 2018 08:15:14 +0000
Subject: Re: [PATCH v2] KVM: s390: Add storage key facility interpretation control
Message-Id: <2741993a-6ee4-af1b-99db-7abbf5e229fc@de.ibm.com>
In-Reply-To: <8e02be86-4a03-14f4-11a3-636ac7ce7dfb@redhat.com>
References: <8e02be86-4a03-14f4-11a3-636ac7ce7dfb@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03/20/2018 12:29 PM, Janosch Frank wrote:
> Up to now we always expected to have the storage key facility
> available for our (non-VSIE) KVM guests. For huge page support, we
> need to be able to disable it, so let's introduce that now.


Can you add some text that tells that you have renames use_skey (and why)

with that

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

(please queue yorself :-) )

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h    |  1 +
>  arch/s390/include/asm/mmu.h         |  2 +-
>  arch/s390/include/asm/mmu_context.h |  2 +-
>  arch/s390/include/asm/pgtable.h     |  4 ++--
>  arch/s390/kvm/kvm-s390.c            |  3 ++-
>  arch/s390/kvm/priv.c                | 28 ++++++++++++++++------------
>  arch/s390/mm/gmap.c                 |  6 +++---
>  arch/s390/mm/pgtable.c              |  4 ++--
>  8 files changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 27918b1..f161ad0 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -793,6 +793,7 @@ struct kvm_arch{
>  	int use_irqchip;
>  	int use_cmma;
>  	int use_pfmfi;
> +	int use_skf;
>  	int user_cpu_state_ctrl;
>  	int user_sigp;
>  	int user_stsi;
> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
> index c639c95..f5ff9db 100644
> --- a/arch/s390/include/asm/mmu.h
> +++ b/arch/s390/include/asm/mmu.h
> @@ -21,7 +21,7 @@ typedef struct {
>  	/* The mmu context uses extended page tables. */
>  	unsigned int has_pgste:1;
>  	/* The mmu context uses storage keys. */
> -	unsigned int use_skey:1;
> +	unsigned int uses_skeys:1;
>  	/* The mmu context uses CMM. */
>  	unsigned int uses_cmm:1;
>  } mm_context_t;
> diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
> index 324f6f4..d16bc79 100644
> --- a/arch/s390/include/asm/mmu_context.h
> +++ b/arch/s390/include/asm/mmu_context.h
> @@ -30,7 +30,7 @@ static inline int init_new_context(struct task_struct *tsk,
>  		test_thread_flag(TIF_PGSTE) ||
>  		(current->mm && current->mm->context.alloc_pgste);
>  	mm->context.has_pgste = 0;
> -	mm->context.use_skey = 0;
> +	mm->context.uses_skeys = 0;
>  	mm->context.uses_cmm = 0;
>  #endif
>  	switch (mm->context.asce_limit) {
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 9223b4d..4f26425 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -509,10 +509,10 @@ static inline int mm_alloc_pgste(struct mm_struct *mm)
>   * faults should no longer be backed by zero pages
>   */
>  #define mm_forbids_zeropage mm_has_pgste
> -static inline int mm_use_skey(struct mm_struct *mm)
> +static inline int mm_uses_skeys(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_PGSTE
> -	if (mm->context.use_skey)
> +	if (mm->context.uses_skeys)
>  		return 1;
>  #endif
>  	return 0;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 959ffe6..2b1ee8b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1457,7 +1457,7 @@ static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>  		return -EINVAL;
> 
>  	/* Is this guest using storage keys? */
> -	if (!mm_use_skey(current->mm))
> +	if (!mm_uses_skeys(current->mm))
>  		return KVM_S390_GET_SKEYS_NONE;
> 
>  	/* Enforce sane limit on memory allocation */
> @@ -2035,6 +2035,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.css_support = 0;
>  	kvm->arch.use_irqchip = 0;
>  	kvm->arch.use_pfmfi = sclp.has_pfmfi;
> +	kvm->arch.use_skf = sclp.has_skey;
>  	kvm->arch.epoch = 0;
> 
>  	spin_lock_init(&kvm->arch.start_stop_lock);
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index ebfa044..e8c6270 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -205,24 +205,28 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
> 
>  int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
>  {
> -	int rc = 0;
> +	int rc;
>  	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
> 
>  	trace_kvm_s390_skey_related_inst(vcpu);
> -	if (!(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
> +	/* Already enabled? */
> +	if (vcpu->kvm->arch.use_skf &&
> +	    !(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
>  	    !kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
> -		return rc;
> +		return 0;
> 
>  	rc = s390_enable_skey();
>  	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
> -	if (!rc) {
> -		if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
> -			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
> -		else
> -			sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE |
> -					     ICTL_RRBE);
> -	}
> -	return rc;
> +	if (rc)
> +		return rc;
> +
> +	if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
> +		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
> +	if (!vcpu->kvm->arch.use_skf)
> +		sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
> +	else
> +		sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
> +	return 0;
>  }
> 
>  static int try_handle_skey(struct kvm_vcpu *vcpu)
> @@ -232,7 +236,7 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
>  	rc = kvm_s390_skey_check_enable(vcpu);
>  	if (rc)
>  		return rc;
> -	if (sclp.has_skey) {
> +	if (vcpu->kvm->arch.use_skf) {
>  		/* with storage-key facility, SIE interprets it for us */
>  		kvm_s390_retry_instr(vcpu);
>  		VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index fa5246b..eca8fd9 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -3095,14 +3095,14 @@ int s390_enable_skey(void)
>  	int rc = 0;
> 
>  	down_write(&mm->mmap_sem);
> -	if (mm_use_skey(mm))
> +	if (mm_uses_skeys(mm))
>  		goto out_up;
> 
> -	mm->context.use_skey = 1;
> +	mm->context.uses_skeys = 1;
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>  		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>  				MADV_UNMERGEABLE, &vma->vm_flags)) {
> -			mm->context.use_skey = 0;
> +			mm->context.uses_skeys = 0;
>  			rc = -ENOMEM;
>  			goto out_up;
>  		}
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 871fc65..158c880 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -158,7 +158,7 @@ static inline pgste_t pgste_update_all(pte_t pte, pgste_t pgste,
>  #ifdef CONFIG_PGSTE
>  	unsigned long address, bits, skey;
> 
> -	if (!mm_use_skey(mm) || pte_val(pte) & _PAGE_INVALID)
> +	if (!mm_uses_skeys(mm) || pte_val(pte) & _PAGE_INVALID)
>  		return pgste;
>  	address = pte_val(pte) & PAGE_MASK;
>  	skey = (unsigned long) page_get_storage_key(address);
> @@ -180,7 +180,7 @@ static inline void pgste_set_key(pte_t *ptep, pgste_t pgste, pte_t entry,
>  	unsigned long address;
>  	unsigned long nkey;
> 
> -	if (!mm_use_skey(mm) || pte_val(entry) & _PAGE_INVALID)
> +	if (!mm_uses_skeys(mm) || pte_val(entry) & _PAGE_INVALID)
>  		return;
>  	VM_BUG_ON(!(pte_val(*ptep) & _PAGE_INVALID));
>  	address = pte_val(entry) & PAGE_MASK;
> 
