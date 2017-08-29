From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 06/11] KVM: s390: Multiple Epoch Facility support
Date: Tue, 29 Aug 2017 14:24:24 +0200
Message-ID: <705f3223-ed61-e9da-814c-238d21322f6b@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 28.08.2017 10:07, Christian Borntraeger wrote:
> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> Allow for the enablement of MEF and the support for the extended
> epoch in SIE and VSIE for the extended guest TOD-Clock.
> 
> A new interface is used for getting/setting a guest's extended
> TOD-Clock that uses a single ioctl invocation, KVM_S390_VM_TOD_EXT.
> The old method of getting and setting the guest TOD-Clock is
> retained and is used when the old ioctls are called.

After talking to Christian, I understand that we have to set it in "one
shot" as we can otherwise run into problems when getting/setting the TOD
as we are looking at a moving target. This should go into the cover letter.

I need some more info regarding the architecture change.

For now, epoch was an unsigned value that is interpreted as an signed value.

a) Is that still true with multiple epoch?
b) What is the format of the epoch index? Can it also be "negative"?

Why I am asking: I can see comparison made with the epoch:

> +	if (test_kvm_facility(vcpu->kvm, 139)) {
> +		scb_s->epdx += vcpu->kvm->arch.epdx;
> +		if (scb_s->epoch < vcpu->kvm->arch.epoch)
> +			scb_s->epdx += 1;
> +	}

or

> +	if (kvm->arch.epoch > gtod->tod)
> +		kvm->arch.epdx -= 1;


If I remember correctly, such comparisons won't work correctly when
having this signed/unsigned duality. But I might be wrong.


> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---

[...]
>  
>  /* implemented in kvm-s390.c */
> +void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
> +				 const struct kvm_s390_vm_tod_clock *gtod);
>  void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
>  long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
>  int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 715c19c..681d06e 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -349,6 +349,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		scb_s->eca |= scb_o->eca & ECA_IB;
>  	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_CEI))
>  		scb_s->eca |= scb_o->eca & ECA_CEI;
> +	/* Epoch Extension */
> +	if (test_kvm_facility(vcpu->kvm, 139))
> +		scb_s->ecd |= scb_o->ecd & ECD_MEF;
>  
>  	prepare_ibc(vcpu, vsie_page);
>  	rc = shadow_crycb(vcpu, vsie_page);
> @@ -919,6 +922,13 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
>  	 */
>  	preempt_disable();
>  	scb_s->epoch += vcpu->kvm->arch.epoch;
> +
> +	if (test_kvm_facility(vcpu->kvm, 139)) {

Although scb_s->epdx won't be interpreted without ECD_MEF, this should
be (so data is only copied if really enabled).

if (scb_s->ecd | ECD_MEF)

> +		scb_s->epdx += vcpu->kvm->arch.epdx;
> +		if (scb_s->epoch < vcpu->kvm->arch.epoch)
> +			scb_s->epdx += 1;
> +	}
> +
>  	preempt_enable();
>  }
>  
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 181db5b..601bfcf 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -81,6 +81,7 @@ static struct facility_def facility_defs[] = {
>  			130, /* instruction-execution-protection */
>  			131, /* enhanced-SOP 2 and side-effect */
>  			138, /* configuration z/architecture mode (czam) */
> +			139, /* multiple epoch facility */
>  			146, /* msa extension 8 */
>  			-1  /* END */
>  		}
> 


-- 

Thanks,

David
