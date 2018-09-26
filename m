From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v11 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
Date: Wed, 26 Sep 2018 09:14:35 +0200
Message-ID: <b6c9170b-af24-3f9f-54fc-0d6f591b1067@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-25-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-25-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

>  			ret = -ENXIO;
>  			break;
> @@ -2062,6 +2085,7 @@ static u64 kvm_s390_get_initial_cpuid(void)
>  static void kvm_s390_crypto_init(struct kvm *kvm)
>  {

Only two NITs,

>  	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
> +	kvm->arch.crypto.apie = 0;

This is not necessary (default is 0)

>  	kvm_s390_set_crycb_format(kvm);
>  
>  	if (!test_kvm_facility(kvm, 76))
> @@ -2601,6 +2625,7 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>  
>  	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>  	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
> +	vcpu->arch.sie_block->eca &= ~ECA_APIE;
>  

This probably should have been moved to patch 3.

Nothing to stop this from finding its way upstream.

-- 

Thanks,

David / dhildenb
