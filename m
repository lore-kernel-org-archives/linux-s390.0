Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389909AbhATMmi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 07:42:38 -0500
Subject: Re: [kvm-unit-tests PATCH v3 2/3] s390x: define UV compatible I/O
 allocation
References: <1611085944-21609-1-git-send-email-pmorel@linux.ibm.com>
 <1611085944-21609-3-git-send-email-pmorel@linux.ibm.com>
 <20210120132539.236dd224@ibm-vm>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <a3ecb6af-d4b9-0f28-c574-bfaf8354b50a@linux.ibm.com>
Date: Wed, 20 Jan 2021 13:41:44 +0100
MIME-Version: 1.0
In-Reply-To: <20210120132539.236dd224@ibm-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, drjones@redhat.com, pbonzini@redhat.com



On 1/20/21 1:25 PM, Claudio Imbrenda wrote:
> On Tue, 19 Jan 2021 20:52:23 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> To centralize the memory allocation for I/O we define
>> the alloc_io_page/free_io_page functions which share the I/O
>> memory with the host in case the guest runs with
>> protected virtualization.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/malloc_io.c | 50
>> +++++++++++++++++++++++++++++++++++++++++++ lib/s390x/malloc_io.h |
>> 18 ++++++++++++++++ s390x/Makefile        |  1 +
>>   3 files changed, 69 insertions(+)
>>   create mode 100644 lib/s390x/malloc_io.c
>>   create mode 100644 lib/s390x/malloc_io.h
>>
>> diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
>> new file mode 100644
>> index 0000000..2a946e0
>> --- /dev/null
>> +++ b/lib/s390x/malloc_io.c
>> @@ -0,0 +1,50 @@
>> +/*
>> + * I/O page allocation
>> + *
>> + * Copyright (c) 2021 IBM Corp
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify
>> it
>> + * under the terms of the GNU General Public License version 2.
>> + *
>> + * Using this interface provide host access to the allocated pages in
>> + * case the guest is a secure guest.
>> + * This is needed for I/O buffers.
>> + *
>> + */
>> +#include <libcflat.h>
>> +#include <asm/page.h>
>> +#include <asm/uv.h>
>> +#include <malloc_io.h>
>> +#include <alloc_page.h>
>> +#include <asm/facility.h>
>> +
>> +void *alloc_io_page(int size)
>> +{
>> +	void *p;
>> +
>> +	assert(size <= PAGE_SIZE);
> 
> I agree with Thomas here, remove size, or use it as a page count or
> page order.
> 
>> +	p = alloc_pages_flags(1, AREA_DMA31);
> 
> you are allocating 2 pages here...

humm, yes, forgot to change this as I changed to your interface.

Thanks for the reviewing,
Pierre



-- 
Pierre Morel
IBM Lab Boeblingen
