From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
Date: Mon, 24 Sep 2018 14:43:43 -0400
Message-ID: <9f227089-8135-922c-fbe0-015085767a18@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
 <09a6b9e5-e335-14cf-debd-de0f92dafd5e@redhat.com>
 <ebe81ebf-9b61-dbf6-743e-6145162cdcfb@linux.ibm.com>
 <69b5e3d3-5d44-37c0-ca10-720345852134@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <69b5e3d3-5d44-37c0-ca10-720345852134@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/24/2018 02:40 PM, David Hildenbrand wrote:
> On 24/09/2018 18:07, Tony Krowiak wrote:
>> On 09/24/2018 04:40 AM, David Hildenbrand wrote:
>>>
>>>>     /**
>>>> - * Verify that the AP instructions are available on the guest. This is
>>>> indicated
>>>> - * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
>>>> + * Verify that the AP instructions are being interpreted by firmware
>>>> for the
>>>> + * guest. This is indicated by the kvm->arch.crypto.apie flag.
>>>>      */
>>>>     static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>>>>     {
>>>> -	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
>>>> +	if (kvm->arch.crypto.apie)
>>>>     		return 0;
>>>
>>> I wonder if this check makes sense, because apie can be toggled during
>>> runtime. I guess it would be sufficient to check if the ap control block
>>> is available and apie is supported by the HW.
>>
>> I am not clear about what you are getting at here, but I'll attempt
>> to respond. There is no need to check if the AP control block (CRYCB)
>> is available as the address is set in the CRYCBD three instructions
>> above, even if AP instructions are not available. Regarding whether apie
>> is supported by the hardware, the value of vcpu->kvm->arch.crypto.apie
>> can not be set unless it is supported by the HW. In the patch (24/26)
>> that provides the VM attributes to toggle this value, it can only be
>> turned on if the AP instructions are available. I might also note that
>> the kvm_ap_validate_crypto_setup() function is called whenever one of
>> the VM crypto attributes is changed, so it makes sense that decisions
>> made in this function are based on a change to a VM crypto attribute. In
>> my first pass at changing this function, I checked
>> ap_instructions_available() here, but after considering all of the
>> above, it made sense to me to check the apie flag.
>>
> 
> I prefer ap_instructions_available(). As I said, kvm->arch.crypto.apie
> is a moving target.

Okay then.

> 
