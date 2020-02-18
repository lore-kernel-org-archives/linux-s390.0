Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726225AbgBRJdi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:33:38 -0500
Subject: Re: [PATCH v2 28/42] KVM: s390: protvirt: Add program exception
 injection
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-29-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0911c8c1-0877-047b-0da5-4c7f79aef3ae@redhat.com>
Date: Tue, 18 Feb 2020 10:33:28 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-29-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
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
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 3e160d9a214f..7a10096fa204 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -836,6 +836,21 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
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
> @@ -856,6 +871,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
>  					 pgm_info.code, 0);
>  
> +	if (kvm_s390_pv_is_protected(vcpu->kvm))

Can we actually ever have PER set, and what would happen if so?
Shouldn't we also return -EINVAL?

> +		return __deliver_prog_pv(vcpu, pgm_info.code & ~PGM_PER);
> +
>  	switch (pgm_info.code & ~PGM_PER) {
>  	case PGM_AFX_TRANSLATION:
>  	case PGM_ASX_TRANSLATION:
> 


-- 
Thanks,

David / dhildenb
