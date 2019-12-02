Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727418AbfLBQ4F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 11:56:05 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2GlSes113681
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 11:56:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6xadp15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 11:56:03 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 2 Dec 2019 16:56:01 -0000
Subject: Re: [kvm-unit-tests PATCH v2 3/9] s390x: irq: make IRQ handler weak
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-4-git-send-email-pmorel@linux.ibm.com>
 <33be2bbd-ea3b-4a93-3ce3-9dee36a531d1@redhat.com>
 <1fdc2864-ce65-1af1-272b-0769d903dd3f@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 2 Dec 2019 17:55:56 +0100
MIME-Version: 1.0
In-Reply-To: <1fdc2864-ce65-1af1-272b-0769d903dd3f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a7968159-f161-93d5-6b24-3c484a331d68@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, cohuck@redhat.com



On 2019-12-02 11:41, Thomas Huth wrote:
> On 29/11/2019 13.01, David Hildenbrand wrote:
>> On 28.11.19 13:46, Pierre Morel wrote:
>>> Having a weak function allows the tests programm to declare its own
>>> IRQ handler.
>>> This is helpfull for I/O tests to have the I/O IRQ handler having
>>> its special work to do.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   lib/s390x/interrupt.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>>> index 3e07867..d70fde3 100644
>>> --- a/lib/s390x/interrupt.c
>>> +++ b/lib/s390x/interrupt.c
>>> @@ -140,7 +140,7 @@ void handle_mcck_int(void)
>>>   		     lc->mcck_old_psw.addr);
>>>   }
>>>   
>>> -void handle_io_int(void)
>>> +__attribute__((weak)) void handle_io_int(void)
>>>   {
>>>   	report_abort("Unexpected io interrupt: at %#lx",
>>>   		     lc->io_old_psw.addr);
>>>
>>
>> The clear alternative would be a way to register a callback function.
>> That way you can modify the callback during the tests. As long as not
>> registered, wrong I/Os can be caught easily here. @Thomas?
> 
> I don't mind too much, but I think I'd also slightly prefer a registered
> callback function here instead.
> 
>   Thomas
> 

As you like but I wonder why you prefer the complicated solution.
The kvm-unit-test is single task, if a test really need something 
complicated it can be done in the test not in the common code.

Anyway I do like you want.

-- 
Pierre Morel
IBM Lab Boeblingen
