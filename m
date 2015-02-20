From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/15] cpu-model/s390: Add KVM VM
 attribute interface routines
Date: Fri, 20 Feb 2015 17:59:14 +0100
Message-ID: <54E767E2.4060100@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>	<1424183053-4310-10-git-send-email-mimu@linux.vnet.ibm.com>	<54E73DB8.20902@suse.de> <20150220161805.3d04097a@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220161805.3d04097a@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>



On 20.02.15 16:18, Michael Mueller wrote:
> On Fri, 20 Feb 2015 14:59:20 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>>> +typedef struct S390ProcessorProps {
>>> +    uint64_t cpuid;
>>> +    uint16_t ibc;
>>> +    uint8_t  pad[6];
>>> +    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
>>> +} S390ProcessorProps;
>>> +
>>> +typedef struct S390MachineProps {
>>> +    uint64_t cpuid;
>>> +    uint32_t ibc_range;
>>> +    uint8_t  pad[4];
>>> +    uint64_t fac_list_mask[S390_ARCH_FAC_LIST_SIZE_UINT64];
>>> +    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
>>> +} S390MachineProps;  
>>
>> What are those structs there for? To convert between a kvm facing
>> interface to an internal interface?
> 
> Yes, that's their current use, but if the interface structs: 
> 
> +struct kvm_s390_vm_cpu_processor {
> +       __u64 cpuid;
> +       __u16 ibc;
> +       __u8  pad[6];
> +       __u64 fac_list[256];
> +};
> +
> +/* kvm S390 machine related attributes are r/o */
> +#define KVM_S390_VM_CPU_MACHINE                1
> +struct kvm_s390_vm_cpu_machine {
> +       __u64 cpuid;
> +       __u32 ibc_range;
> +       __u8  pad[4];
> +       __u64 fac_mask[256];
> +       __u64 fac_list[256];
> +};
> 
> are visible here, I'll reuse them... But stop, that will not work in the 
> --disable-kvm case... I need them!

I meant it the other way around - do KVM specific patching of the cpu
types from kvm.c.

But please give a nutshell explanation on what exactly you're patching
at all here.


Alex
