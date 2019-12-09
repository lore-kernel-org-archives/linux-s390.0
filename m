Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfLIQou (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:44:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GQrxt108354
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 11:44:49 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wskq6s9jq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 11:44:49 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Dec 2019 16:44:46 -0000
Subject: Re: [kvm-unit-tests PATCH v3 3/9] s390: interrupt registration
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-4-git-send-email-pmorel@linux.ibm.com>
 <864d5ba5-7b06-4880-3d0c-131ef76b8488@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 9 Dec 2019 17:44:41 +0100
MIME-Version: 1.0
In-Reply-To: <864d5ba5-7b06-4880-3d0c-131ef76b8488@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b1e378bb-19ab-c2ba-e975-352ff6d3e019@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com



On 2019-12-09 12:48, David Hildenbrand wrote:
> On 06.12.19 17:26, Pierre Morel wrote:
>> Define two functions to register and to unregister a call back for IO
>> Interrupt handling.
>>
>> Per default we keep the old behavior, so does a successful unregister
>> of the callback.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>>   lib/s390x/interrupt.h |  7 +++++++
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>   create mode 100644 lib/s390x/interrupt.h
>>
>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>> index 3e07867..e0eae4d 100644
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
>>   
>>   static bool pgm_int_expected;
>>   static bool ext_int_expected;
>> @@ -140,12 +140,33 @@ void handle_mcck_int(void)
>>   		     lc->mcck_old_psw.addr);
>>   }
>>   
>> +static void (*io_int_func)(void);
>> +
>>   void handle_io_int(void)
>>   {
>> +	if (*io_int_func)
>> +		return (*io_int_func)();
>> +
>>   	report_abort("Unexpected io interrupt: at %#lx",
>>   		     lc->io_old_psw.addr);
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
>> +
>>   void handle_svc_int(void)
>>   {
>>   	report_abort("Unexpected supervisor call interrupt: at %#lx",
>> diff --git a/lib/s390x/interrupt.h b/lib/s390x/interrupt.h
>> new file mode 100644
>> index 0000000..e945ef7
>> --- /dev/null
>> +++ b/lib/s390x/interrupt.h
>> @@ -0,0 +1,7 @@
>> +#ifndef __INTERRUPT_H
>> +#include <asm/interrupt.h>
>> +
>> +int register_io_int_func(void (*f)(void));
>> +int unregister_io_int_func(void (*f)(void));
>> +
>> +#endif
>>
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
