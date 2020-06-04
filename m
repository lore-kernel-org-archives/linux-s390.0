Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbgFDGtr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 02:49:47 -0400
Subject: Re: [kvm-unit-tests PATCH v7 05/12] s390x: export the clock
 get_clock_ms() utility
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-6-git-send-email-pmorel@linux.ibm.com>
 <80ccd983-df12-a6ee-239e-b367ebc9dded@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <3edefd98-f9ef-8428-34f5-370ee61f860d@linux.ibm.com>
Date: Thu, 4 Jun 2020 08:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <80ccd983-df12-a6ee-239e-b367ebc9dded@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-05-26 20:10, Thomas Huth wrote:
> On 18/05/2020 18.07, Pierre Morel wrote:
>> To serve multiple times, the function get_clock_ms() is moved
>> from intercept.c test to the new file asm/time.h.

...snip...

>> index 0000000..25c7a3c
>> --- /dev/null
>> +++ b/lib/s390x/asm/time.h
>> @@ -0,0 +1,26 @@
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
> 
> Please also remove the underscores at the beginning (and preferably also
> at the end) here.

OK,

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
