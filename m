From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 07/22] KVM: s390: refactor crypto initialization
Date: Tue, 21 Aug 2018 09:29:08 -0400
Message-ID: <0527e2d7-503d-ca76-d373-e5fffcc2a889@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1ba9032d-963a-6ce1-0d10-11bebbaa315f@redhat.com>
 <9c44d7b2-792a-192d-83be-1fd636a2cd2f@linux.ibm.com>
 <4b3f91be-48ef-ba68-22ba-50088e5d3509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b3f91be-48ef-ba68-22ba-50088e5d3509@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/20/2018 04:41 PM, David Hildenbrand wrote:
>>>> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>>>> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>>>>    
>>>> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>>> +	/* If MSAX3 is installed on the guest, set up protected key support */
>>>> +	if (test_kvm_facility(vcpu->kvm, 76)) {
>>>> +		if (vcpu->kvm->arch.crypto.aes_kw)
>>>> +			vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>>>> +		if (vcpu->kvm->arch.crypto.dea_kw)
>>>> +			vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>>>> +	}
>>> As the feature can never change, and aes_kw/dea_kw are only set to 1 in
>>> case we have test_kvm_facility(vcpu->kvm, 76), this change is not needed.
>>>
>>> I think this function can be pretty much left alone. Just add the
>>> KVM_S390_VM_CPU_FEAT_AP handling.
>> I disagree, what about the case where the KVM_S390_VM_CPU_FEAT_AP is
>> configured for the guest but the MSAX3 facility (76) is not?
> Then aes_kw/dea_kw can never be set.
>
> kvm_s390_vm_set_crypto() and kvm_s390_crypto_init() correctly test for
> facility 76.
>
> Or am I missing a case?

I stand corrected, you are right. I'll remove the test.

>
>>>>    }
>>>>    
>>>>    void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>>>>
>
