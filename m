From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 5/6] KVM: s390: wire up seb feature
Date: Wed, 17 Jan 2018 12:33:52 +0100
Message-ID: <2fa06836-75f8-9c3f-a5e3-217763f6ff4e@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>


>  #define ECB_GS		0x40
>  #define ECB_TE		0x10
>  #define ECB_SRSI	0x04
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 38535a57..20b9e9f 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -224,6 +224,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_RICCB  (1UL << 7)
>  #define KVM_SYNC_FPRS   (1UL << 8)
>  #define KVM_SYNC_GSCB   (1UL << 9)
> +#define KVM_SYNC_SEBC   (1UL << 10)
>  /* length and alignment of the sdnx as a power of two */
>  #define SDNXC 8
>  #define SDNXL (1UL << SDNXC)
> @@ -247,7 +248,8 @@ struct kvm_sync_regs {
>  	};
>  	__u8  reserved[512];	/* for future vector expansion */
>  	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
> -	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
> +	__u8 sebc:1;		/* spec blocking */

do you want to define the unused bits as reserved? Nicer to read IMHO

(especially also using spaces "sebc : 1")

> +	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
>  	__u8 riccb[64];		/* runtime instrumentation controls block */
>  	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
>  	union {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2c93cbb..0c18f73 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -421,6 +421,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_GS:
>  		r = test_facility(133);
>  		break;
> +	case KVM_CAP_S390_SEB:
> +		r = test_facility(82);
> +		break;
>  	default:
>  		r = 0;
>  	}
> @@ -2198,6 +2201,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  	kvm_s390_set_prefix(vcpu, 0);
>  	if (test_kvm_facility(vcpu->kvm, 64))
>  		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
> +	if (test_kvm_facility(vcpu->kvm, 82))
> +		vcpu->run->kvm_valid_regs |= KVM_SYNC_SEBC;
>  	if (test_kvm_facility(vcpu->kvm, 133))
>  		vcpu->run->kvm_valid_regs |= KVM_SYNC_GSCB;
>  	/* fprs can be synchronized via vrs, even if the guest has no vx. With
> @@ -2339,6 +2344,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  	current->thread.fpu.fpc = 0;
>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> +	vcpu->arch.sie_block->fpf &= ~FPF_SEBC;
>  	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>  	kvm_clear_async_pf_completion_queue(vcpu);
>  	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> @@ -3298,6 +3304,10 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
>  		vcpu->arch.gs_enabled = 1;
>  	}
> +	if (kvm_run->kvm_dirty_regs & KVM_SYNC_SEBC) {

We should test for test_facility(82). Otherwise user space can enable
undefined bits in the SCB on machines with !facility 82.

> +		vcpu->arch.sie_block->fpf &= ~FPF_SEBC;
> +		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.sebc ? FPF_SEBC : 0;
> +	}
>  	save_access_regs(vcpu->arch.host_acrs);
>  	restore_access_regs(vcpu->run->s.regs.acrs);
>  	/* save host (userspace) fprs/vrs */
> @@ -3344,6 +3354,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
>  	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
>  	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
> +	kvm_run->s.regs.sebc = (vcpu->arch.sie_block->fpf & FPF_SEBC) == FPF_SEBC;
>  	save_access_regs(vcpu->run->s.regs.acrs);
>  	restore_access_regs(vcpu->arch.host_acrs);
>  	/* Save guest register state */
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 5d6ae03..10ea208 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -223,6 +223,10 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	memcpy(scb_o->gcr, scb_s->gcr, 128);
>  	scb_o->pp = scb_s->pp;
>  
> +	/* speculative blocking */

This field should only be written back with test_kvm_facility(vcpu->kvm, 82)

(no public documentation, this looks like the SIE can modify this field?
Triggered by which instruction?)

> +	scb_o->fpf &= ~FPF_SEBC;
> +	scb_o->fpf |= scb_s->fpf & FPF_SEBC;
> +
>  	/* interrupt intercept */
>  	switch (scb_s->icptcode) {
>  	case ICPT_PROGI:
> @@ -265,6 +269,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	scb_s->ecb3 = 0;
>  	scb_s->ecd = 0;
>  	scb_s->fac = 0;
> +	scb_s->fpf = 0;
>  
>  	rc = prepare_cpuflags(vcpu, vsie_page);
>  	if (rc)
> @@ -324,6 +329,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  			prefix_unmapped(vsie_page);
>  		scb_s->ecb |= scb_o->ecb & ECB_TE;
>  	}
> +	/* speculative blocking */
> +	if (test_kvm_facility(vcpu->kvm, 82))
> +		scb_s->fpf |= scb_o->fpf & FPF_SEBC;
>  	/* SIMD */
>  	if (test_kvm_facility(vcpu->kvm, 129)) {
>  		scb_s->eca |= scb_o->eca & ECA_VX;




-- 

Thanks,

David / dhildenb
