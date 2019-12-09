Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfLIQoc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:44:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GMKrk029901
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 11:44:31 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrt1yda09-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 11:44:30 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Dec 2019 16:44:28 -0000
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-5-git-send-email-pmorel@linux.ibm.com>
 <fc6e103d-100b-151b-4a6e-359f3103d5fa@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 9 Dec 2019 17:44:23 +0100
MIME-Version: 1.0
In-Reply-To: <fc6e103d-100b-151b-4a6e-359f3103d5fa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <59e71889-66e5-306b-5a63-82fada3ef7ec@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2019-12-09 12:42, Thomas Huth wrote:
> On 06/12/2019 17.26, Pierre Morel wrote:
>> To serve multiple times, the function get_clock_ms() is moved
>> from intercept.c test to the new file asm/time.h.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>   lib/s390x/asm/time.h | 27 +++++++++++++++++++++++++++
>>   s390x/intercept.c    | 11 +----------
>>   2 files changed, 28 insertions(+), 10 deletions(-)
>>   create mode 100644 lib/s390x/asm/time.h
>>
>> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
>> new file mode 100644
>> index 0000000..b07ccbd
>> --- /dev/null
>> +++ b/lib/s390x/asm/time.h
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Clock utilities for s390
>> + *
>> + * Authors:
>> + *  Thomas Huth <thuth@redhat.com>
>> + *
>> + * Copied from the s390/intercept test by:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2.
>> + */
>> +#ifndef _ASM_S390X_TIME_H_
>> +#define _ASM_S390X_TIME_H_
>> +
>> +static inline uint64_t get_clock_ms(void)
>> +{
>> +	uint64_t clk;
>> +
>> +	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
>> +
>> +	/* Bit 51 is incrememented each microsecond */
>> +	return (clk >> (63 - 51)) / 1000;
>> +}
>> +
>> +
> 
> Please remove one of the two empty lines.

yes, of course, thanks.

> 
> With that cosmetic nit fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
