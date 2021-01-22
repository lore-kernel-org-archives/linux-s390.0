Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbhAVPoO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 10:44:14 -0500
Subject: Re: [kvm-unit-tests PATCH v5 2/3] s390x: define UV compatible I/O
 allocation
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
 <1611322060-1972-3-git-send-email-pmorel@linux.ibm.com>
 <0393eaa1-e3e8-21c4-4e8f-b8dc2cc82983@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <29d73d90-edd8-f482-d020-100b49c97fbf@linux.ibm.com>
Date: Fri, 22 Jan 2021 16:43:25 +0100
MIME-Version: 1.0
In-Reply-To: <0393eaa1-e3e8-21c4-4e8f-b8dc2cc82983@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/22/21 3:12 PM, Thomas Huth wrote:
> On 22/01/2021 14.27, Pierre Morel wrote:
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
>>   lib/s390x/malloc_io.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/malloc_io.h | 45 +++++++++++++++++++++++++++
>>   s390x/Makefile        |  1 +
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 lib/s390x/malloc_io.c
>>   create mode 100644 lib/s390x/malloc_io.h
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
