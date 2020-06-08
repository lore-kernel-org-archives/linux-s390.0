Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730267AbgFHQQ4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 12:16:56 -0400
Subject: Re: [kvm-unit-tests PATCH v8 06/12] s390x: clock and delays
 caluculations
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-7-git-send-email-pmorel@linux.ibm.com>
 <2f449a7b-2701-abcc-42b7-5b7441c10761@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <77a4005a-4164-b871-02b4-314417ff11e4@linux.ibm.com>
Date: Mon, 8 Jun 2020 18:16:49 +0200
MIME-Version: 1.0
In-Reply-To: <2f449a7b-2701-abcc-42b7-5b7441c10761@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-08 17:55, Thomas Huth wrote:
> On 08/06/2020 10.12, Pierre Morel wrote:
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
>> ---
>>   lib/s390x/asm/time.h | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
>> index 1791380..eb15941 100644
>> --- a/lib/s390x/asm/time.h
>> +++ b/lib/s390x/asm/time.h
>> @@ -13,14 +13,39 @@
>>   #ifndef ASM_S390X_TIME_H
>>   #define ASM_S390X_TIME_H
>>   
>> -static inline uint64_t get_clock_ms(void)
>> +#define STCK_SHIFT	(63 - 51)
> 
> Could you maybe rather call this STCK_SHIFT_US instead, so that it is
> clear that we refer to the microsecond bit here?
> 
>> +#define STCK_MAX	((1 << (STCK_SHIFT + 1)) - 1)
> 
> Hmm, is that really right? Shouldn't that rather be
> 
>   ((1 << (51 + 1)) - 1)
> 
> instead?

:) ooops, right.

> 
> (you want to have a max. value for the 52 bits that count the
> microseconds, not a max value for the remainder bits, do you?)
> 
>> +static inline uint64_t get_clock_us(void)
>>   {
>>   	uint64_t clk;
>>   
>>   	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
>>   
>>   	/* Bit 51 is incrememented each microsecond */
>> -	return (clk >> (63 - 51)) / 1000;
>> +	return clk >> STCK_SHIFT;
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
>> +	} while (c < (startclk + us));
> 
> You could omit the parentheses around "startclk + us" here.

OK

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
