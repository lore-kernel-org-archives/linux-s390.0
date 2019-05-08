Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v8 1/4] s390: ap: kvm: add PQAP interception for AQIC
References: <1556818451-1806-1-git-send-email-pmorel@linux.ibm.com>
 <1556818451-1806-2-git-send-email-pmorel@linux.ibm.com>
 <ab120d0f-2eb4-a95c-503b-edf6de283519@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 8 May 2019 18:07:50 +0200
MIME-Version: 1.0
In-Reply-To: <ab120d0f-2eb4-a95c-503b-edf6de283519@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b946b5ee-26d6-08fa-c0de-1d8c841b3a03@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/05/2019 17:48, Tony Krowiak wrote:
> On 5/2/19 1:34 PM, Pierre Morel wrote:
>> We prepare the interception of the PQAP/AQIC instruction for
>> the case the AQIC facility is enabled in the guest.
>>
>> First of all we do not want to change existing behavior when
>> intercepting AP instructions without the SIE allowing the guest
>> to use AP instructions.
>>
>> In this patch we only handle the AQIC interception allowed by
>> facility 65 which will be enabled when the complete interception
>> infrastructure will be present.
>>
>> We add a callback inside the KVM arch structure for s390 for
>> a VFIO driver to handle a specific response to the PQAP
>> instruction with the AQIC command and only this command.
>>
>> But we want to be able to return a correct answer to the guest
>> even there is no VFIO AP driver in the kernel.
>> Therefor, we inject the correct exceptions from inside KVM for the
>> case the callback is not initialized, which happens when the vfio_ap
>> driver is not loaded.
>>
>> We do consider the responsability of the driver to always initialize
>> the PQAP callback if it defines queues by initializing the CRYCB for
>> a guest.
>> If the callback has been setup we call it.
>> If not we setup an answer considering that no queue is available
>> for the guest when no callback has been setup.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h      |  7 +++
>>   arch/s390/kvm/priv.c                  | 86 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   3 files changed, 95 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 9fff9ab..af10a11 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -18,6 +18,7 @@
>>   #include <linux/kvm_host.h>
>>   #include <linux/kvm.h>
>>   #include <linux/seqlock.h>
>> +#include <linux/module.h>
>>   #include <asm/debug.h>
>>   #include <asm/cpu.h>
>>   #include <asm/fpu/api.h>
>> @@ -722,8 +723,14 @@ struct kvm_s390_cpu_model {
>>       unsigned short ibc;
>>   };
>> +struct kvm_s390_module_hook {
>> +    int (*hook)(struct kvm_vcpu *vcpu);
>> +    struct module *owner;
>> +};
>> +
>>   struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>> +    struct kvm_s390_module_hook *pqap_hook;
>>       __u32 crycbd;
>>       __u8 aes_kw;
>>       __u8 dea_kw;
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 8679bd7..a9be84f 100644
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
>> @@ -592,6 +593,89 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>       }
>>   }
>> +/*
>> + * handle_pqap: Handling pqap interception
>> + * @vcpu: the vcpu having issue the pqap instruction
>> + *
>> + * We now support PQAP/AQIC instructions and we need to correctly
>> + * answer the guest even if no dedicated driver's hook is available.
>> + *
>> + * The intercepting code calls a dedicated callback for this instruction
>> + * if a driver did register one in the CRYPTO satellite of the
>> + * SIE block.
>> + *
>> + * If no callback is available, the queues are not available, return 
>> this
>> + * response code to the caller and set CC to 3.
>> + * Else return the response code returned by the callback.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +    struct ap_queue_status status = {};
>> +    unsigned long reg0;
>> +    int ret;
>> +    uint8_t fc;
>> +
>> +    /* Verify that the AP instruction are available */
>> +    if (!ap_instructions_available())
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the guest is allowed to use AP instructions */
>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>> +        return -EOPNOTSUPP;
>> +    /*
>> +     * The only possibly intercepted functions when AP instructions are
>> +     * available for the guest are AQIC and TAPQ with the t bit set
>> +     * since we do not set IC.3 (FIII) we currently will only intercept
>> +     * the AQIC function code.
>> +     */
>> +    reg0 = vcpu->run->s.regs.gprs[0];
>> +    fc = reg0 >> 24;
> 
> Should you also mask off bits 0-32 in case they might not be zeroes?

Yes I will.

> 
> Other than this, r-b
> 

Thanks,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
