Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgFIMDL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 08:03:11 -0400
Subject: Re: [kvm-unit-tests PATCH v8 12/12] s390x: css: ssch/tsch with sense
 and interrupt
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-13-git-send-email-pmorel@linux.ibm.com>
 <bfae9aa6-5802-dd24-a59f-75291cd5f67a@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <0b1739f1-63ce-9761-9cd9-edadbb6a6070@linux.ibm.com>
Date: Tue, 9 Jun 2020 14:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <bfae9aa6-5802-dd24-a59f-75291cd5f67a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-09 10:15, Thomas Huth wrote:
> On 08/06/2020 10.13, Pierre Morel wrote:
>> After a channel is enabled we start a SENSE_ID command using
>> the SSCH instruction to recognize the control unit and device.
>>
>> This tests the success of SSCH, the I/O interruption and the TSCH
>> instructions.
>>
>> The SENSE_ID command response is tested to report 0xff inside
>> its reserved field and to report the same control unit type
>> as the cu_type kernel argument.
>>
>> Without the cu_type kernel argument, the test expects a device
>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     |  20 ++++++
>>   lib/s390x/css_lib.c |  46 ++++++++++++++
>>   s390x/css.c         | 149 +++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 214 insertions(+), 1 deletion(-)
> [...]
>> +}
>> diff --git a/s390x/css.c b/s390x/css.c
>> index 6f58d4a..79c997d 100644
>> --- a/s390x/css.c
>> +++ b/s390x/css.c
>> @@ -16,10 +16,26 @@
>>   #include <string.h>
>>   #include <interrupt.h>
>>   #include <asm/arch_def.h>
>> +#include <kernel-args.h>
>>   
>>   #include <css.h>
>>   
>> +#define DEFAULT_CU_TYPE		0x3832
>> +static unsigned long cu_type = DEFAULT_CU_TYPE;
>> +
>> +struct lowcore *lowcore = (void *)0x0;
>> +
>>   static int test_device_sid;
>> +static struct irb irb;
>> +static struct senseid senseid;
>> +
>> +static void set_io_irq_subclass_mask(uint64_t const new_mask)
>> +{
>> +	asm volatile (
>> +		"lctlg %%c6, %%c6, %[source]\n"
>> +		: /* No outputs */
>> +		: [source] "R" (new_mask));
> 
> I think the "R" constraint is wrong here - this instruction does not use
> an index register. "Q" is likely the better choice. But it might be
> easier to use the lctlg() wrapper from lib/s390x/asm/arch_def.h instead.

OK, yes I do this.

> 
> [...]
>> +
>> +	report((senseid.cu_type == cu_type),
> 
> Please drop the innermost parentheses here.
> 

OK,
Thanks,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
