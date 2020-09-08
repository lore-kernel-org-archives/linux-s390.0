Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57347 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729210AbgIHLBb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 07:01:31 -0400
Date: Tue, 8 Sep 2020 13:01:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3] KVM: s390: Introduce storage key removal facility
Message-ID: <20200908130117.1a8fd4ea.cohuck@redhat.com>
In-Reply-To: <20200908100249.23150-1-frankja@linux.ibm.com>
References: <20200908100249.23150-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Tue,  8 Sep 2020 06:02:49 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> The storage key removal facility makes skey related instructions
> result in special operation program exceptions. It is based on the
> Keyless Subset Facility.
> 
> The usual suspects are iske, sske, rrbe and their respective
> variants. lpsw(e), pfmf and tprot can also specify a key and essa with
> an ORC of 4 will consult the change bit, hence they all result in
> exceptions.
> 
> Unfortunately storage keys were so essential to the architecture, that
> there is no facility bit that we could deactivate. That's why the
> removal facility (bit 169) was introduced which makes it necessary,
> that, if active, the skey related facilities 10, 14, 66, 145 and 149
> are zero. Managing this requirement and migratability has to be done
> in userspace, as KVM does not check the facilities it receives to be
> able to easily implement userspace emulation.
> 
> Removing storage key support allows us to circumvent complicated
> emulation code and makes huge page support tremendously easier.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> v3:
> 	* Put kss handling into own function
> 	* Removed some unneeded catch statements and converted others to ifs
> 
> v2:
> 	* Removed the likely
> 	* Updated and re-shuffeled the comments which had the wrong information
> 
> ---
>  arch/s390/kvm/intercept.c | 34 +++++++++++++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.c  |  5 +++++
>  arch/s390/kvm/priv.c      | 26 +++++++++++++++++++++++---
>  3 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index e7a7c499a73f..9c699c3fcf84 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -33,6 +33,7 @@ u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
>  	case ICPT_OPEREXC:
>  	case ICPT_PARTEXEC:
>  	case ICPT_IOINST:
> +	case ICPT_KSS:
>  		/* instruction only stored for these icptcodes */
>  		ilen = insn_length(vcpu->arch.sie_block->ipa >> 8);
>  		/* Use the length of the EXECUTE instruction if necessary */
> @@ -531,6 +532,37 @@ static int handle_pv_notification(struct kvm_vcpu *vcpu)
>  	return handle_instruction(vcpu);
>  }
>  
> +static int handle_kss(struct kvm_vcpu *vcpu)
> +{
> +	if (!test_kvm_facility(vcpu->kvm, 169))
> +		return kvm_s390_skey_check_enable(vcpu);
> +
> +	/*
> +	 * Storage key removal facility emulation.
> +	 *
> +	 * KSS is the same priority as an instruction
> +	 * interception. Hence we need handling here

s/here/both here/ ?

(I think you can also format this slightly wider, now that indentation
is not so deep anymore.)

> +	 * and in the instruction emulation code.
> +	 *
> +	 * KSS is nullifying (no psw forward), SKRF
> +	 * issues suppressing SPECIAL OPS, so we need
> +	 * to forward by hand.
> +	 */
> +	if  (vcpu->arch.sie_block->ipa == 0) {
> +		/*
> +		 * Interception caused by a key in a
> +		 * exception new PSW mask. The guest
> +		 * PSW has already been updated to the
> +		 * non-valid PSW so we only need to
> +		 * inject a PGM.
> +		 */
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	}
> +
> +	kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
> +	return kvm_s390_inject_program_int(vcpu, PGM_SPECIAL_OPERATION);
> +}
> +
>  int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>  {
>  	int rc, per_rc = 0;
> @@ -565,7 +597,7 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>  		rc = handle_partial_execution(vcpu);
>  		break;
>  	case ICPT_KSS:
> -		rc = kvm_s390_skey_check_enable(vcpu);
> +		rc = handle_kss(vcpu);
>  		break;
>  	case ICPT_MCHKREQ:
>  	case ICPT_INT_ENABLE:

(...)

> @@ -257,7 +264,7 @@ static int handle_iske(struct kvm_vcpu *vcpu)
>  
>  	rc = try_handle_skey(vcpu);
>  	if (rc)
> -		return rc != -EAGAIN ? rc : 0;
> +		return (rc != -EAGAIN || rc != -EOPNOTSUPP) ? rc : 0;

As noticed by David, this probably needs to be &&, or maybe flipped to

		return (rc == -EAGAIN || rc == -EOPNOTSUPP) ? 0 : rc;

>  
>  	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
>  
