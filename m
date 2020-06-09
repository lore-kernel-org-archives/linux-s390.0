Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgFIHx4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 03:53:56 -0400
Subject: Re: [kvm-unit-tests PATCH v8 08/12] s390x: retrieve decimal and
 hexadecimal kernel parameters
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-9-git-send-email-pmorel@linux.ibm.com>
 <b013343d-d08d-43c6-1fac-f29d3070b535@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <1f7ae06a-b754-a75c-8658-8c46274fdc32@linux.ibm.com>
Date: Tue, 9 Jun 2020 09:53:50 +0200
MIME-Version: 1.0
In-Reply-To: <b013343d-d08d-43c6-1fac-f29d3070b535@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-09 07:21, Thomas Huth wrote:
> On 08/06/2020 10.12, Pierre Morel wrote:
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
> [...]
>> +int kernel_arg(int argc, char *argv[], const char *str, unsigned long *val)
>> +{
>> +	int i, ret;
>> +	char *p;
>> +
>> +	for (i = 0; i < argc; i++) {
>> +		ret = strncmp(argv[i], str, strlen(str));
>> +		if (ret)
>> +			continue;
>> +		p = strchr(argv[i], '=');
>> +		if (!p)
>> +			return -1;
>> +		p = strchr(p, 'x');
>> +		if (!p)
>> +			*val = atol(p + 1);
> 
> If p is NULL, then you call atol(NULL + 1) ... I think you need another
> temporary variable here instead to hold the new pointer / NULL value?


grrrr, clearly!

> 
>   Thomas
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
