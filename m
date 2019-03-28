From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Thu, 28 Mar 2019 13:43:36 +0100
Message-ID: <1489c200-8eec-309e-f253-8dce5a6d88d1@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
 <66abb1f6-425a-df94-cc7c-f1fdec0ece9c@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <66abb1f6-425a-df94-cc7c-f1fdec0ece9c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 26/03/2019 19:57, Tony Krowiak wrote:
> On 3/22/19 10:43 AM, Pierre Morel wrote:
>> We prepare the interception of the PQAP/AQIC instruction for
>> the case the AQIC facility is enabled in the guest.
>>

...snip...

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
>> + * For PQAP AQIC and TAPQ instructions, verify privilege and 
>> specifications.
> 
> The two paragraphs above should be described via the comments embedded
> in the code and is not necessary here.
> 
>> + *
>> + * If no callback available, the queues are not available, return 
>> this to
>> + * the caller.
> 
> This implies it is specified via the return code when it is in fact
> the response code in the status word.
> 
>> + * Else return the value returned by the callback.
>> + */
> 
> Given this handler may be called for any PQAP instruction sub-function,
> I think the function doc should be more generic, providing:
> 
> * A general description of what the function does
> * A description of each input parameter
> * A description of the value returned. If the return value is a return
>    code, the possible rc values can be enumerated with a description for
>    of the reason each particular value may be returned.

Sorry, I do not understand what you want here.
Isn't it exactly what is done?

And don't you exactly say the opposite when you say that the description 
should be done by the embedded comments?


> 
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
>> +     * The only possibly intercepted instructions when AP 
>> instructions are
>> +     * available for the guest are AQIC and TAPQ with the t bit set
>> +     * since we do not set IC.3 (FIII) we currently will not intercept
>> +     * TAPQ.
>> +     * The following code will only treat AQIC function code.
>> +     */
> 
> Simplify to:
> 
> /* The only supported PQAP function is AQIC (0x03) */

OK, but then istn't obvious from reading the code ?

> 
>> +    reg0 = vcpu->run->s.regs.gprs[0];
>> +    fc = reg0 >> 24;
>> +    if (fc != 0x03) {
>> +        pr_warn("%s: Unexpected interception code 0x%02x\n",
>> +            __func__, fc);
>> +        return -EOPNOTSUPP;
>> +    }
>> +    /* All PQAP instructions are allowed for guest kernel only */
> 
> There is only one PQAP instruction with multiple sub-functions.
> /* PQAP instruction is allowed for guest kernel only */
>                          or
> /* PQAP instruction is privileged */

OK

> 
>> +    if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>> +        return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>> +    /*
>> +     * Common tests for PQAP instructions to generate a specification
>> +     * exception
>> +     */
> 
> This comment is unnecessary as the individual comments below adequately
> do the job.

OK

> 
>> +    /* Zero bits overwrite produce a specification exception */
> 
> This comment has no meaning unless you intimately know the architecture.
> The following would make more sense:
> 
>      /* Bits 41-47 must all be zeros */
> 
> It's probably not a big deal, but since we don't support PQAP(TAPQ),
> would it make more sense to make sure bits 40-47 are zeros (i.e.,
> the 't' bit is not set)?

I am not sure about this one as APFT is installed in our case.
Or do you want that we test if it is installed and test the bit 40?

We should discuss this offline because I do not find any evidence that 
we should really do this in the documentation.

> 
>> +    if (reg0 & 0x007f0000UL)
>> +        goto specification_except;
>> +    /* If APXA is not installed APQN is limited */
> 
> Wouldn't it be better to state how the APQN is limited?
> For example:
> 
>      /*
>       * If APXA is not installed, then the maximum APID is
>       * 63 (bits 48-49 of reg0 must be zero) and the maximum
>       * APQI is 15 (bits 56-59 must be zero)
>       */
OK
> 
>> +    if (!(vcpu->kvm->arch.crypto.crycbd & 0x02))
>> +        if (reg0 & 0x000030f0UL)
> 
> If APXA is not installed, then bits 48-49 and 56-59 must all be
> zeros. Shouldn't this mask be 0x0000c0f0UL?

You can better count than I do ;)
I will change this to c0f0.

...snip...
> 
> 
> 
>> +    status.response_code = 0x01;
>> +    memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));

hum,
I miss a
	kvm_s390_set_psw_cc(vcpu, 3);
here
and certainly wherever fault in the status response code are set.

Will be corrected in the next iteration.


Thanks for the comments,

regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
