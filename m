Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbgFDHVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 03:21:21 -0400
Subject: Re: [kvm-unit-tests PATCH v7 06/12] s390x: use get_clock_ms() to
 calculate a delay in ms
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-7-git-send-email-pmorel@linux.ibm.com>
 <a490dc16-b323-5a52-2d29-f4707d89a1d6@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <abb9f3e4-f8d1-3394-0c3d-8f2a2ef30f32@linux.ibm.com>
Date: Thu, 4 Jun 2020 09:21:14 +0200
MIME-Version: 1.0
In-Reply-To: <a490dc16-b323-5a52-2d29-f4707d89a1d6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-05-26 20:16, Thomas Huth wrote:
> On 18/05/2020 18.07, Pierre Morel wrote:
>> use get_clock_ms() to calculate a delay in ms
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/asm/time.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
>> index 25c7a3c..931a119 100644
>> --- a/lib/s390x/asm/time.h
>> +++ b/lib/s390x/asm/time.h
>> @@ -23,4 +23,14 @@ static inline uint64_t get_clock_ms(void)
>>   	return (clk >> (63 - 51)) / 1000;
>>   }
>>   
>> +static inline void mdelay(unsigned long ms)
>> +{
>> +	unsigned long startclk;
>> +
>> +	startclk = get_clock_ms();
>> +	for (;;)
>> +		if (get_clock_ms() - startclk > ms)
>> +			break;
> 
> Maybe rather:
> 
>      for (;get_clock_ms() - startclk <= ms;)
> 	;
> 
> ?
> Or:
> 
>      while (get_clock_ms() - startclk <= ms)
>          ;
> ?
> 
>   Thomas
> 

Hi,

your comment made me realize I did not take care on the wrapping.
I will rework this.

Thanks,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
