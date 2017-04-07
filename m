From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 5/9] KVM: s390: gs support for kvm guests
Date: Fri, 7 Apr 2017 13:42:44 +0200
Message-ID: <70b26028-8076-c7ff-be17-b99946a20642@redhat.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
 <1491562082-6392-6-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-6-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Fan Zhang <zhangfan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


> +
> +	hpa = scb_s->sdnxo;
> +	if (hpa) {
> +		gpa = scb_o->sdnxo;

Other blocks in this function explicitly extract the gpa portion

gpa = scb_o->sdnxo & ~0xfUL;

But this shouldn't matter as it will be dropped either way when
converting to pfn. At least for now this should work.

> +		unpin_guest_page(vcpu->kvm, gpa, hpa);
> +		scb_s->sdnxo = 0;
> +	}
>  }
>  
>  /*
> @@ -590,6 +602,33 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  			goto unpin;
>  		scb_s->riccbd = hpa;
>  	}
> +	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
> +		unsigned long sdnxc;
> +
> +		gpa = scb_o->sdnxo & ~0xfUL;
> +		sdnxc = scb_o->sdnxo & 0xfUL;
> +		if (!gpa || !(gpa & ~0x1fffUL)) {
> +			rc = set_validity_icpt(scb_s, 0x10b0U);
> +			goto unpin;
> +		}
> +		if (sdnxc < 6 || sdnxc > 12) {
> +			rc = set_validity_icpt(scb_s, 0x10b1U);
> +			goto unpin;
> +		}
> +		if (gpa & ((1 << sdnxc) - 1)) {
> +			rc = set_validity_icpt(scb_s, 0x10b2U);
> +			goto unpin;
> +		}
> +		/* Due to alignment rules (checked above) this cannot
> +		 * cross page boundaries
> +		 */
> +		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
> +		if (rc == -EINVAL)
> +			rc = set_validity_icpt(scb_s, 0x10b0U);
> +		if (rc)
> +			goto unpin;
> +		scb_s->sdnxo = hpa;

I'm curious, this will result in no sdnxc getting set. Shouldn't there
be something like the following, cause otherwise there would be a
validity icpt 0x10b1U (guessing from the code above).

scb_s->sdnxo = hpa | sdnxc;

> +	}
>  	return 0;
>  unpin:
>  	unpin_blocks(vcpu, vsie_page);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index f51d508..c9d5227 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_MMU_RADIX 134
>  #define KVM_CAP_PPC_MMU_HASH_V3 135
>  #define KVM_CAP_IMMEDIATE_EXIT 136
> +#define KVM_CAP_S390_GS 137
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 


-- 

Thanks,

David
