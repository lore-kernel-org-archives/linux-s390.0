Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726225AbgBRJvA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:51:00 -0500
Subject: Re: [PATCH v2 32/42] KVM: s390: protvirt: Support cmd 5 operation
 state
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-33-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f84bdd3a-a305-9bc1-af92-0b1ff36bfca8@redhat.com>
Date: Tue, 18 Feb 2020 10:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-33-borntraeger@de.ibm.com>
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
>  arch/s390/kvm/kvm-s390.c   | 8 ++++++++
>  include/uapi/linux/kvm.h   | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 7b82881ec3b4..d59825d95b9d 100644
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
> index 5426b01e3da1..b6113285f47f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4656,6 +4656,14 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu *vcpu,
>  		r = kvm_s390_pv_destroy_cpu(vcpu, &cmd->rc, &cmd->rrc);
>  		break;
>  	}
> +	case KVM_PV_VCPU_SET_IPL_PSW: {
> +		if (!kvm_s390_pv_handle_cpu(vcpu))
> +			return -EINVAL;
> +
> +		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD,
> +					      &cmd->rc, &cmd->rrc);

Can we squeeze that into kvm_arch_vcpu_ioctl_set_mpstate() instead? The
interface seems to do exactly what you want it to do.

KVM_MP_STATE_OPERATING_LOAD

Allow it only when in PV.



-- 
Thanks,

David / dhildenb
