Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbgDXKoX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:44:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OAWaEO124733
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2020 06:44:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmv32arh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2020 06:44:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 24 Apr 2020 11:43:32 +0100
Subject: Re: [kvm-unit-tests PATCH v5 04/10] s390x: interrupt registration
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-5-git-send-email-pmorel@linux.ibm.com>
 <c8d1081a-8e94-f28e-66e7-fe98aea31837@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 24 Apr 2020 12:44:16 +0200
MIME-Version: 1.0
In-Reply-To: <c8d1081a-8e94-f28e-66e7-fe98aea31837@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b5c02122-68a7-31e7-11e4-5f05403feb08@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-24 10:27, Janosch Frank wrote:
> On 2/20/20 1:00 PM, Pierre Morel wrote:
>> Let's make it possible to add and remove a custom io interrupt handler,
>> that can be used instead of the normal one.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/interrupt.c | 22 +++++++++++++++++++++-
>>   lib/s390x/interrupt.h |  7 +++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>   create mode 100644 lib/s390x/interrupt.h
>>
>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>> index 3a40cac..f6f0665 100644
>> --- a/lib/s390x/interrupt.c
>> +++ b/lib/s390x/interrupt.c
>> @@ -10,9 +10,9 @@
>>    * under the terms of the GNU Library General Public License version 2.
>>    */
>>   #include <libcflat.h>
>> -#include <asm/interrupt.h>
>>   #include <asm/barrier.h>
>>   #include <sclp.h>
>> +#include <interrupt.h>
> 
> Hrm
> 
>>   
>>   static bool pgm_int_expected;
>>   static bool ext_int_expected;
>> @@ -144,12 +144,32 @@ void handle_mcck_int(void)
>>   		     stap(), lc->mcck_old_psw.addr);
>>   }
>>   
>> +static void (*io_int_func)(void);
>> +
>>   void handle_io_int(void)
>>   {
>> +	if (*io_int_func)
>> +		return (*io_int_func)();
>>   	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
>>   		     stap(), lc->io_old_psw.addr);
>>   }
>>   
>> +int register_io_int_func(void (*f)(void))
>> +{
>> +	if (io_int_func)
>> +		return -1;
>> +	io_int_func = f;
>> +	return 0;
>> +}
>> +
>> +int unregister_io_int_func(void (*f)(void))
>> +{
>> +	if (io_int_func != f)
>> +		return -1;
>> +	io_int_func = NULL;
>> +	return 0;
>> +}
> 
> I'm currently working on something similar for PGMs and I see no
> additional value in two functions for this. Unregistering can be done by
> doing register_io_int_func(NULL)
> 
> This should be enough:
> 
> int register_io_int_func(void (*f)(void))
> {
> 	io_int_func = f;
> }
> 
There are several ways to do this and I really don't mind how it is done.
Since it has been reviewed by, I would like to have the others reviewers 
opinion.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
