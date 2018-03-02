From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 08/15] KVM: s390: interface to enable AP execution mode
Date: Fri, 2 Mar 2018 14:54:34 -0500
Message-ID: <efd62b2f-47bb-99c0-a8dc-ee88582663f0@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <532c0f98-83d0-c687-55d6-a6c5cb263360@redhat.com>
 <ef401e32-4a33-2fe6-8695-f0eff139f9db@linux.vnet.ibm.com>
 <dd63866f-cf54-a11f-8bfd-cc2f9dbae9b7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dd63866f-cf54-a11f-8bfd-cc2f9dbae9b7@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03/01/2018 04:35 AM, David Hildenbrand wrote:
> On 28.02.2018 21:39, Tony Krowiak wrote:
>> On 02/28/2018 04:44 AM, David Hildenbrand wrote:
>>> On 27.02.2018 15:28, Tony Krowiak wrote:
>>>> Introduces a new interface to enable AP interpretive
>>>> execution (IE) mode for the KVM guest. When running
>>>> with IE mode enabled, AP instructions executed on the
>>>> KVM guest will be interpreted by the firmware and
>>>> passed directly through to an AP device installed on
>>>> the system. The CPU model feature for AP must
>>>> be enabled for the KVM guest in order to enable
>>>> interpretive execution mode.
>>>>
>>>> This interface will be used in a subsequent patch
>>>> by the VFIO AP device driver.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>>>    arch/s390/include/asm/kvm-ap.h   |    2 ++
>>>>    arch/s390/include/asm/kvm_host.h |    1 +
>>>>    arch/s390/kvm/kvm-ap.c           |   27 +++++++++++++++++++++++++++
>>>>    arch/s390/kvm/kvm-s390.h         |    1 +
>>>>    4 files changed, 31 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
>>>> index 46e7c5b..6bd6bfb 100644
>>>> --- a/arch/s390/include/asm/kvm-ap.h
>>>> +++ b/arch/s390/include/asm/kvm-ap.h
>>>> @@ -51,4 +51,6 @@ struct kvm_ap_matrix {
>>>>    
>>>>    void kvm_ap_deconfigure_matrix(struct kvm *kvm);
>>>>    
>>>> +int kvm_ap_enable_ie_mode(struct kvm *kvm);
>>>> +
>>>>    #endif /* _ASM_KVM_AP */
>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>> index a4c77d3..1eebdd6 100644
>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>> @@ -186,6 +186,7 @@ struct kvm_s390_sie_block {
>>>>    #define ECA_AIV		0x00200000
>>>>    #define ECA_VX		0x00020000
>>>>    #define ECA_PROTEXCI	0x00002000
>>>> +#define ECA_APIE	0x00000008
>>>>    #define ECA_SII		0x00000001
>>>>    	__u32	eca;			/* 0x004c */
>>>>    #define ICPT_INST	0x04
>>>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>>>> index bb29045..862e54b 100644
>>>> --- a/arch/s390/kvm/kvm-ap.c
>>>> +++ b/arch/s390/kvm/kvm-ap.c
>>>> @@ -307,3 +307,30 @@ void kvm_ap_deconfigure_matrix(struct kvm *kvm)
>>>>    	kvm_ap_clear_crycb_masks(kvm);
>>>>    }
>>>>    EXPORT_SYMBOL(kvm_ap_deconfigure_matrix);
>>>> +
>>>> +/**
>>>> + * kvm_ap_enable_ie_mode
>>>> + *
>>>> + * Enable interpretrive execution of AP instructions for the guest. When
>>>> + * enabled, AP instructions executed on the guest will be interpreted and
>>>> + * passed through to an AP installed on the host system.
>>>> + *
>>>> + * Returns 0 if interpretrive execution is enabled. Returns -EOPNOTSUPP
>>>> + * if AP facilities are not installed for the guest.
>>>> + *
>>>> + * @kvm: the guest's kvm structure
>>>> + */
>>>> +int kvm_ap_enable_ie_mode(struct kvm *kvm)
>>>> +{
>>>> +	int i;
>>>> +	struct kvm_vcpu *vcpu;
>>>> +
>>>> +	if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>>>> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(kvm_ap_enable_ie_mode);
>>>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>>>> index 1b5621f..3142541 100644
>>>> --- a/arch/s390/kvm/kvm-s390.h
>>>> +++ b/arch/s390/kvm/kvm-s390.h
>>>> @@ -18,6 +18,7 @@
>>>>    #include <asm/facility.h>
>>>>    #include <asm/processor.h>
>>>>    #include <asm/sclp.h>
>>>> +#include <asm/ap.h>
>>>>    
>>>>    /* Transactional Memory Execution related macros */
>>>>    #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & ECB_TE))
>>>>
>>> And also, what about hot-plugged CPUs?
>> I haven't considered that, do you have any suggestions?
> You should handle the KVM_S390_VM_CPU_FEAT_AP feature instead during
> kvm_arch_vcpu_setup(), independent of any configured AP devices.
>
> This avoids the races I mentioned in regards to this series and also
> will handle hotplugged CPUs properly.
>
> If KVM_S390_VM_CPU_FEAT_AP is configured for a guest -> each CPU sets
> ECA_APIE during kvm_arch_vcpu_setup().
We talked about this in a couple of other patches, but I am on
board with this. To make things clearer, Should we rename
the feature to KVM_S390_VM_CPU_FEAT_APIE so its purpose is more
clear?
>
>
> (In the vSIE code, simply allow to set ECA_APIE in the shadow SCB in
> case KVM_S390_VM_CPU_FEAT_AP is enabled)
>
