Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46472 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728280AbgBUKro (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 05:47:44 -0500
Subject: Re: [PATCH v3 37/37] KVM: s390: protvirt: introduce and enable
 KVM_CAP_S390_PROTECTED
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-38-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dd6ebcdb-2d28-eecc-6520-456e22c95e8c@redhat.com>
Date: Fri, 21 Feb 2020 11:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-38-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 20.02.20 11:40, Christian Borntraeger wrote:
> Now that everything is in place, we can announce the feature.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 3 +++
>  include/uapi/linux/kvm.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d79ccd34b5cb..e5f823840c29 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -574,6 +574,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_BPB:
>  		r = test_facility(82);
>  		break;
> +	case KVM_CAP_S390_PROTECTED:
> +		r = is_prot_virt_host();
> +		break;
>  	default:
>  		r = 0;
>  	}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 60efbbc86209..2551de8bec57 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1015,6 +1015,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_NISV_TO_USER 177
>  #define KVM_CAP_ARM_INJECT_EXT_DABT 178
>  #define KVM_CAP_S390_VCPU_RESETS 179
> +#define KVM_CAP_S390_PROTECTED 180
>  
>  #ifdef KVM_CAP_IRQ_ROUTING

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb
