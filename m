From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: wire up bpb feature
Date: Wed, 17 Jan 2018 14:51:00 +0100
Message-ID: <887651e4-10fa-9bd1-0ce6-091235a9b085@redhat.com>
References: <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
 <20180117134434.48676-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180117134434.48676-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On 17.01.2018 14:44, Christian Borntraeger wrote:
> The new firmware interfaces for branch prediction behaviour changes
> are transparently available for the guest. Nevertheless, there is
> new state attached that should be migrated and properly resetted.
> Provide a mechanism for handling reset, migration and VSIE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> v1->v2: - review feedback from David
> 	- rename seb(c) into bpb(c)
>  arch/s390/include/asm/kvm_host.h |  3 ++-
>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
>  arch/s390/kvm/kvm-s390.c         | 12 ++++++++++++
>  arch/s390/kvm/vsie.c             | 10 ++++++++++
>  include/uapi/linux/kvm.h         |  1 +
>  5 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index e14f381..c1b0a9a 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -207,7 +207,8 @@ struct kvm_s390_sie_block {
>  	__u16	ipa;			/* 0x0056 */
>  	__u32	ipb;			/* 0x0058 */
>  	__u32	scaoh;			/* 0x005c */
> -	__u8	reserved60;		/* 0x0060 */
> +#define FPF_BPBC 	0x20
> +	__u8	fpf;			/* 0x0060 */
>  #define ECB_GS		0x40
>  #define ECB_TE		0x10
>  #define ECB_SRSI	0x04
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 38535a57..4cdaa55 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -224,6 +224,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_RICCB  (1UL << 7)
>  #define KVM_SYNC_FPRS   (1UL << 8)
>  #define KVM_SYNC_GSCB   (1UL << 9)
> +#define KVM_SYNC_BPBC   (1UL << 10)
>  /* length and alignment of the sdnx as a power of two */
>  #define SDNXC 8
>  #define SDNXL (1UL << SDNXC)
> @@ -247,7 +248,9 @@ struct kvm_sync_regs {
>  	};
>  	__u8  reserved[512];	/* for future vector expansion */
>  	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
> -	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
> +	__u8 bpbc : 1;		/* bp mode */
> +	__u8 reserved2 : 7;
> +	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
>  	__u8 riccb[64];		/* runtime instrumentation controls block */
>  	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
>  	union {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2c93cbb..2598cf243 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -421,6 +421,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_GS:
>  		r = test_facility(133);
>  		break;
> +	case KVM_CAP_S390_BPB:
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
> +		vcpu->run->kvm_valid_regs |= KVM_SYNC_BPBC;
>  	if (test_kvm_facility(vcpu->kvm, 133))
>  		vcpu->run->kvm_valid_regs |= KVM_SYNC_GSCB;
>  	/* fprs can be synchronized via vrs, even if the guest has no vx. With
> @@ -2339,6 +2344,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  	current->thread.fpu.fpc = 0;
>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> +	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>  	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>  	kvm_clear_async_pf_completion_queue(vcpu);
>  	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> @@ -3298,6 +3304,11 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
>  		vcpu->arch.gs_enabled = 1;
>  	}
> +	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
> +	    test_kvm_facility(vcpu->kvm, 82)) {
> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
> +		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
> +	}
>  	save_access_regs(vcpu->arch.host_acrs);
>  	restore_access_regs(vcpu->run->s.regs.acrs);
>  	/* save host (userspace) fprs/vrs */
> @@ -3344,6 +3355,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
>  	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
>  	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
> +	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>  	save_access_regs(vcpu->run->s.regs.acrs);
>  	restore_access_regs(vcpu->arch.host_acrs);
>  	/* Save guest register state */
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 5d6ae03..7513483 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -223,6 +223,12 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	memcpy(scb_o->gcr, scb_s->gcr, 128);
>  	scb_o->pp = scb_s->pp;
>  
> +	/* branch prediction */
> +	if (test_kvm_facility(vcpu->kvm, 82)) {
> +		scb_o->fpf &= ~FPF_BPBC;
> +		scb_o->fpf |= scb_s->fpf & FPF_BPBC;
> +	}
> +
>  	/* interrupt intercept */
>  	switch (scb_s->icptcode) {
>  	case ICPT_PROGI:
> @@ -265,6 +271,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	scb_s->ecb3 = 0;
>  	scb_s->ecd = 0;
>  	scb_s->fac = 0;
> +	scb_s->fpf = 0;
>  
>  	rc = prepare_cpuflags(vcpu, vsie_page);
>  	if (rc)
> @@ -324,6 +331,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  			prefix_unmapped(vsie_page);
>  		scb_s->ecb |= scb_o->ecb & ECB_TE;
>  	}
> +	/* branch prediction */
> +	if (test_kvm_facility(vcpu->kvm, 82))
> +		scb_s->fpf |= scb_o->fpf & FPF_BPBC;
>  	/* SIMD */
>  	if (test_kvm_facility(vcpu->kvm, 129)) {
>  		scb_s->eca |= scb_o->eca & ECA_VX;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 496e59a..79f6050 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -932,6 +932,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
>  #define KVM_CAP_S390_AIS_MIGRATION 150
> +#define KVM_CAP_S390_BPB 151
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
