From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
Date: Mon, 18 Feb 2019 19:29:10 +0100
Message-ID: <ee84fc90-e158-9c36-b56f-67fe7777f683@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
 <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/02/2019 23:02, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> This patch adds interception code for the PQAP instructions,
>> and a callback inside the KVM arch structure for s390.
>>
>> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ
>> instructions, the driver will initialize the callback inside
>> the kvm_arch structure to be called when the interception of a
>> PQAP instruction occurs.
>>
>> If the callback is not initialized, the code still returns
>> -EOPNOTSUPP to let userland handle the instruction as it used to.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  1 +
>>   arch/s390/kvm/priv.c             | 50 
>> ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index c5f5156..49cc8b0 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -719,6 +719,7 @@ struct kvm_s390_cpu_model {
>>   struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>> +    int (*pqap_hook)(struct kvm_vcpu *vcpu);
>>       __u32 crycbd;
>>       __u8 aes_kw;
>>       __u8 dea_kw;
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 8679bd7..72fdc21 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -27,6 +27,7 @@
>>   #include <asm/io.h>
>>   #include <asm/ptrace.h>
>>   #include <asm/sclp.h>
>> +#include <asm/ap.h>
>>   #include "gaccess.h"
>>   #include "kvm-s390.h"
>>   #include "trace.h"
>> @@ -592,6 +593,53 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>       }
>>   }
>> +/*
>> + * handle_pqap: Handling pqap interception
>> + * @vcpu: the vcpu having issue the pqap instruction
>> + *
>> + * This callback only handles PQAP/AQIC instruction and
>> + * calls a dedicated callback for this instruction if
>> + * a driver did register one in the CRYPTO satellite of the
>> + * SIE block.
>> + *
>> + * Do not change the behavior if, return -EOPNOTSUPP if:
>> + * - the hook is not used do not change the behavior.
>> + * - AP instructions are not available or not available to the guest
>> + * - the instruction is not PQAP with function code indicating
>> + *   AQIC do not change the previous behavior.
>> + *
>> + * For PQAP/AQIC instruction, verify privilege and specifications
>> + *
>> + * return the value returned by the callback.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +    uint8_t fc;
>> +
>> +    /* Verify that the hook callback is registered */
>> +    if (!vcpu->kvm->arch.crypto.pqap_hook)
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the AP instruction are available */
>> +    if (!ap_instructions_available())
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the guest is allowed to use AP instructions */
>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the function code is AQIC */
>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>> +    if (fc != 0x03)
>> +        return -EOPNOTSUPP;
> 
> This does not belong here. Function code 3 is one of 7 function codes
> that can be sent with the PQAP instruction. This belongs in the PQAP
> hook code.

On one hand, effectively I would prefer to put the code in the VFIO 
driver code.
On the other hand, doing this would lead to export the code for 
test_kvm_facility() and kvm_s390_inject_program_int() from the kvm-s390.h

I choose not to export these functions from the KVM code.

Would like opinion from KVM maintainers?

> 
>> +
>> +    /* PQAP instructions are allowed for guest kernel only */
>> +    if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>> +        return kvm_s390_inject_program_intkvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>> +    /* AQIC instruction is allowed only if facility 65 is available */
>> +    if (!test_kvm_facility(vcpu->kvm, 65))
>> +        return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +    /* All right, call the callback */
>> +    return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
>> +}
>> +
>>   static int handle_stfl(struct kvm_vcpu *vcpu)
>>   {
>>       int rc;
>> @@ -878,6 +926,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>>           return handle_sthyi(vcpu);
>>       case 0x7d:
>>           return handle_stsi(vcpu);
>> +    case 0xaf:
>> +        return handle_pqap(vcpu);
>>       case 0xb1:
>>           return handle_stfl(vcpu);
>>       case 0xb2:
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
