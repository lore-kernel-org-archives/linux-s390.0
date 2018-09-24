From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
Date: Mon, 24 Sep 2018 10:40:18 +0200
Message-ID: <09a6b9e5-e335-14cf-debd-de0f92dafd5e@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>


>   /**
> - * Verify that the AP instructions are available on the guest. This is 
> indicated
> - * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
> + * Verify that the AP instructions are being interpreted by firmware 
> for the
> + * guest. This is indicated by the kvm->arch.crypto.apie flag.
>    */
>   static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>   {
> -	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
> +	if (kvm->arch.crypto.apie)
>   		return 0;

I wonder if this check makes sense, because apie can be toggled during
runtime. I guess it would be sufficient to check if the ap control block
is available and apie is supported by the HW.


-- 

Thanks,

David / dhildenb
