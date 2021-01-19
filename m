Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730808AbhASPAZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 10:00:25 -0500
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <20201218141811.310267-3-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v1 2/4] s390/kvm: extend guest_translate for MVPG
 interpretation
Message-ID: <66d0da8a-a43d-1f04-8fa0-dec5e49b56b7@linux.ibm.com>
Date: Tue, 19 Jan 2021 15:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <20201218141811.310267-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On 12/18/20 3:18 PM, Claudio Imbrenda wrote:
> Extend guest_translate to optionally return the address of the guest
> DAT table which caused the exception, and change the return value to int.
> 
> Also return the appropriate values in the low order bits of the address
> indicating protection or EDAT.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 6d6b57059493..8e256a233583 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -598,6 +598,10 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
>   * @asce: effective asce
>   * @mode: indicates the access mode to be used
>   * @prot: returns the type for protection exceptions
> + * @entryptr: returns the physical address of the last DAT table entry
> + *            processed, additionally setting a few flags in the lower bits
> + *            to indicate whether a translation exception or a protection
> + *            exception were encountered during the address translation.

I'd much rather have another argument pointer than fusing the address
and the status bits. Or we could make prot a struct and add your status
bits in.

>   *
>   * Translate a guest virtual address into a guest absolute address by means
>   * of dynamic address translation as specified by the architecture.
> @@ -611,9 +615,10 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
>   *	      the returned value is the program interruption code as defined
>   *	      by the architecture
>   */
> -static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
> -				     unsigned long *gpa, const union asce asce,
> -				     enum gacc_mode mode, enum prot_type *prot)
> +static int guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
> +			   unsigned long *gpa, const union asce asce,
> +			   enum gacc_mode mode, enum prot_type *prot,
> +			   unsigned long *entryptr)
>  {
>  	union vaddress vaddr = {.addr = gva};
>  	union raddress raddr = {.addr = gva};
> @@ -628,6 +633,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  	edat1 = ctlreg0.edat && test_kvm_facility(vcpu->kvm, 8);
>  	edat2 = edat1 && test_kvm_facility(vcpu->kvm, 78);
>  	iep = ctlreg0.iep && test_kvm_facility(vcpu->kvm, 130);
> +	if (entryptr)
> +		*entryptr = 0;
>  	if (asce.r)
>  		goto real_address;
>  	ptr = asce.origin * PAGE_SIZE;
> @@ -667,6 +674,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  			return PGM_ADDRESSING;
>  		if (deref_table(vcpu->kvm, ptr, &rfte.val))
>  			return -EFAULT;
> +		if (entryptr)
> +			*entryptr = ptr;
>  		if (rfte.i)
>  			return PGM_REGION_FIRST_TRANS;
>  		if (rfte.tt != TABLE_TYPE_REGION1)
> @@ -685,6 +694,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  			return PGM_ADDRESSING;
>  		if (deref_table(vcpu->kvm, ptr, &rste.val))
>  			return -EFAULT;
> +		if (entryptr)
> +			*entryptr = ptr;
>  		if (rste.i)
>  			return PGM_REGION_SECOND_TRANS;
>  		if (rste.tt != TABLE_TYPE_REGION2)
> @@ -703,6 +714,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  			return PGM_ADDRESSING;
>  		if (deref_table(vcpu->kvm, ptr, &rtte.val))
>  			return -EFAULT;
> +		if (entryptr)
> +			*entryptr = ptr;
>  		if (rtte.i)
>  			return PGM_REGION_THIRD_TRANS;
>  		if (rtte.tt != TABLE_TYPE_REGION3)
> @@ -713,6 +726,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  			dat_protection |= rtte.fc1.p;
>  			iep_protection = rtte.fc1.iep;
>  			raddr.rfaa = rtte.fc1.rfaa;
> +			if (entryptr)
> +				*entryptr |= dat_protection ? 6 : 4;

Magic constants are magic

>  			goto absolute_address;
>  		}
>  		if (vaddr.sx01 < rtte.fc0.tf)
> @@ -731,6 +746,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  			return PGM_ADDRESSING;
>  		if (deref_table(vcpu->kvm, ptr, &ste.val))
>  			return -EFAULT;
> +		if (entryptr)
> +			*entryptr = ptr;
>  		if (ste.i)
>  			return PGM_SEGMENT_TRANSLATION;
>  		if (ste.tt != TABLE_TYPE_SEGMENT)
> @@ -741,6 +758,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  			dat_protection |= ste.fc1.p;
>  			iep_protection = ste.fc1.iep;
>  			raddr.sfaa = ste.fc1.sfaa;
> +			if (entryptr)
> +				*entryptr |= dat_protection ? 6 : 4;
>  			goto absolute_address;
>  		}
>  		dat_protection |= ste.fc0.p;
> @@ -751,10 +770,14 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
>  		return PGM_ADDRESSING;
>  	if (deref_table(vcpu->kvm, ptr, &pte.val))
>  		return -EFAULT;
> +	if (entryptr)
> +		*entryptr = ptr;
>  	if (pte.i)
>  		return PGM_PAGE_TRANSLATION;
>  	if (pte.z)
>  		return PGM_TRANSLATION_SPEC;
> +	if (entryptr && dat_protection)
> +		*entryptr |= 2;
>  	dat_protection |= pte.p;
>  	iep_protection = pte.iep;
>  	raddr.pfra = pte.pfra;
> @@ -810,7 +833,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>  					 PROT_TYPE_LA);
>  		ga &= PAGE_MASK;
>  		if (psw_bits(*psw).dat) {
> -			rc = guest_translate(vcpu, ga, pages, asce, mode, &prot);
> +			rc = guest_translate(vcpu, ga, pages, asce, mode, &prot, NULL);
>  			if (rc < 0)
>  				return rc;
>  		} else {
> @@ -920,7 +943,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
>  	}
>  
>  	if (psw_bits(*psw).dat && !asce.r) {	/* Use DAT? */
> -		rc = guest_translate(vcpu, gva, gpa, asce, mode, &prot);
> +		rc = guest_translate(vcpu, gva, gpa, asce, mode, &prot, NULL);
>  		if (rc > 0)
>  			return trans_exc(vcpu, rc, gva, 0, mode, prot);
>  	} else {
> 
