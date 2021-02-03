Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhBCKJu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Feb 2021 05:09:50 -0500
Subject: Re: [kvm-unit-tests PATCH v1 4/5] s390x: css: SCHM tests format 0
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-5-git-send-email-pmorel@linux.ibm.com>
 <b3086f69-98fa-07c0-72c7-711c17e71c9d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <26db612d-45ea-de8b-5eed-bd2658f69aa0@linux.ibm.com>
Date: Wed, 3 Feb 2021 11:09:02 +0100
MIME-Version: 1.0
In-Reply-To: <b3086f69-98fa-07c0-72c7-711c17e71c9d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com



On 2/2/21 6:35 PM, Thomas Huth wrote:
> On 29/01/2021 15.34, Pierre Morel wrote:
...snip...
>>   static void test_schm(void)
>>   {
>> +    struct measurement_block_format0 *mb0;
>> +
>>       if (css_general_feature(CSSC_EXTENDED_MEASUREMENT_BLOCK))
>>           report_info("Extended measurement block available");
>> +
>> +    mb0 = alloc_io_mem(sizeof(struct measurement_block_format0), 0);
>> +    if (!mb0) {
>> +        report(0, "measurement_block_format0 allocation");
>> +        goto end_free;
> 
> If allocation failed, there is certainly no need to try to free it, so 

:) yes

> you can get rid of the goto and the label here and return directly 
> instead. Or maybe
> Maybe also simply use report_abort() in this case?

OK, report_abort when an allocation failed seems right.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
