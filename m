From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] KVM: Clean up vm creation and release
Date: Tue, 9 Nov 2010 22:01:48 +0100
Message-ID: <14BEF7DF-2C0A-4040-BC40-E5F5D08FC90D@suse.de>
References: <4CD970A9.6080802@siemens.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4CD970A9.6080802@siemens.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>, "kvm-ia64@vger.kernel.org" <kvm-ia64@vger.kernel.org>, "Zhang, Xiantao" <xiantao.zhang@intel.com>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 09.11.2010, at 17:02, Jan Kiszka wrote:

> IA64 support forces us to abstract the allocation of the kvm structure.
> But instead of mixing this up with arch-specific initialization and
> doing the same on destruction, split both steps. This allows to move
> generic destruction calls into generic code.
> 
> It also fixes error clean-up on failures of kvm_create_vm for IA64.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
> - Fixed s390 conversion and added linux/slab.h
>   as remarked by Christian (thanks!)
> 
> arch/ia64/include/asm/kvm_host.h |    4 ++++
> arch/ia64/kvm/kvm-ia64.c         |   28 +++++++---------------------
> arch/powerpc/kvm/powerpc.c       |   20 +++-----------------
> arch/s390/kvm/kvm-s390.c         |   23 ++++++-----------------
> arch/x86/kvm/x86.c               |   12 ++----------
> include/linux/kvm_host.h         |   15 ++++++++++++++-
> virt/kvm/kvm_main.c              |   19 +++++++++++++------
> 7 files changed, 49 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/kvm_host.h b/arch/ia64/include/asm/kvm_host.h
> index 2f229e5..2689ee5 100644
> --- a/arch/ia64/include/asm/kvm_host.h
> +++ b/arch/ia64/include/asm/kvm_host.h
> @@ -590,6 +590,10 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu);
> int kvm_pal_emul(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run);
> void kvm_sal_emul(struct kvm_vcpu *vcpu);
> 
> +#define __KVM_HAVE_ARCH_VM_ALLOC 1
> +struct kvm *kvm_arch_alloc_vm(void);
> +void kvm_arch_free_vm(struct kvm *kvm);
> +
> #endif /* __ASSEMBLY__*/
> 
> #endif
> diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
> index f56a631..48a48bd 100644
> --- a/arch/ia64/kvm/kvm-ia64.c
> +++ b/arch/ia64/kvm/kvm-ia64.c
> @@ -749,7 +749,7 @@ out:
> 	return r;
> }
> 
> -static struct kvm *kvm_alloc_kvm(void)
> +struct kvm *kvm_arch_alloc_vm(void)
> {
> 
> 	struct kvm *kvm;
> @@ -760,7 +760,7 @@ static struct kvm *kvm_alloc_kvm(void)
> 	vm_base = __get_free_pages(GFP_KERNEL, get_order(KVM_VM_DATA_SIZE));
> 
> 	if (!vm_base)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
> 
> 	memset((void *)vm_base, 0, KVM_VM_DATA_SIZE);
> 	kvm = (struct kvm *)(vm_base +
> @@ -806,10 +806,12 @@ static void kvm_build_io_pmt(struct kvm *kvm)
> #define GUEST_PHYSICAL_RR4	0x2739
> #define VMM_INIT_RR		0x1660
> 
> -static void kvm_init_vm(struct kvm *kvm)
> +int kvm_arch_init_vm(struct kvm *kvm)
> {
> 	BUG_ON(!kvm);
> 
> +	kvm->arch.is_sn2 = ia64_platform_is("sn2");
> +
> 	kvm->arch.metaphysical_rr0 = GUEST_PHYSICAL_RR0;
> 	kvm->arch.metaphysical_rr4 = GUEST_PHYSICAL_RR4;
> 	kvm->arch.vmm_init_rr = VMM_INIT_RR;
> @@ -823,21 +825,8 @@ static void kvm_init_vm(struct kvm *kvm)
> 
> 	/* Reserve bit 0 of irq_sources_bitmap for userspace irq source */
> 	set_bit(KVM_USERSPACE_IRQ_SOURCE_ID, &kvm->arch.irq_sources_bitmap);
> -}
> -
> -struct  kvm *kvm_arch_create_vm(void)
> -{
> -	struct kvm *kvm = kvm_alloc_kvm();
> -
> -	if (IS_ERR(kvm))
> -		return ERR_PTR(-ENOMEM);
> -
> -	kvm->arch.is_sn2 = ia64_platform_is("sn2");
> -
> -	kvm_init_vm(kvm);
> -
> -	return kvm;
> 
> +	return 0;
> }
> 
> static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm,
> @@ -1357,7 +1346,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> 	return -EINVAL;
> }
> 
> -static void free_kvm(struct kvm *kvm)
> +void kvm_arch_free_vm(struct kvm *kvm)
> {
> 	unsigned long vm_base = kvm->arch.vm_base;
> 
> @@ -1399,9 +1388,6 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
> #endif
> 	kfree(kvm->arch.vioapic);
> 	kvm_release_vm_pages(kvm);
> -	kvm_free_physmem(kvm);
> -	cleanup_srcu_struct(&kvm->srcu);
> -	free_kvm(kvm);
> }
> 
> void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 38f756f..ce3dd65 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -145,18 +145,12 @@ void kvm_arch_check_processor_compat(void *rtn)
> 	*(int *)rtn = kvmppc_core_check_processor_compat();
> }
> 
> -struct kvm *kvm_arch_create_vm(void)
> +int kvm_arch_init_vm(struct kvm *)

Eh, no. This doesn't compile :).

Apart from that, the code seems to work on ppc64.


Tested-by: Alexander Graf <agraf@suse.de>

Alex
