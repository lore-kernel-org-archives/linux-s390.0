Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39551 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727926AbgAJOCv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 09:02:51 -0500
Date: Fri, 10 Jan 2020 15:01:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Cleanup initial cpu reset
Message-ID: <20200110150158.36ded698.cohuck@redhat.com>
In-Reply-To: <20200110134824.37963-1-frankja@linux.ibm.com>
References: <b01c38bf-5887-25d8-b787-271e5c2292e2@redhat.com>
        <20200110134824.37963-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Fri, 10 Jan 2020 08:48:24 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The code seems to be quite old and uses lots of unneeded spaces for
> alignment, which doesn't really help with readability.
> 
> Let's:
> * Get rid of the extra spaces
> * Remove the ULs as they are not needed on 0s
> * Define constants for the CR 0 and 14 initial values
> * Use the sizeof of the gcr array to memset it to 0
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> Something like this?

+1, like.

> Did I forget something?
> 
> ---
>  arch/s390/include/asm/kvm_host.h |  5 +++++
>  arch/s390/kvm/kvm-s390.c         | 18 +++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 02f4c21c57f6..37747db884bd 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -122,6 +122,11 @@ struct mcck_volatile_info {
>  	__u32 reserved;
>  };
>  
> +#define CR0_INITIAL (CR0_UNUSED_56 | CR0_INTERRUPT_KEY_SUBMASK | \
> +		     CR0_MEASUREMENT_ALERT_SUBMASK)
> +#define CR14_INITIAL (CR14_UNUSED_32 | CR14_UNUSED_33 | \
> +		      CR14_EXTERNAL_DAMAGE_SUBMASK)

Maybe CR<n>_INITIAL_MASK?

> +
>  #define CPUSTAT_STOPPED    0x80000000
>  #define CPUSTAT_WAIT       0x10000000
>  #define CPUSTAT_ECALL_PEND 0x08000000
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d9e6bf3d54f0..c163311e7f3d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2847,19 +2847,15 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  {
>  	/* this equals initial cpu reset in pop, but we don't switch to ESA */
> -	vcpu->arch.sie_block->gpsw.mask = 0UL;
> -	vcpu->arch.sie_block->gpsw.addr = 0UL;
> +	vcpu->arch.sie_block->gpsw.mask = 0;
> +	vcpu->arch.sie_block->gpsw.addr = 0;
>  	kvm_s390_set_prefix(vcpu, 0);
>  	kvm_s390_set_cpu_timer(vcpu, 0);
> -	vcpu->arch.sie_block->ckc       = 0UL;
> -	vcpu->arch.sie_block->todpr     = 0;
> -	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
> -	vcpu->arch.sie_block->gcr[0]  = CR0_UNUSED_56 |
> -					CR0_INTERRUPT_KEY_SUBMASK |
> -					CR0_MEASUREMENT_ALERT_SUBMASK;
> -	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
> -					CR14_UNUSED_33 |
> -					CR14_EXTERNAL_DAMAGE_SUBMASK;
> +	vcpu->arch.sie_block->ckc = 0;
> +	vcpu->arch.sie_block->todpr = 0;
> +	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
> +	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL;
> +	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL;
>  	/* make sure the new fpc will be lazily loaded */
>  	save_fpu_regs();
>  	current->thread.fpu.fpc = 0;

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
