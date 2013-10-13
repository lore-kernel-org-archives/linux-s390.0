From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [Patchv5 6/7] KVM: async_pf:  Async page fault support on s390
Date: Sun, 13 Oct 2013 12:15:26 +0300
Message-ID: <20131013091526.GD15657@redhat.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
 <1381244100-59056-7-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381244100-59056-7-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 08, 2013 at 04:54:59PM +0200, Christian Borntraeger wrote:
> From: Dominik Dingel <dingel@linux.vnet.ibm.com>
> 
> This patch enables async page faults for s390 kvm guests.
> It provides the userspace API to enable, disable and disable_wait this feature.
> By providing disable and disable_wait, the userspace can first asynchronly disable
> the feature, then continue the live migration and later on enforce that the feature
> is off by waiting on it.
> Also it includes the diagnose code, called by the guest to enable async page faults.
> 
> The async page faults will use an already existing guest interface for this
> purpose, as described in "CP Programming Services (SC24-6084)".
> 
> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 22 +++++++++++
>  arch/s390/include/uapi/asm/kvm.h |  9 +++--
>  arch/s390/kvm/Kconfig            |  2 +
>  arch/s390/kvm/Makefile           |  2 +-
>  arch/s390/kvm/diag.c             | 84 +++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++++++++++++++----
>  arch/s390/kvm/kvm-s390.c         | 85 +++++++++++++++++++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h         |  4 ++
>  arch/s390/kvm/sigp.c             |  7 ++++
>  arch/s390/kvm/trace.h            | 46 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h         |  2 +
>  11 files changed, 318 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 2d09c1d..151ea01 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -224,6 +224,10 @@ struct kvm_vcpu_arch {
>  		u64		stidp_data;
>  	};
>  	struct gmap *gmap;
> +#define KVM_S390_PFAULT_TOKEN_INVALID	(-1UL)
> +	unsigned long pfault_token;
> +	unsigned long pfault_select;
> +	unsigned long pfault_compare;
>  };
>  
>  struct kvm_vm_stat {
> @@ -250,6 +254,24 @@ static inline bool kvm_is_error_hva(unsigned long addr)
>  	return IS_ERR_VALUE(addr);
>  }
>  
> +#define ASYNC_PF_PER_VCPU	64
> +struct kvm_vcpu;
> +struct kvm_async_pf;
> +struct kvm_arch_async_pf {
> +	unsigned long pfault_token;
> +};
> +
> +bool kvm_arch_can_inject_async_page_present(struct kvm_vcpu *vcpu);
> +
> +void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
> +			       struct kvm_async_pf *work);
> +
> +void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
> +				     struct kvm_async_pf *work);
> +
> +void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
> +				 struct kvm_async_pf *work);
> +
>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>  extern char sie_exit;
>  #endif
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 33d52b8..1e8fced 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -17,9 +17,12 @@
>  #define __KVM_S390
>  
>  /* Device control API: s390-specific devices */
> -#define KVM_DEV_FLIC_DEQUEUE 1
> -#define KVM_DEV_FLIC_ENQUEUE 2
> -#define KVM_DEV_FLIC_CLEAR_IRQS 3
> +#define KVM_DEV_FLIC_DEQUEUE		1
> +#define KVM_DEV_FLIC_ENQUEUE		2
> +#define KVM_DEV_FLIC_CLEAR_IRQS		3
> +#define KVM_DEV_FLIC_APF_ENABLE		4
> +#define KVM_DEV_FLIC_APF_DISABLE	5
> +#define KVM_DEV_FLIC_APF_DISABLE_WAIT	6
>  
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 70b46ea..c8bacbc 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -23,6 +23,8 @@ config KVM
>  	select ANON_INODES
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select HAVE_KVM_EVENTFD
> +	select KVM_ASYNC_PF
> +	select KVM_ASYNC_PF_SYNC
>  	---help---
>  	  Support hosting paravirtualized guest machines using the SIE
>  	  virtualization capability on the mainframe. This should work
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 40b4c64..a47d2c3 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -7,7 +7,7 @@
>  # as published by the Free Software Foundation.
>  
>  KVM := ../../../virt/kvm
> -common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o
> +common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o
>  
>  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>  
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 78d967f..e50aadf 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -17,6 +17,7 @@
>  #include "kvm-s390.h"
>  #include "trace.h"
>  #include "trace-s390.h"
> +#include "gaccess.h"
>  
>  static int diag_release_pages(struct kvm_vcpu *vcpu)
>  {
> @@ -46,6 +47,87 @@ static int diag_release_pages(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
> +{
> +	struct prs_parm {
> +		u16 code;
> +		u16 subcode;
> +		u16 parm_len;
> +		u16 parm_version;
> +		u64 token_addr;
> +		u64 select_mask;
> +		u64 compare_mask;
> +		u64 zarch;
> +	};
> +	struct prs_parm parm;
> +	int rc;
> +	u16 rx = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
> +	u16 ry = (vcpu->arch.sie_block->ipa & 0x0f);
> +	unsigned long hva_token = KVM_HVA_ERR_BAD;
> +
> +	if (vcpu->run->s.regs.gprs[rx] & 7)
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	if (copy_from_guest(vcpu, &parm, vcpu->run->s.regs.gprs[rx], sizeof(parm)))
> +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +
> +	switch (parm.subcode) {
> +	case 0: /* TOKEN */
> +		if (vcpu->arch.pfault_token != KVM_S390_PFAULT_TOKEN_INVALID) {
> +			/*
> +			 * pagefault handshake already done, token will not be
> +			 * changed setting return value to 8
> +			 */
> +			vcpu->run->s.regs.gprs[ry] = 8;
> +			return 0;
> +		}
> +
> +		if ((parm.compare_mask & parm.select_mask) != parm.compare_mask ||
> +		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
> +			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +
> +		hva_token = gfn_to_hva(vcpu->kvm, gpa_to_gfn(parm.token_addr));
> +		if (kvm_is_error_hva(hva_token))
> +			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +
> +		vcpu->arch.pfault_token = parm.token_addr;
> +		vcpu->arch.pfault_select = parm.select_mask;
> +		vcpu->arch.pfault_compare = parm.compare_mask;
> +		vcpu->run->s.regs.gprs[ry] = 0;
> +		rc = 0;
> +		break;
> +	case 1: /*
> +		 * CANCEL
> +		 * Specification allows to let already pending tokens survive
> +		 * the cancel, therefore to reduce code complexity, we assume, all
> +		 * outstanding tokens are already pending.
> +		 */
> +		if (parm.token_addr || parm.select_mask || parm.compare_mask ||
> +		    parm.zarch)
> +			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +
> +		vcpu->run->s.regs.gprs[ry] = 0;
> +		/*
> +		 * in the case the pfault handling was not established or
> +		 * already canceled we will set represent the right return
> +		 * value to the guest
> +		 */
> +		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
> +			vcpu->run->s.regs.gprs[ry] = 4;
> +		else
> +			vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
> +
> +		rc = 0;
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
>  static int __diag_time_slice_end(struct kvm_vcpu *vcpu)
>  {
>  	VCPU_EVENT(vcpu, 5, "%s", "diag time slice end");
> @@ -150,6 +232,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>  		return __diag_time_slice_end(vcpu);
>  	case 0x9c:
>  		return __diag_time_slice_end_directed(vcpu);
> +	case 0x258:
> +		return __diag_page_ref_service(vcpu);
>  	case 0x308:
>  		return __diag_ipl_functions(vcpu);
>  	case 0x500:
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 66478a0..18e39d4 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -31,7 +31,7 @@ static int is_ioint(u64 type)
>  	return ((type & 0xfffe0000u) != 0xfffe0000u);
>  }
>  
> -static int psw_extint_disabled(struct kvm_vcpu *vcpu)
> +int psw_extint_disabled(struct kvm_vcpu *vcpu)
>  {
>  	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT);
>  }
> @@ -78,11 +78,8 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
>  			return 1;
>  		return 0;
>  	case KVM_S390_INT_SERVICE:
> -		if (psw_extint_disabled(vcpu))
> -			return 0;
> -		if (vcpu->arch.sie_block->gcr[0] & 0x200ul)
> -			return 1;
> -		return 0;
> +	case KVM_S390_INT_PFAULT_INIT:
> +	case KVM_S390_INT_PFAULT_DONE:
>  	case KVM_S390_INT_VIRTIO:
>  		if (psw_extint_disabled(vcpu))
>  			return 0;
> @@ -150,6 +147,8 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
>  	case KVM_S390_INT_EXTERNAL_CALL:
>  	case KVM_S390_INT_EMERGENCY:
>  	case KVM_S390_INT_SERVICE:
> +	case KVM_S390_INT_PFAULT_INIT:
> +	case KVM_S390_INT_PFAULT_DONE:
>  	case KVM_S390_INT_VIRTIO:
>  		if (psw_extint_disabled(vcpu))
>  			__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
> @@ -223,6 +222,30 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
>  		rc |= put_guest(vcpu, inti->ext.ext_params,
>  				(u32 __user *)__LC_EXT_PARAMS);
>  		break;
> +	case KVM_S390_INT_PFAULT_INIT:
> +		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
> +						 inti->ext.ext_params2);
> +		rc  = put_guest(vcpu, 0x2603, (u16 __user *) __LC_EXT_INT_CODE);
> +		rc |= put_guest(vcpu, 0x0600, (u16 __user *) __LC_EXT_CPU_ADDR);
> +		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
> +				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
> +				      __LC_EXT_NEW_PSW, sizeof(psw_t));
> +		rc |= put_guest(vcpu, inti->ext.ext_params2,
> +				(u64 __user *) __LC_EXT_PARAMS2);
> +		break;
> +	case KVM_S390_INT_PFAULT_DONE:
> +		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
> +						 inti->ext.ext_params2);
> +		rc  = put_guest(vcpu, 0x2603, (u16 __user *) __LC_EXT_INT_CODE);
> +		rc |= put_guest(vcpu, 0x0680, (u16 __user *) __LC_EXT_CPU_ADDR);
> +		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
> +				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
> +				      __LC_EXT_NEW_PSW, sizeof(psw_t));
> +		rc |= put_guest(vcpu, inti->ext.ext_params2,
> +				(u64 __user *) __LC_EXT_PARAMS2);
> +		break;
>  	case KVM_S390_INT_VIRTIO:
>  		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
>  			   inti->ext.ext_params, inti->ext.ext_params2);
> @@ -357,7 +380,7 @@ static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> -static int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
> +int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>  	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
> @@ -724,6 +747,10 @@ int kvm_s390_inject_vm(struct kvm *kvm,
>  		VM_EVENT(kvm, 5, "inject: sclp parm:%x", s390int->parm);
>  		inti->ext.ext_params = s390int->parm;
>  		break;
> +	case KVM_S390_INT_PFAULT_DONE:
> +		inti->type = s390int->type;
> +		inti->ext.ext_params2 = s390int->parm64;
> +		break;
>  	case KVM_S390_MCHK:
>  		VM_EVENT(kvm, 5, "inject: machine check parm64:%llx",
>  			 s390int->parm64);
> @@ -811,6 +838,10 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
>  		inti->type = s390int->type;
>  		inti->mchk.mcic = s390int->parm64;
>  		break;
> +	case KVM_S390_INT_PFAULT_INIT:
> +		inti->type = s390int->type;
> +		inti->ext.ext_params2 = s390int->parm64;
> +		break;
>  	case KVM_S390_INT_VIRTIO:
>  	case KVM_S390_INT_SERVICE:
>  	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> @@ -866,6 +897,8 @@ static inline int copy_irq_to_user(struct kvm_s390_interrupt_info *inti,
>  	int r = 0;
>  
>  	switch (inti->type) {
> +	case KVM_S390_INT_PFAULT_INIT:
> +	case KVM_S390_INT_PFAULT_DONE:
>  	case KVM_S390_INT_VIRTIO:
>  	case KVM_S390_INT_SERVICE:
>  		source = &inti->ext;
> @@ -946,6 +979,8 @@ static inline int copy_irq_from_user(struct kvm_s390_interrupt_info *inti,
>  	if (get_user(inti->type, (u64 __user *)addr))
>  		return -EFAULT;
>  	switch (inti->type) {
> +	case KVM_S390_INT_PFAULT_INIT:
> +	case KVM_S390_INT_PFAULT_DONE:
>  	case KVM_S390_INT_VIRTIO:
>  	case KVM_S390_INT_SERVICE:
>  		target = (void *) &inti->ext;
> @@ -996,6 +1031,8 @@ static int enqueue_floating_irq(struct kvm_device *dev,
>  static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>  {
>  	int r = 0;
> +	unsigned int i;
> +	struct kvm_vcpu *vcpu;
>  
>  	switch (attr->group) {
>  	case KVM_DEV_FLIC_ENQUEUE:
> @@ -1005,6 +1042,23 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>  		r = 0;
>  		clear_floating_interrupts(dev->kvm);
>  		break;
> +	case KVM_DEV_FLIC_APF_ENABLE:
> +		dev->kvm->arch.gmap->pfault_enabled = 1;
> +		break;
> +	case KVM_DEV_FLIC_APF_DISABLE:
> +		dev->kvm->arch.gmap->pfault_enabled = 0;
> +		break;
> +	case KVM_DEV_FLIC_APF_DISABLE_WAIT:
> +		dev->kvm->arch.gmap->pfault_enabled = 0;
> +		/*
> +		 * Make sure no async faults are in transition when
> +		 * clearing the queues. So we don't need to worry
> +		 * about late coming workers.
> +		 */
> +		synchronize_srcu(&dev->kvm->srcu);
> +		kvm_for_each_vcpu(i, vcpu, dev->kvm)
> +			kvm_clear_async_pf_completion_queue(vcpu, true);
> +		break;
>  	default:
>  		r = -EINVAL;
>  	}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 785e36e..c4f92f6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -152,6 +152,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  #ifdef CONFIG_KVM_S390_UCONTROL
>  	case KVM_CAP_S390_UCONTROL:
>  #endif
> +	case KVM_CAP_ASYNC_PF:
>  	case KVM_CAP_SYNC_REGS:
>  	case KVM_CAP_ONE_REG:
>  	case KVM_CAP_ENABLE_CAP:
> @@ -273,6 +274,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
>  	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
>  	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
> +	kvm_clear_async_pf_completion_queue(vcpu, false);
>  	if (!kvm_is_ucontrol(vcpu->kvm)) {
>  		clear_bit(63 - vcpu->vcpu_id,
>  			  (unsigned long *) &vcpu->kvm->arch.sca->mcn);
> @@ -322,6 +324,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  /* Section: vcpu related */
>  int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  {
> +	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
> +	kvm_clear_async_pf_completion_queue(vcpu, false);
>  	if (kvm_is_ucontrol(vcpu->kvm)) {
>  		vcpu->arch.gmap = gmap_alloc(current->mm);
>  		if (!vcpu->arch.gmap)
> @@ -379,6 +383,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  	vcpu->arch.guest_fpregs.fpc = 0;
>  	asm volatile("lfpc %0" : : "Q" (vcpu->arch.guest_fpregs.fpc));
>  	vcpu->arch.sie_block->gbea = 1;
> +	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>  	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
>  }
>  
> @@ -702,10 +707,84 @@ static long kvm_arch_fault_in_sync(struct kvm_vcpu *vcpu)
>  	return rc;
>  }
>  
> +static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> +				      unsigned long token)
> +{
> +	struct kvm_s390_interrupt inti;
> +	inti.parm64 = token;
> +
> +	if (start_token) {
> +		inti.type = KVM_S390_INT_PFAULT_INIT;
> +		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &inti));
> +	} else {
> +		inti.type = KVM_S390_INT_PFAULT_DONE;
> +		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
> +	}
> +}
> +
> +void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
> +				     struct kvm_async_pf *work)
> +{
> +	trace_kvm_s390_pfault_init(vcpu, work->arch.pfault_token);
> +	__kvm_inject_pfault_token(vcpu, true, work->arch.pfault_token);
> +}
> +
> +void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
> +				 struct kvm_async_pf *work)
> +{
> +	trace_kvm_s390_pfault_done(vcpu, work->arch.pfault_token);
> +	__kvm_inject_pfault_token(vcpu, false, work->arch.pfault_token);
> +}
> +
> +void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
> +			       struct kvm_async_pf *work)
> +{
> +	/* s390 will always inject the page directly */
> +}
> +
> +bool kvm_arch_can_inject_async_page_present(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * s390 will always inject the page directly,
> +	 * but we still want check_async_completion to cleanup
> +	 */
> +	return true;
> +}
> +
> +static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
> +{
> +	hva_t hva;
> +	struct kvm_arch_async_pf arch;
> +	int rc;
> +
> +	if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
> +		return 0;
> +	if ((vcpu->arch.sie_block->gpsw.mask & vcpu->arch.pfault_select) !=
> +	    vcpu->arch.pfault_compare)
> +		return 0;
> +	if (psw_extint_disabled(vcpu))
> +		return 0;
> +	if (kvm_cpu_has_interrupt(vcpu))
> +		return 0;
> +	if (!(vcpu->arch.sie_block->gcr[0] & 0x200ul))
> +		return 0;
> +	if (!vcpu->arch.gmap->pfault_enabled)
> +		return 0;
> +
> +	hva = gmap_fault(current->thread.gmap_addr, vcpu->arch.gmap);
> +	if (copy_from_guest(vcpu, &arch.pfault_token, vcpu->arch.pfault_token, 8))
> +		return 0;
> +
> +	rc = kvm_setup_async_pf(vcpu, current->thread.gmap_addr, hva, &arch);
> +	return rc;
> +}
> +
>  static int vcpu_pre_run(struct kvm_vcpu *vcpu)
>  {
>  	int rc, cpuflags;
>  
> +	kvm_check_async_pf_completion(vcpu);
> +
We need this here just to put_page() that was GUPed in
async_pf_execute(). There is a patch[1] that makes this GUP to not
take a reference to a page. This will simplify s390 implementation I
think. For s390 there will be no need to put async_pf work into 
vcpu->async_pf.done and this call will not be needed either.

[1] https://lkml.org/lkml/2013/10/10/282
>  	memcpy(&vcpu->arch.sie_block->gg14, &vcpu->run->s.regs.gprs[14], 16);
>  
>  	if (need_resched())
> @@ -743,9 +822,11 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>  		if (kvm_is_ucontrol(vcpu->kvm)) {
>  			rc = SIE_INTERCEPT_UCONTROL;
>  		} else if (current->thread.gmap_pfault) {
> +			trace_kvm_s390_major_guest_pfault(vcpu);
>  			current->thread.gmap_pfault = 0;
> -			if (kvm_arch_fault_in_sync(vcpu) >= 0)
> -				rc = 0;
> +			if (kvm_arch_setup_async_pf(vcpu) ||
> +			    (kvm_arch_fault_in_sync(vcpu) >= 0))
> +					rc = 0;
>  		}
>  	}
>  
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index b44912a..c2bf916 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -159,4 +159,8 @@ void exit_sie_sync(struct kvm_vcpu *vcpu);
>  /* implemented in diag.c */
>  int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
>  
> +/* implemented in interrupt.c */
> +int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
> +int psw_extint_disabled(struct kvm_vcpu *vcpu);
> +
>  #endif
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index bec398c..8fcc5c6 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -186,6 +186,13 @@ int kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action)
>  static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
>  {
>  	int rc;
> +	unsigned int i;
> +	struct kvm_vcpu *vcpu_to_set;
> +
> +	kvm_for_each_vcpu(i, vcpu_to_set, vcpu->kvm) {
> +		vcpu_to_set->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
> +		kvm_clear_async_pf_completion_queue(vcpu, false);
> +	}
>  
>  	switch (parameter & 0xff) {
>  	case 0:
> diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
> index c2f582bb1c..e4816a5 100644
> --- a/arch/s390/kvm/trace.h
> +++ b/arch/s390/kvm/trace.h
> @@ -29,6 +29,52 @@
>  	TP_printk("%02d[%016lx-%016lx]: " p_str, __entry->id,		\
>  		  __entry->pswmask, __entry->pswaddr, p_args)
>  
> +TRACE_EVENT(kvm_s390_major_guest_pfault,
> +	    TP_PROTO(VCPU_PROTO_COMMON),
> +	    TP_ARGS(VCPU_ARGS_COMMON),
> +
> +	    TP_STRUCT__entry(
> +		    VCPU_FIELD_COMMON
> +		    ),
> +
> +	    TP_fast_assign(
> +		    VCPU_ASSIGN_COMMON
> +		    ),
> +	    VCPU_TP_PRINTK("%s", "major fault, maybe applicable for pfault")
> +	);
> +
> +TRACE_EVENT(kvm_s390_pfault_init,
> +	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
> +	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
> +
> +	    TP_STRUCT__entry(
> +		    VCPU_FIELD_COMMON
> +		    __field(long, pfault_token)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    VCPU_ASSIGN_COMMON
> +		    __entry->pfault_token = pfault_token;
> +		    ),
> +	    VCPU_TP_PRINTK("init pfault token %ld", __entry->pfault_token)
> +	);
> +
> +TRACE_EVENT(kvm_s390_pfault_done,
> +	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
> +	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
> +
> +	    TP_STRUCT__entry(
> +		    VCPU_FIELD_COMMON
> +		    __field(long, pfault_token)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    VCPU_ASSIGN_COMMON
> +		    __entry->pfault_token = pfault_token;
> +		    ),
> +	    VCPU_TP_PRINTK("done pfault token %ld", __entry->pfault_token)
> +	);
> +
>  /*
>   * Tracepoints for SIE entry and exit.
>   */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index fa59f1a..5c7cfc0 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -413,6 +413,8 @@ struct kvm_s390_psw {
>  #define KVM_S390_PROGRAM_INT		0xfffe0001u
>  #define KVM_S390_SIGP_SET_PREFIX	0xfffe0002u
>  #define KVM_S390_RESTART		0xfffe0003u
> +#define KVM_S390_INT_PFAULT_INIT	0xfffe0004u
> +#define KVM_S390_INT_PFAULT_DONE	0xfffe0005u
>  #define KVM_S390_MCHK			0xfffe1000u
>  #define KVM_S390_INT_VIRTIO		0xffff2603u
>  #define KVM_S390_INT_SERVICE		0xffff2401u
> -- 
> 1.8.3.1

--
			Gleb.
