Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729341AbgF3QNX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 12:13:23 -0400
Subject: Re: [kvm-unit-tests PATCH v9 06/12] s390x: clock and delays
 caluculations
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-7-git-send-email-pmorel@linux.ibm.com>
 <7659047a-a0f9-b959-c286-b150477d15ab@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ef49bb41-6089-8590-3697-25b1cb0d6e47@linux.ibm.com>
Date: Tue, 30 Jun 2020 18:13:15 +0200
MIME-Version: 1.0
In-Reply-To: <7659047a-a0f9-b959-c286-b150477d15ab@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-06-22 11:09, Janosch Frank wrote:
> On 6/15/20 11:31 AM, Pierre Morel wrote:
>> The hardware gives us a good definition of the microsecond,
>> let's keep this information and let the routine accessing
>> the hardware keep all the information and return microseconds.
>>
>> Calculate delays in microseconds and take care about wrapping
>> around zero.
>>
>> Define values with macros and use inlines to keep the
>> milliseconds interface.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Small nit below.

seen, I move it up.

> 
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Thanks,
Pierre


> 
>> ---
>>   lib/s390x/asm/time.h | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
>> index 1791380..7f1d891 100644
>> --- a/lib/s390x/asm/time.h
>> +++ b/lib/s390x/asm/time.h
>> @@ -13,14 +13,39 @@
>>   #ifndef ASM_S390X_TIME_H
>>   #define ASM_S390X_TIME_H
>>   
>> -static inline uint64_t get_clock_ms(void)
>> +#define STCK_SHIFT_US	(63 - 51)
>> +#define STCK_MAX	((1UL << 52) - 1)
>> +
>> +static inline uint64_t get_clock_us(void)
>>   {
>>   	uint64_t clk;
>>   
>>   	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
>>   
>>   	/* Bit 51 is incrememented each microsecond */
>> -	return (clk >> (63 - 51)) / 1000;
>> +	return clk >> STCK_SHIFT_US;
>> +}
>> +
>> +static inline void udelay(unsigned long us)
>> +{
>> +	unsigned long startclk = get_clock_us();
>> +	unsigned long c;
>> +
>> +	do {
>> +		c = get_clock_us();
>> +		if (c < startclk)
>> +			c += STCK_MAX;
>> +	} while (c < startclk + us);
>> +}
>> +
>> +static inline void mdelay(unsigned long ms)
>> +{
>> +	udelay(ms * 1000);
>> +}
>> +
>> +static inline uint64_t get_clock_ms(void)
>> +{
>> +	return get_clock_us() / 1000;
>>   }
> 
> Why don't you put that below to the get_clock_us()?

right, better.


-- 
Pierre Morel
IBM Lab Boeblingen
