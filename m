Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730333AbgFHQFP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 12:05:15 -0400
Subject: Re: [kvm-unit-tests PATCH v8 03/12] s390x: saving regs for interrupts
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-4-git-send-email-pmorel@linux.ibm.com>
 <d4f1167c-5e44-f69c-8aac-f792a2a50ca7@redhat.com>
 <cde77b21-7fbb-bd09-bd3d-f77c5bd2a088@linux.ibm.com>
 <dc936814-13b3-c310-f0b1-1bec47c042b2@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <489ec992-0fa9-031e-746b-f213daecf0c1@linux.ibm.com>
Date: Mon, 8 Jun 2020 18:03:05 +0200
MIME-Version: 1.0
In-Reply-To: <dc936814-13b3-c310-f0b1-1bec47c042b2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-08 17:29, Thomas Huth wrote:
> On 08/06/2020 16.24, Pierre Morel wrote:
>>
>>
>> On 2020-06-08 11:05, Thomas Huth wrote:
>>> On 08/06/2020 10.12, Pierre Morel wrote:
>>>> If we use multiple source of interrupts, for example, using SCLP
>>>> console to print information while using I/O interrupts, we need
>>>> to have a re-entrant register saving interruption handling.
>>>>
>>>> Instead of saving at a static memory address, let's save the base
>>>> registers, the floating point registers and the floating point
>>>> control register on the stack in case of I/O interrupts
>>>>
>>>> Note that we keep the static register saving to recover from the
>>>> RESET tests.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>    s390x/cstart64.S | 41 +++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 39 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>>> index b50c42c..a9d8223 100644
>>>> --- a/s390x/cstart64.S
>>>> +++ b/s390x/cstart64.S
>>>> @@ -119,6 +119,43 @@ memsetxc:
>>>>        lmg    %r0, %r15, GEN_LC_SW_INT_GRS
>>>>        .endm
>>>>    +/* Save registers on the stack (r15), so we can have stacked
>>>> interrupts. */
>>>> +    .macro SAVE_REGS_STACK
>>>> +    /* Allocate a stack frame for 15 general registers */
>>>> +    slgfi   %r15, 15 * 8
>>>> +    /* Store registers r0 to r14 on the stack */
>>>> +    stmg    %r0, %r14, 0(%r15)
>>>> +    /* Allocate a stack frame for 16 floating point registers */
>>>> +    /* The size of a FP register is the size of an double word */
>>>> +    slgfi   %r15, 16 * 8
>>>> +    /* Save fp register on stack: offset to SP is multiple of reg
>>>> number */
>>>> +    .irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>>>> +    std    \i, \i * 8(%r15)
>>>> +    .endr
>>>> +    /* Save fpc, but keep stack aligned on 64bits */
>>>> +    slgfi   %r15, 8
>>>> +    efpc    %r0
>>>> +    stg    %r0, 0(%r15)
>>>> +    .endm
>>>
>>> I wonder whether it would be sufficient to only save the registers here
>>> that are "volatile" according to the ELF ABI? ... that would save quite
>>> some space on the stack, I think... OTOH, the old code was also saving
>>> all registers, so maybe that's something for a separate patch later...
>>
>> I don't think so for the general registers
>> The "volatile" registers are lost during a C call, so it is the duty of
>> the caller to save them before the call, if he wants, and this is
>> possible for the programmer or the compiler to arrange that.
>>
>> For interruptions, we steal the CPU with all the registers from the
>> program without warning, the program has no possibility to save them.
>> So we must save all registers for him.
> 
> We certainly have to save the registers that are marked as "volatile" in
> the ELF ABI, no discussion. But what about the others? If we do not
> touch them in the assembler code, and just jump to a C function, the C
> function will save them before changing them, and restore the old value
> before returning. So when the interrupt is done, the registers should
> contain their original values again, shouldn't they?

Sorry, did not read correctly.
Yes you are right, saving the "volatile" registers would be enough for 
the general and the FP registers.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
