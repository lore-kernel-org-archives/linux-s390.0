Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Feb 2021 11:36:13 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] s390/kvm: VSIE: correctly handle MVPG when in
 VSIE
Message-ID: <20210203113613.75274ae0@ibm-vm>
In-Reply-To: <20210202180028.876888-3-imbrenda@linux.ibm.com>
References: <20210202180028.876888-1-imbrenda@linux.ibm.com>
        <20210202180028.876888-3-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On Tue,  2 Feb 2021 19:00:28 +0100
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> Correctly handle the MVPG instruction when issued by a VSIE guest.
> 
> Fixes: a3508fbe9dc6d ("KVM: s390: vsie: initial support for nested
> virtualization") Cc: stable@vger.kernel.org
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 94
> +++++++++++++++++++++++++++++++++++++++++--- 1 file changed, 89
> insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 7db022141db3..2db49749e27b 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -416,11 +416,6 @@ static void unshadow_scb(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) memcpy((void *)((u64)scb_o + 0xc0),
>  		       (void *)((u64)scb_s + 0xc0), 0xf0 - 0xc0);
>  		break;
> -	case ICPT_PARTEXEC:
> -		/* MVPG only */
> -		memcpy((void *)((u64)scb_o + 0xc0),
> -		       (void *)((u64)scb_s + 0xc0), 0xd0 - 0xc0);
> -		break;
>  	}
>  
>  	if (scb_s->ihcpu != 0xffffU)
> @@ -982,6 +977,91 @@ static int handle_stfle(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) return 0;
>  }
>  
> +static u64 vsie_get_register(struct kvm_vcpu *vcpu, struct vsie_page
> *vsie_page, u8 reg) +{
> +	reg &= 0xf;
> +	switch (reg) {
> +	case 15:
> +		return vsie_page->scb_s.gg15;
> +	case 14:
> +		return vsie_page->scb_s.gg14;
> +	default:
> +		return vcpu->run->s.regs.gprs[reg];
> +	}
> +}
> +
> +static int vsie_handle_mvpg(struct kvm_vcpu *vcpu, struct vsie_page
> *vsie_page) +{
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	unsigned long pei1, pei2, src, dest, mask = PAGE_MASK;
> +	u64 *pei_block = &vsie_page->scb_o->mcic;
> +	int edat, rc1, rc2;
> +	union ctlreg0 cr0;
> +
> +	cr0.val = vcpu->arch.sie_block->gcr[0];
> +	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
> +	if (psw_bits(scb_s->gpsw).eaba == PSW_BITS_AMODE_24BIT)
> +		mask = 0xfff000;
> +	else if (psw_bits(scb_s->gpsw).eaba == PSW_BITS_AMODE_31BIT)
> +		mask = 0x7ffff000;
> +
> +	dest = vsie_get_register(vcpu, vsie_page, scb_s->ipb >> 16)
> & mask;
> +	src = vsie_get_register(vcpu, vsie_page, scb_s->ipb >> 20) &
> mask; +
> +	rc1 = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, dest,
> &pei1);
> +	rc2 = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, src,
> &pei2);
> +	/*
> +	 * Either everything went well, or something non-critical
> went wrong
> +	 * e.g. beause of a race. In either case, simply retry.
> +	 */
> +	if (rc1 == -EAGAIN || rc2 == -EAGAIN || (!rc1 && !rc2)) {
> +		retry_vsie_icpt(vsie_page);
> +		return -EAGAIN;
> +	}
> +	/* Something more serious went wrong, propagate the error */
> +	if (rc1 < 0)
> +		return rc1;
> +	if (rc2 < 0)
> +		return rc2;
> +
> +	/* The only possible suppressing exception: just deliver it
> */
> +	if (rc1 == PGM_TRANSLATION_SPEC || rc2 ==
> PGM_TRANSLATION_SPEC) {
> +		clear_vsie_icpt(vsie_page);
> +		rc1 = kvm_s390_inject_program_int(vcpu,
> PGM_TRANSLATION_SPEC);
> +		WARN_ON_ONCE(rc1);
> +		return 1;
> +	}
> +
> +	/*
> +	 * Forward the PEI intercept to the guest if it was a page
> fault, or
> +	 * also for segment and region table faults if EDAT applies.
> +	 */
> +	if (edat) {
> +		rc1 = rc1 == PGM_ASCE_TYPE ? rc1 : 0;
> +		rc2 = rc2 == PGM_ASCE_TYPE ? rc2 : 0;
> +	}

I just noticed, this should actually be:

        if (edat) {
                rc1 = rc1 == PGM_ASCE_TYPE ? rc1 : 0;
                rc2 = rc2 == PGM_ASCE_TYPE ? rc2 : 0;
        } else {
                rc1 = rc1 != PGM_PAGE_TRANSLATION ? rc1 : 0;
                rc2 = rc2 != PGM_PAGE_TRANSLATION ? rc2 : 0;
        }

I'll fix it in the next version

> +	if ((!rc1 || rc1 == PGM_PAGE_TRANSLATION) && (!rc2 || rc2 ==
> PGM_PAGE_TRANSLATION)) {
> +		pei_block[0] = pei1;
> +		pei_block[1] = pei2;
> +		return 1;
> +	}
> +
> +	retry_vsie_icpt(vsie_page);
> +
> +	/*
> +	 * The host has edat, and the guest does not, or it was an
> ASCE type
> +	 * exception. The host needs to inject the appropriate DAT
> interrupts
> +	 * into the guest.
> +	 */
> +	if (rc1)
> +		return inject_fault(vcpu, rc1, dest, 1);
> +	if (rc2)
> +		return inject_fault(vcpu, rc2, src, 0);
> +
> +	/* This should never be reached */
> +	return 0;
> +}
> +
>  /*
>   * Run the vsie on a shadow scb and a shadow gmap, without any
> further
>   * sanity checks, handling SIE faults.
> @@ -1068,6 +1148,10 @@ static int do_vsie_run(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) if ((scb_s->ipa & 0xf000) != 0xf000)
>  			scb_s->ipa += 0x1000;
>  		break;
> +	case ICPT_PARTEXEC:
> +		if (scb_s->ipa == 0xb254)
> +			rc = vsie_handle_mvpg(vcpu, vsie_page);
> +		break;
>  	}
>  	return rc;
>  }
