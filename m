Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343702AbhA0MlI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 07:41:08 -0500
Subject: Re: [kvm-unit-tests PATCH v5 2/3] s390x: define UV compatible I/O
 allocation
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
 <1611322060-1972-3-git-send-email-pmorel@linux.ibm.com>
 <20210127114727.1be31923.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <feb132f9-3459-4db5-c79f-ed311ba167c7@linux.ibm.com>
Date: Wed, 27 Jan 2021 13:40:19 +0100
MIME-Version: 1.0
In-Reply-To: <20210127114727.1be31923.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/27/21 11:47 AM, Cornelia Huck wrote:
> On Fri, 22 Jan 2021 14:27:39 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> To centralize the memory allocation for I/O we define
>> the alloc_io_mem/free_io_mem functions which share the I/O
>> memory with the host in case the guest runs with
>> protected virtualization.
>>
>> These functions allocate on a page integral granularity to
>> ensure a dedicated sharing of the allocated objects.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/malloc_io.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/malloc_io.h | 45 +++++++++++++++++++++++++++
>>   s390x/Makefile        |  1 +
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 lib/s390x/malloc_io.c
>>   create mode 100644 lib/s390x/malloc_io.h
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
