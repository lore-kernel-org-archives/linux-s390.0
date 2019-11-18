Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbfKRJEO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 04:04:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI92YV5107979
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 04:04:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2waeh83cmp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 04:04:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 18 Nov 2019 09:04:11 -0000
Subject: Re: [PATCH v1 3/4] s390x:irq: make IRQ handler weak
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-4-git-send-email-pmorel@linux.ibm.com>
 <5fc6450e-ec88-d500-7fc9-9e17e41f2dd0@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 18 Nov 2019 10:04:07 +0100
MIME-Version: 1.0
In-Reply-To: <5fc6450e-ec88-d500-7fc9-9e17e41f2dd0@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bb6d784e-cceb-98e0-b565-8ec3fc47f2e3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com


On 2019-11-15 08:12, Thomas Huth wrote:
> On 13/11/2019 13.23, Pierre Morel wrote:
>> Having a weak function allows the tests programm to declare its own IRQ
>> handler.
>> This is helpfull when developping I/O tests.
>> ---
>>   lib/s390x/interrupt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>> index 7aecfc5..0049194 100644
>> --- a/lib/s390x/interrupt.c
>> +++ b/lib/s390x/interrupt.c
>> @@ -140,7 +140,7 @@ void handle_mcck_int(sregs_t *regs)
>>   		     lc->mcck_old_psw.addr);
>>   }
>>   
>> -void handle_io_int(sregs_t *regs)
>> +__attribute__((weak)) void handle_io_int(sregs_t *regs)
>>   {
>>   	report_abort("Unexpected io interrupt: at %#lx",
>>   		     lc->io_old_psw.addr);
>>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
Thanks for the review,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
