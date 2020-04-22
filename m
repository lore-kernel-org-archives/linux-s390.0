Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgDVJJb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 05:09:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M93JbL144269
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:09:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ggxqyede-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:09:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Apr 2020 10:08:53 +0100
Subject: Re: [kvm-unit-tests PATCH v5 02/10] s390x: Use PSW bits definitions
 in cstart
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
 <aae40a5a-63a6-e802-53bb-9683d03ad57d@linux.ibm.com>
 <d4e66e9b-ed68-e7ef-4b9d-8af879e44813@redhat.com>
 <e1050532-72ee-210c-822a-f1eb91c6d388@linux.ibm.com>
 <6df50ddc-8d58-13d6-8143-471ec690c17f@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 22 Apr 2020 11:09:23 +0200
MIME-Version: 1.0
In-Reply-To: <6df50ddc-8d58-13d6-8143-471ec690c17f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8774fa37-b153-a79c-0b3d-79ffce30fbb8@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com



On 2020-04-22 11:07, David Hildenbrand wrote:
> On 22.04.20 10:59, Pierre Morel wrote:
>>
>>
>> On 2020-04-22 09:44, David Hildenbrand wrote:
>>>
>>>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>>>> index 45da523..2885a36 100644
>>>>> --- a/s390x/cstart64.S
>>>>> +++ b/s390x/cstart64.S
>>>>> @@ -12,6 +12,7 @@
>>>>>     */
>>>>>    #include <asm/asm-offsets.h>
>>>>>    #include <asm/sigp.h>
>>>>> +#include <asm/arch_def.h>
>>>>>    
>>>>>    .section .init
>>>>>    
>>>>> @@ -214,19 +215,19 @@ svc_int:
>>>>>    
>>>>>    	.align	8
>>>>>    reset_psw:
>>>>> -	.quad	0x0008000180000000
>>>>> +	.quad	PSW_EXCEPTION_MASK
>>>>
>>>> That won't work, this is a short PSW and you're removing the short
>>>> indication here. Notice the 0008 at the front.
>>
>> hum... :(
>>
>>>
>>> Good catch! Guess it would have bailed out when testing.
>>>
>>>
>>
>> Yes it does. Sorry.
> 
> No worries, I run everything through the machinery before picking
> patches up.
> 
> Feel free to resend only the 4/5 patches you want to have in first.
> 

OK, thanks, I ll do

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
