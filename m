Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42369 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgBXTIa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Feb 2020 14:08:30 -0500
Subject: Re: [PATCH v4 29/36] KVM: s390: protvirt: Support cmd 5 operation
 state
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-30-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <99363e0d-494b-59ab-93dd-ccda4f25ef6d@redhat.com>
Date: Mon, 24 Feb 2020 20:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <20200224114107.4646-30-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 24.02.20 12:41, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Code 5 for the set cpu state UV call tells the UV to load a PSW from
> the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
> 0/1). Also it sets the cpu into operating state afterwards, so we can
> start it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 1 +
>  arch/s390/kvm/kvm-s390.c   | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 99e1a14ef909..4945e44e1528 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -169,6 +169,7 @@ struct uv_cb_unp {
>  #define PV_CPU_STATE_OPR	1
>  #define PV_CPU_STATE_STP	2
>  #define PV_CPU_STATE_CHKSTP	3
> +#define PV_CPU_STATE_OPR_LOAD	5
>  
>  struct uv_cb_cpu_set_state {
>  	struct uv_cb_header header;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f10cce6fc5e0..9c0ab66128fd 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3728,6 +3728,12 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  		rc = kvm_s390_vcpu_start(vcpu);
>  		break;
>  	case KVM_MP_STATE_LOAD:
> +		if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
> +			rc = -ENXIO;
> +			break;
> +		}
> +		rc = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
> +		break;
>  	case KVM_MP_STATE_CHECK_STOP:
>  		/* fall through - CHECK_STOP and LOAD are not supported yet */
>  	default:
> 

Fits in nicely :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
