Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgFIHy0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 03:54:26 -0400
Subject: Re: [kvm-unit-tests PATCH v8 07/12] s390x: define function to wait
 for interrupt
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-8-git-send-email-pmorel@linux.ibm.com>
 <0005ec91-d4ac-2892-a800-76c96e7b34a0@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <c9dd11b7-ad84-ff7f-9703-d736e68ea87e@linux.ibm.com>
Date: Tue, 9 Jun 2020 09:54:14 +0200
MIME-Version: 1.0
In-Reply-To: <0005ec91-d4ac-2892-a800-76c96e7b34a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-09 07:07, Thomas Huth wrote:
> On 08/06/2020 10.12, Pierre Morel wrote:
>> Allow the program to wait for an interrupt.
>>
>> The interrupt handler is in charge to remove the WAIT bit
>> when it finished handling the interrupt.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   lib/s390x/asm/arch_def.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index 12045ff..e0ced12 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -10,9 +10,11 @@
>>   #ifndef _ASM_S390X_ARCH_DEF_H_
>>   #define _ASM_S390X_ARCH_DEF_H_
>>   
>> +#define PSW_MASK_IO			0x0200000000000000UL
>>   #define PSW_MASK_EXT			0x0100000000000000UL
>>   #define PSW_MASK_DAT			0x0400000000000000UL
>>   #define PSW_MASK_SHORT_PSW		0x0008000000000000UL
>> +#define PSW_MASK_WAIT			0x0002000000000000UL
>>   #define PSW_MASK_PSTATE			0x0001000000000000UL
>>   #define PSW_MASK_BA			0x0000000080000000UL
>>   #define PSW_MASK_EA			0x0000000100000000UL
>> @@ -253,6 +255,18 @@ static inline void load_psw_mask(uint64_t mask)
>>   		: "+r" (tmp) :  "a" (&psw) : "memory", "cc" );
>>   }
>>   
>> +static inline void wait_for_interrupt(uint64_t irq_mask)
>> +{
>> +	uint64_t psw_mask = extract_psw_mask();
>> +
>> +	load_psw_mask(psw_mask | irq_mask | PSW_MASK_WAIT);
>> +	/*
>> +	 * After being woken and having processed the interrupt, let's restore
>> +	 * the PSW mask.
>> +	 */
>> +	load_psw_mask(psw_mask);
>> +}
>> +
>>   static inline void enter_pstate(void)
>>   {
>>   	uint64_t mask;
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
