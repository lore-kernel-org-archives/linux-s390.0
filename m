From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Feb 2018 19:06:51 +0000
Subject: Re: [PATCH RFC 2/6] KVM: s390: provide only a single function for setting the tod
Message-Id: <ffa20b69-9ab6-d9a7-972d-6865d6052170@de.ibm.com>
In-Reply-To: <b51c6b10-c0c0-2dae-3d74-7c21820d28ce@redhat.com>
References: <b51c6b10-c0c0-2dae-3d74-7c21820d28ce@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/07/2018 12:46 PM, David Hildenbrand wrote:
> Right now, SET CLOCK called in the guest does not properly take care of
> the epoch index, as the call goes via the old kvm_s390_set_tod_clock()
> interface. So the epoch index is neither reset to 0, if required, nor
> properly set to e.g. 0xff on negative values.
> 
> Fix this by providing a single kvm_s390_set_tod_clock() function. Move
> Multiple-epoch facility handling into it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 46 +++++++++++++++-------------------------------
>  arch/s390/kvm/kvm-s390.h |  5 ++---
>  arch/s390/kvm/priv.c     |  9 +++++----
>  3 files changed, 22 insertions(+), 38 deletions(-)

The diffstat and the simplification makes this patch worthwile alone and I think you are
right. We need to fix sck as well.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

applied thanks.

> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ba4c7092335a..b514ee427077 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -902,12 +902,9 @@ static int kvm_s390_set_tod_ext(struct kvm *kvm, struct kvm_device_attr *attr)
>  	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
>  		return -EFAULT;
> 
> -	if (test_kvm_facility(kvm, 139))
> -		kvm_s390_set_tod_clock_ext(kvm, &gtod);
> -	else if (gtod.epoch_idx == 0)
> -		kvm_s390_set_tod_clock(kvm, gtod.tod);
> -	else
> +	if (!test_kvm_facility(kvm, 139) && gtod.epoch_idx)
>  		return -EINVAL;
> +	kvm_s390_set_tod_clock(kvm, &gtod);
> 
>  	VM_EVENT(kvm, 3, "SET: TOD extension: 0x%x, TOD base: 0x%llx",
>  		gtod.epoch_idx, gtod.tod);
> @@ -932,13 +929,14 @@ static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
> 
>  static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
>  {
> -	u64 gtod;
> +	struct kvm_s390_vm_tod_clock gtod = { 0 };
> 
> -	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
> +	if (copy_from_user(&gtod.tod, (void __user *)attr->addr,
> +			   sizeof(gtod.tod)))
>  		return -EFAULT;
> 
> -	kvm_s390_set_tod_clock(kvm, gtod);
> -	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx", gtod);
> +	kvm_s390_set_tod_clock(kvm, &gtod);
> +	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx", gtod.tod);
>  	return 0;
>  }
> 
> @@ -3021,8 +3019,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
> 
> -void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
> -				 const struct kvm_s390_vm_tod_clock *gtod)
> +void kvm_s390_set_tod_clock(struct kvm *kvm,
> +			    const struct kvm_s390_vm_tod_clock *gtod)
>  {
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_s390_tod_clock_ext htod;
> @@ -3034,10 +3032,12 @@ void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
>  	get_tod_clock_ext((char *)&htod);
> 
>  	kvm->arch.epoch = gtod->tod - htod.tod;
> -	kvm->arch.epdx = gtod->epoch_idx - htod.epoch_idx;
> -
> -	if (kvm->arch.epoch > gtod->tod)
> -		kvm->arch.epdx -= 1;
> +	kvm->arch.epdx = 0;
> +	if (test_kvm_facility(kvm, 139)) {
> +		kvm->arch.epdx = gtod->epoch_idx - htod.epoch_idx;
> +		if (kvm->arch.epoch > gtod->tod)
> +			kvm->arch.epdx -= 1;
> +	}
> 
>  	kvm_s390_vcpu_block_all(kvm);
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
> @@ -3050,22 +3050,6 @@ void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
>  	mutex_unlock(&kvm->lock);
>  }
> 
> -void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod)
> -{
> -	struct kvm_vcpu *vcpu;
> -	int i;
> -
> -	mutex_lock(&kvm->lock);
> -	preempt_disable();
> -	kvm->arch.epoch = tod - get_tod_clock();
> -	kvm_s390_vcpu_block_all(kvm);
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		vcpu->arch.sie_block->epoch = kvm->arch.epoch;
> -	kvm_s390_vcpu_unblock_all(kvm);
> -	preempt_enable();
> -	mutex_unlock(&kvm->lock);
> -}
> -
>  /**
>   * kvm_arch_fault_in_page - fault-in guest page if necessary
>   * @vcpu: The corresponding virtual cpu
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index bd31b37b0e6f..19d719262765 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -283,9 +283,8 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
>  int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
> 
>  /* implemented in kvm-s390.c */
> -void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
> -				 const struct kvm_s390_vm_tod_clock *gtod);
> -void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
> +void kvm_s390_set_tod_clock(struct kvm *kvm,
> +			    const struct kvm_s390_vm_tod_clock *gtod);
>  long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
>  int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
>  int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index c4c4e157c036..33505c32c48a 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -85,9 +85,10 @@ int kvm_s390_handle_e3(struct kvm_vcpu *vcpu)
>  /* Handle SCK (SET CLOCK) interception */
>  static int handle_set_clock(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_s390_vm_tod_clock gtod = { 0 };
>  	int rc;
>  	u8 ar;
> -	u64 op2, val;
> +	u64 op2;
> 
>  	vcpu->stat.instruction_sck++;
> 
> @@ -97,12 +98,12 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
>  	op2 = kvm_s390_get_base_disp_s(vcpu, &ar);
>  	if (op2 & 7)	/* Operand must be on a doubleword boundary */
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> -	rc = read_guest(vcpu, op2, ar, &val, sizeof(val));
> +	rc = read_guest(vcpu, op2, ar, &gtod.tod, sizeof(gtod.tod));
>  	if (rc)
>  		return kvm_s390_inject_prog_cond(vcpu, rc);
> 
> -	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", val);
> -	kvm_s390_set_tod_clock(vcpu->kvm, val);
> +	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", gtod.tod);
> +	kvm_s390_set_tod_clock(vcpu->kvm, &gtod);
> 
>  	kvm_s390_set_psw_cc(vcpu, 0);
>  	return 0;
> 
