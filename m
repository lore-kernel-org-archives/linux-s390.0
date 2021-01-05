Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728135AbhAEKcm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jan 2021 05:32:42 -0500
Subject: Re: [PATCH v1 3/4] s390/kvm: add kvm_s390_vsie_mvpg_check needed for
 VSIE MVPG
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <20201218141811.310267-4-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ae6f3ec4-773f-2527-6cb5-7aaf803f73bf@redhat.com>
Date: Tue, 5 Jan 2021 11:31:08 +0100
MIME-Version: 1.0
In-Reply-To: <20201218141811.310267-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On 18.12.20 15:18, Claudio Imbrenda wrote:
> Add kvm_s390_vsie_mvpg_check to perform the necessary checks in case an
> MVPG instruction intercepts in a VSIE guest.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.c | 55 +++++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/gaccess.h |  3 +++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 8e256a233583..90e9baff6eac 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1228,3 +1228,58 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
>  	mmap_read_unlock(sg->mm);
>  	return rc;
>  }
> +
> +static int kvm_s390_mvpg_check_one(struct kvm_vcpu *vcpu, unsigned long *addr,
> +			     const int edat, const union asce asce,
> +			     const enum gacc_mode mode, unsigned long *pteptr)
> +{
> +	enum prot_type prot;
> +	int rc;
> +
> +	rc = guest_translate(vcpu, *addr, addr, asce, mode, &prot, pteptr);
> +	if (rc <= 0)
> +		return rc;
> +
> +	switch (rc) {
> +	case PGM_REGION_FIRST_TRANS:
> +	case PGM_REGION_SECOND_TRANS:
> +	case PGM_REGION_THIRD_TRANS:
> +	case PGM_SEGMENT_TRANSLATION:
> +		if (!edat)
> +			return trans_exc(vcpu, rc, *addr, 0, mode, prot);
> +		*pteptr |= 4;

Hmmm, I wonder why that is necessary. Can't we set that in all relevant
cases in guest_translate() just as you do via

*entryptr |= dat_protection ? 6 : 4;


Can you enlighten me? :)

> +		fallthrough;
> +	case PGM_PAGE_TRANSLATION:
> +		return -ENOENT;
> +	default:
> +		return rc;
> +	}
> +}
> +
> +int kvm_s390_vsie_mvpg_check(struct kvm_vcpu *vcpu, unsigned long r1,
> +			     unsigned long r2, void *gpei)
> +{
> +	unsigned long pei[2] = {0};
> +	union ctlreg0 cr0;
> +	union asce cr1;
> +	int edat, rc1, rc2;
> +
> +	cr0.val = vcpu->arch.sie_block->gcr[0];
> +	cr1.val = vcpu->arch.sie_block->gcr[1];
> +	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
> +
> +	rc1 = kvm_s390_mvpg_check_one(vcpu, &r1, edat, cr1, GACC_FETCH, pei);
> +	rc2 = kvm_s390_mvpg_check_one(vcpu, &r2, edat, cr1, GACC_STORE, pei + 1);
> +
> +	if (rc1 == -ENOENT || rc2 == -ENOENT) {
> +		memcpy(gpei, pei, sizeof(pei));

I'd really prefer just passing two unsigned long pointers to
kvm_s390_vsie_mvpg_check() and eventually directly forwarding them to
kvm_s390_mvpg_check_one().

> +		return -ENOENT;
> +	}
> +
> +	if (rc2 < 0)
> +		return rc2;
> +	if (rc1 < 0)
> +		return rc1;
> +
> +	return 0;
> +}
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index f4c51756c462..2c53cee3b29f 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -166,6 +166,9 @@ int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
>  int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
>  		 unsigned long len, enum gacc_mode mode);
>  
> +int kvm_s390_vsie_mvpg_check(struct kvm_vcpu *vcpu, unsigned long r1,
> +			     unsigned long r2, void *gpei);
> +
>  int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>  		      void *data, unsigned long len, enum gacc_mode mode);
>  
> 


-- 
Thanks,

David / dhildenb
