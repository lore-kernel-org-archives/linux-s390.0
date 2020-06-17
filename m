Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgFQLF5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 07:05:57 -0400
Subject: Re: [kvm-unit-tests PATCH v9 08/12] s390x: retrieve decimal and
 hexadecimal kernel parameters
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-9-git-send-email-pmorel@linux.ibm.com>
 <20200617103748.4840b43b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <da4afb0e-2bc8-529e-0006-032cfaa8b83d@linux.ibm.com>
Date: Wed, 17 Jun 2020 13:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200617103748.4840b43b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-06-17 10:37, Cornelia Huck wrote:
> On Mon, 15 Jun 2020 11:31:57 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We often need to retrieve hexadecimal kernel parameters.
>> Let's implement a shared utility to do it.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/kernel-args.c | 60 +++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/kernel-args.h | 18 +++++++++++++
>>   s390x/Makefile          |  1 +
>>   3 files changed, 79 insertions(+)
>>   create mode 100644 lib/s390x/kernel-args.c
>>   create mode 100644 lib/s390x/kernel-args.h
>>
> 
> (...)
> 
>> diff --git a/lib/s390x/kernel-args.h b/lib/s390x/kernel-args.h
>> new file mode 100644
>> index 0000000..a88e34e
>> --- /dev/null
>> +++ b/lib/s390x/kernel-args.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Kernel argument
>> + *
>> + * Copyright (c) 2020 IBM Corp
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2.
>> + */
>> +
>> +#ifndef KERNEL_ARGS_H
>> +#define KERNEL_ARGS_H
>> +
>> +int kernel_arg(int argc, char *argv[], const char *str, unsigned long *val);
> 
> <bikeshed>get_kernel_arg()?</bikeshed>

OK, is more explicit.

> 
>> +
>> +#endif
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
