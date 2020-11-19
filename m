Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbgKSJVd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 04:21:33 -0500
Subject: Re: [kvm-unit-tests PATCH 3/5] s390x: SCLP feature checking
References: <20201117154215.45855-1-frankja@linux.ibm.com>
 <20201117154215.45855-4-frankja@linux.ibm.com>
 <e9845ca1-96ac-23b8-5136-7a6916fb1b92@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <ef1aa882-64a2-6626-4ad8-a9b2e78f3cda@linux.ibm.com>
Date: Thu, 19 Nov 2020 10:21:24 +0100
MIME-Version: 1.0
In-Reply-To: <e9845ca1-96ac-23b8-5136-7a6916fb1b92@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On 11/19/20 10:15 AM, Thomas Huth wrote:
> On 17/11/2020 16.42, Janosch Frank wrote:
>> Availability of SIE is announced via a feature bit in a SCLP info CPU
>> entry. Let's add a framework that allows us to easily check for such
>> facilities.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/io.c   |  1 +
>>  lib/s390x/sclp.c | 19 +++++++++++++++++++
>>  lib/s390x/sclp.h | 15 +++++++++++++++
>>  3 files changed, 35 insertions(+)
> [...]
>> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
>> index 6620531..bcc9f4b 100644
>> --- a/lib/s390x/sclp.h
>> +++ b/lib/s390x/sclp.h
>> @@ -101,6 +101,20 @@ typedef struct CPUEntry {
>>      uint8_t reserved1;
>>  } __attribute__((packed)) CPUEntry;
>>  
>> +extern struct sclp_facilities sclp_facilities;
>> +
>> +struct sclp_facilities {
>> +	u64 has_sief2 : 1;
>> +};
>> +
>> +/*
>> + * test_bit() uses unsigned long ptrs so we give it the ptr to the
>> + * address member and offset bits by 1> + */
>> +enum sclp_cpu_feature_bit {
>> +	SCLP_CPU_FEATURE_SIEF2_BIT = 16 + 4,
>> +};
> 
> That's kind of ugly ... why don't you simply replace the CPUEntry.features[]
> array with a bitfield, similar to what the kernel does with "struct
> sclp_core_entry" ?

That's an excellent idea, will do!

> 
>  Thomas
> 
> 
