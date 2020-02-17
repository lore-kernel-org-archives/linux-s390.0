Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgBQLIk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 06:08:40 -0500
Subject: Re: [PATCH v2 20/42] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-21-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ad84934a-3d18-d56e-5658-1d8b8292f6b3@redhat.com>
Date: Mon, 17 Feb 2020 12:08:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-21-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

> @@ -4460,6 +4489,10 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  
>  	switch (mop->op) {
>  	case KVM_S390_MEMOP_LOGICAL_READ:
> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +			r = -EINVAL;
> +			break;
> +		}

Could we have a possible race with disabling code, especially while
concurrently freeing? (sorry if I ask again, there was just a flood of
emails)

>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>  			r = check_gva_range(vcpu, mop->gaddr, mop->ar,
>  					    mop->size, GACC_FETCH);
> @@ -4472,6 +4505,10 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  		}
>  		break;
>  	case KVM_S390_MEMOP_LOGICAL_WRITE:
> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +			r = -EINVAL;
> +			break;
> +		}

dito

>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>  			r = check_gva_range(vcpu, mop->gaddr, mop->ar,
>  					    mop->size, GACC_STORE);
> @@ -4483,6 +4520,11 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  		}
>  		r = write_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
>  		break;
> +	case KVM_S390_MEMOP_SIDA_READ:
> +	case KVM_S390_MEMOP_SIDA_WRITE:
> +		/* we are locked against sida going away by the vcpu->mutex */
> +		r = kvm_s390_guest_sida_op(vcpu, mop);
> +		break;
>  	default:
>  		r = -EINVAL;
>  	}
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index 09573e36c329..80169a9b43ec 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -92,6 +92,7 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
>  
>  	free_pages(vcpu->arch.pv.stor_base,
>  		   get_order(uv_info.guest_cpu_stor_len));
> +	free_page(sida_origin(vcpu->arch.sie_block));
>  	vcpu->arch.sie_block->pv_handle_cpu = 0;
>  	vcpu->arch.sie_block->pv_handle_config = 0;
>  	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
> @@ -121,6 +122,14 @@ int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
>  	uvcb.state_origin = (u64)vcpu->arch.sie_block;
>  	uvcb.stor_origin = (u64)vcpu->arch.pv.stor_base;
>  
> +	/* Alloc Secure Instruction Data Area Designation */
> +	vcpu->arch.sie_block->sidad = __get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!vcpu->arch.sie_block->sidad) {
> +		free_pages(vcpu->arch.pv.stor_base,
> +			   get_order(uv_info.guest_cpu_stor_len));
> +		return -ENOMEM;
> +	}
> +
>  	cc = uv_call(0, (u64)&uvcb);
>  	*rc = uvcb.header.rc;
>  	*rrc = uvcb.header.rrc;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 207915488502..0fdee1bc3798 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -475,11 +475,15 @@ struct kvm_s390_mem_op {
>  	__u32 op;		/* type of operation */
>  	__u64 buf;		/* buffer in userspace */
>  	__u8 ar;		/* the access register number */
> -	__u8 reserved[31];	/* should be set to 0 */
> +	__u8 reserved21[3];	/* should be set to 0 */
> +	__u32 sida_offset;	/* offset into the sida */
> +	__u8 reserved28[24];	/* should be set to 0 */
>  };

As discussed, I'd prefer an overlaying layout for the sida, as the ar
does not make any sense (correct me if I'm wrong :) )

__u32 op;		/* type of operation */
__u64 buf;		/* buffer in userspace */
uinon {
	__u8 ar;		/* the access register number */
	__u32 sida_offset;	/* offset into the sida */
	__u8 reserved[32];	/* should be set to 0 */
};

With something like that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
