Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727682AbgBIPw7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 9 Feb 2020 10:52:59 -0500
Subject: Re: [PATCH 26/35] KVM: s390: protvirt: Add program exception
 injection
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-27-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cbdd3e0a-1c88-51a2-04b4-1e507dbf1093@redhat.com>
Date: Sun, 9 Feb 2020 16:52:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-27-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Only two program exceptions can be injected for a protected guest:
> specification and operand.
> 
> For both, a code needs to be specified in the interrupt injection
> control of the state description, as the guest prefix page is not
> accessible to KVM for such guests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index c28fa09cb557..2df6459ab98b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -837,6 +837,21 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
>  	return rc ? -EFAULT : 0;
>  }
>  
> +static int __deliver_prog_pv(struct kvm_vcpu *vcpu, u16 code)
> +{
> +	switch (code) {
> +	case PGM_SPECIFICATION:
> +		vcpu->arch.sie_block->iictl = IICTL_CODE_SPECIFICATION;
> +		break;
> +	case PGM_OPERAND:
> +		vcpu->arch.sie_block->iictl = IICTL_CODE_OPERAND;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
> @@ -857,6 +872,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
>  					 pgm_info.code, 0);
>  
> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
> +		return __deliver_prog_pv(vcpu, pgm_info.code & ~PGM_PER);
> +
>  	switch (pgm_info.code & ~PGM_PER) {
>  	case PGM_AFX_TRANSLATION:
>  	case PGM_ASX_TRANSLATION:
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
