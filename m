Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730286AbgFHP2X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 11:28:23 -0400
Subject: Re: [kvm-unit-tests PATCH v8 01/12] s390x: Use PSW bits definitions
 in cstart
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-2-git-send-email-pmorel@linux.ibm.com>
 <59f3dda9-6cd1-a3b4-5265-1a9fb2ff51ed@redhat.com>
 <e03cb81c-30cc-7cbc-c3a8-cc863a5d0be1@linux.ibm.com>
 <1e51b893-dc1e-1740-f286-ec00195d6a7f@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <d94b6f43-2250-17ee-e146-1347c0350294@linux.ibm.com>
Date: Mon, 8 Jun 2020 17:28:15 +0200
MIME-Version: 1.0
In-Reply-To: <1e51b893-dc1e-1740-f286-ec00195d6a7f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-08 16:52, Thomas Huth wrote:
> On 08/06/2020 16.33, Pierre Morel wrote:
>>
>>
>> On 2020-06-08 10:43, Thomas Huth wrote:
>>> On 08/06/2020 10.12, Pierre Morel wrote:
>>>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>>>> for exceptions.
>>>>
>>>> Since some PSW mask definitions exist already in arch_def.h we add these
>>>> definitions there.
>>>> We move all PSW definitions together and protect assembler code against
>>>> C syntax.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>    lib/s390x/asm/arch_def.h | 15 +++++++++++----
>>>>    s390x/cstart64.S         | 15 ++++++++-------
>>>>    2 files changed, 19 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>>> index 1b3bb0c..5388114 100644
>>>> --- a/lib/s390x/asm/arch_def.h
>>>> +++ b/lib/s390x/asm/arch_def.h
>>>> @@ -10,15 +10,21 @@
>>>>    #ifndef _ASM_S390X_ARCH_DEF_H_
>>>>    #define _ASM_S390X_ARCH_DEF_H_
>>>>    +#define PSW_MASK_EXT            0x0100000000000000UL
>>>> +#define PSW_MASK_DAT            0x0400000000000000UL
>>>> +#define PSW_MASK_SHORT_PSW        0x0008000000000000UL
>>>> +#define PSW_MASK_PSTATE            0x0001000000000000UL
>>>> +#define PSW_MASK_BA            0x0000000080000000UL
>>>> +#define PSW_MASK_EA            0x0000000100000000UL
>>>> +
>>>> +#define PSW_EXCEPTION_MASK    (PSW_MASK_EA | PSW_MASK_BA)
>>>
>>> PSW_EXCEPTION_MASK sounds a little bit unfortunate - that term rather
>>> reminds me of something that disables some interrupts
>>> ... in case you
>>> respin, maybe rather use something like "PSW_EXC_ADDR_MODE" ?
>>
>> EXCEPTIONS_PSW_MASK ?
> 
> I think it is the _MASK suffix that mainly bugs me here, since this is
> not a define that you normally use for extracting the bits from a PSW...
> so EXCEPTIONS_PSW without _MASK would be fine for me... but as long as
> I'm the only one who has a strange feeling about this, it's also ok if
> you keep the current name.
> 
>   Thomas
> 

The _MASK is because it is applied to the psw.mask and not to the 
psw.addr part.

But I agree that the name is not good, to keep the naming convention, 
may be it should be:

PSW_MASK_ON_EXCEPTION

beginning with PSW_MASK_ like all other psw.mask definitions and 
ON_EXCEPTION clearly define when it is used.

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
