Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47431 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728183AbgFPPOV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 11:14:21 -0400
Subject: Re: [kvm-unit-tests PATCH v9 01/12] s390x: Use PSW bits definitions
 in cstart
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
 <f160d328-694a-4476-4863-c49a1d0e5349@redhat.com>
 <13898aa9-800b-4de8-71b8-f64ee07fc793@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b2bffa74-ea11-c6f9-82fa-bb1ddfa4abfb@redhat.com>
Date: Tue, 16 Jun 2020 17:14:02 +0200
MIME-Version: 1.0
In-Reply-To: <13898aa9-800b-4de8-71b8-f64ee07fc793@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 16/06/2020 15.58, Pierre Morel wrote:
> 
> 
> On 2020-06-16 15:13, Thomas Huth wrote:
>> On 15/06/2020 11.31, Pierre Morel wrote:
>>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>>> for exceptions.
>>>
>>> Since some PSW mask definitions exist already in arch_def.h we add these
>>> definitions there.
>>> We move all PSW definitions together and protect assembler code against
>>> C syntax.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>   lib/s390x/asm/arch_def.h | 15 +++++++++++----
>>>   s390x/cstart64.S         | 15 ++++++++-------
>>>   2 files changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>> index 1b3bb0c..b5d7aca 100644
>>> --- a/lib/s390x/asm/arch_def.h
>>> +++ b/lib/s390x/asm/arch_def.h
>>> @@ -10,15 +10,21 @@
>>>   #ifndef _ASM_S390X_ARCH_DEF_H_
>>>   #define _ASM_S390X_ARCH_DEF_H_
>>>   +#define PSW_MASK_EXT            0x0100000000000000UL
>>> +#define PSW_MASK_DAT            0x0400000000000000UL
>>> +#define PSW_MASK_SHORT_PSW        0x0008000000000000UL
>>> +#define PSW_MASK_PSTATE            0x0001000000000000UL
>>> +#define PSW_MASK_BA            0x0000000080000000UL
>>> +#define PSW_MASK_EA            0x0000000100000000UL
>>> +
>>> +#define PSW_MASK_ON_EXCEPTION    (PSW_MASK_EA | PSW_MASK_BA)
>>> +
>>> +#ifndef __ASSEMBLER__
>>>   struct psw {
>>>       uint64_t    mask;
>>>       uint64_t    addr;
>>>   };
>>>   -#define PSW_MASK_EXT            0x0100000000000000UL
>>> -#define PSW_MASK_DAT            0x0400000000000000UL
>>> -#define PSW_MASK_PSTATE            0x0001000000000000UL
>>> -
>>>   #define CR0_EXTM_SCLP            0x0000000000000200UL
>>>   #define CR0_EXTM_EXTC            0x0000000000002000UL
>>>   #define CR0_EXTM_EMGC            0x0000000000004000UL
>>> @@ -297,4 +303,5 @@ static inline uint32_t get_prefix(void)
>>>       return current_prefix;
>>>   }
>>>   +#endif /* __ASSEMBLER */
>>>   #endif
>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>> index e084f13..d386f35 100644
>>> --- a/s390x/cstart64.S
>>> +++ b/s390x/cstart64.S
>>> @@ -12,6 +12,7 @@
>>>    */
>>>   #include <asm/asm-offsets.h>
>>>   #include <asm/sigp.h>
>>> +#include <asm/arch_def.h>
>>>     .section .init
>>>   @@ -198,19 +199,19 @@ svc_int:
>>>         .align    8
>>>   reset_psw:
>>> -    .quad    0x0008000180000000
>>> +    .quad    PSW_MASK_ON_EXCEPTION | PSW_MASK_SHORT_PSW
>>>   initial_psw:
>>> -    .quad    0x0000000180000000, clear_bss_start
>>> +    .quad    PSW_MASK_ON_EXCEPTION, clear_bss_start
>>>   pgm_int_psw:
>>> -    .quad    0x0000000180000000, pgm_int
>>> +    .quad    PSW_MASK_ON_EXCEPTION, pgm_int
>>>   ext_int_psw:
>>> -    .quad    0x0000000180000000, ext_int
>>> +    .quad    PSW_MASK_ON_EXCEPTION, ext_int
>>>   mcck_int_psw:
>>> -    .quad    0x0000000180000000, mcck_int
>>> +    .quad    PSW_MASK_ON_EXCEPTION, mcck_int
>>>   io_int_psw:
>>> -    .quad    0x0000000180000000, io_int
>>> +    .quad    PSW_MASK_ON_EXCEPTION, io_int
>>>   svc_int_psw:
>>> -    .quad    0x0000000180000000, svc_int
>>> +    .quad    PSW_MASK_ON_EXCEPTION, svc_int
>>>   initial_cr0:
>>>       /* enable AFP-register control, so FP regs (+BFP instr) can be
>>> used */
>>>       .quad    0x0000000000040000
>>>
>>
>> I'm afraid, by when I compile this on RHEL7, the toolchain complains:
> 
> I will try to figure out why.
> which version are you using? and which compiler?

$ as --version
GNU assembler version 2.27-43.base.el7
$ gcc --version
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)

I think the problem are the "UL" suffixes ... IIRC they are only
supported by newer versions of the binutils.

 Thomas
