From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
Date: Mon, 17 Sep 2018 10:51:08 +0200
Message-ID: <9263b698-1827-1b7f-28bf-75b44657dea2@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Am 12.09.18 um 21:43 schrieb Tony Krowiak:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
> to enable or disable AP instruction interpretation from userspace
> via the KVM_SET_DEVICE_ATTR ioctl:
> 
> * The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
>   interpretation of AP instructions executed on the guest.
> 
> * The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
>   interpretation of AP instructions executed on the guest. In this
>   case the instructions will be intercepted and pass through to
>   the guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |    1 +
>  arch/s390/include/uapi/asm/kvm.h |    2 ++
>  arch/s390/kvm/kvm-s390.c         |   27 +++++++++++++++++++++++----
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index b32bd1b..36d3531 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -719,6 +719,7 @@ struct kvm_s390_crypto {
>  	__u32 crycbd;
>  	__u8 aes_kw;
>  	__u8 dea_kw;
> +	__u8 apie;
>  };
>  
>  #define APCB0_MASK_SIZE 1
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 8c23afc..a8dbd90 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -161,6 +161,8 @@ struct kvm_s390_vm_cpu_subfunc {
>  #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
>  #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
>  #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
> +#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
> +#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
>  
>  /* kvm attributes for migration mode */
>  #define KVM_S390_VM_MIGRATION_STOP	0
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2cdd980..286c2e0 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -856,12 +856,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>  
>  static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>  {
> -	if (!test_kvm_facility(kvm, 76))
> -		return -EINVAL;
> -
>  	mutex_lock(&kvm->lock);
>  	switch (attr->attr) {
>  	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
> +		if (!test_kvm_facility(kvm, 76))
> +			return -EINVAL;
>  		get_random_bytes(
>  			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
>  			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
> @@ -869,6 +868,8 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>  		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
>  		break;
>  	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
> +		if (!test_kvm_facility(kvm, 76))
> +			return -EINVAL;
>  		get_random_bytes(
>  			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>  			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
> @@ -876,17 +877,31 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>  		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
>  		break;
>  	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
> +		if (!test_kvm_facility(kvm, 76))
> +			return -EINVAL;
>  		kvm->arch.crypto.aes_kw = 0;
>  		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
>  			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>  		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
>  		break;
>  	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
> +		if (!test_kvm_facility(kvm, 76))
> +			return -EINVAL;
>  		kvm->arch.crypto.dea_kw = 0;
>  		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
>  			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>  		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>  		break;
> +	case KVM_S390_VM_CRYPTO_ENABLE_APIE:
> +		if (!ap_instructions_available()) {
> +			mutex_unlock(&kvm->lock);
> +			return -EOPNOTSUPP;
> +		}
> +		kvm->arch.crypto.apie = 1;
> +		break;
> +	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
> +		kvm->arch.crypto.apie = 0;
> +		break;
>  	default:
>  		mutex_unlock(&kvm->lock);
>  		return -ENXIO;
> @@ -1493,6 +1508,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
>  		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>  		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>  		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
> +		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
> +		case KVM_S390_VM_CRYPTO_DISABLE_APIE:

As also replied to the QEMU series, could we indicate
KVM_S390_VM_CRYPTO_ENABLE_APIE (and maybe
KVM_S390_VM_CRYPTO_DISABLE_APIE) only with ap_instructions_available(),
so we can avoid the additional KVM_S390_VM_CPU_FEAT_AP?

KVM_S390_VM_CPU_FEAT_AP is right now completely unused in KVM otherwise
(never checked, we only care about apie).

-- 

Thanks,

David / dhildenb
