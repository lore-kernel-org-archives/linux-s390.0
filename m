Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgEOHHZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 03:07:25 -0400
Subject: Re: [kvm-unit-tests PATCH v6 05/10] s390x: Library resources for CSS
 tests
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-6-git-send-email-pmorel@linux.ibm.com>
 <20200514140315.6077046b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <42beb241-8cc1-51a1-b374-3fb89968df36@linux.ibm.com>
Date: Fri, 15 May 2020 09:02:37 +0200
MIME-Version: 1.0
In-Reply-To: <20200514140315.6077046b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-05-14 14:03, Cornelia Huck wrote:
> On Fri, 24 Apr 2020 12:45:47 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> These are the include and library utilities for the css tests patch
>> series.
> 
> "Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem."
> 
> ?

Definitively better. Thanks, I will update.

> 
>>
>> Debug function can be activated by defining DEBUG_CSS before the
>> inclusion of the css.h header file.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/css_dump.c | 157 ++++++++++++++++++++++++++
>>   2 files changed, 413 insertions(+)
>>   create mode 100644 lib/s390x/css.h
>>   create mode 100644 lib/s390x/css_dump.c
> 
> (...)
> 
>> diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
>> new file mode 100644
>> index 0000000..2f33fab
>> --- /dev/null
>> +++ b/lib/s390x/css_dump.c
>> @@ -0,0 +1,157 @@
>> +/*
>> + * Channel subsystem structures dumping
>> + *
>> + * Copyright (c) 2020 IBM Corp.
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2.
>> + *
>> + * Description:
>> + * Provides the dumping functions for various structures used by subchannels:
>> + * - ORB  : Operation request block, describes the I/O operation and points to
>> + *          a CCW chain
>> + * - CCW  : Channel Command Word, describes the data and flow control
> 
> "describes the command, data, and flow control" ?

OK, thanks

> 
>> + * - IRB  : Interuption response Block, describes the result of an operation
> 
> s/operation/operation;/

? I do not understand, do you want a ";" at the end of "operation"
Isn't it a typo error?

> 
>> + *          holds a SCSW and model-dependent data.
>> + * - SCHIB: SubCHannel Information Block composed of:
> 
>> + *   - SCSW: SubChannel Status Word, status of the channel.
>> + *   - PMCW: Path Management Control Word
>> + * You need the QEMU ccw-pong device in QEMU to answer the I/O transfers.
>> + */
> 
> (...)
> 
> Otherwise, looks good.
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
