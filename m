Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgDVJRp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 05:17:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M95JDE091205
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:17:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gcs5cy63-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:17:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Apr 2020 10:17:36 +0100
Subject: Re: [kvm-unit-tests PATCH v5 00/10] s390x: Testing the Channel
 Subsystem I/O
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <028ece05-1429-7761-cf4e-6fabc34e6aa0@linux.ibm.com>
 <4a5f0636-cd73-164a-8c7a-ca5679f01e56@redhat.com>
 <2c30fd52-876d-91b0-9a69-363efabdb86e@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 22 Apr 2020 11:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <2c30fd52-876d-91b0-9a69-363efabdb86e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <57fae80f-e298-6763-9f1d-b6f7f92681ed@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com



On 2020-04-22 09:43, Janosch Frank wrote:
> On 4/21/20 6:18 PM, David Hildenbrand wrote:
>> On 21.04.20 18:13, Pierre Morel wrote:
>>>
>>>
>>> On 2020-02-20 13:00, Pierre Morel wrote:
>>>
>>> ...snip...
>>>
>>>>
>>>>
>>>> Pierre Morel (10):
>>>>     s390x: saving regs for interrupts
>>>>     s390x: Use PSW bits definitions in cstart
>>>>     s390x: cr0: adding AFP-register control bit
>>>>     s390x: export the clock get_clock_ms() utility
>>>
>>> Please can you consider applying these 4 patches only.
>>> I will send some changes I made for the patches on css tests.
>>>
>>
>> The first one requires a little more brain power - can anybody at IBM
>> help reviewing that?
>>
> 
> I'll try to understand it :)
> 
> But I think we need a new series anyway.
> @Pierre: You told me, that you removed delay() and this series still has
> it. With the changes needed to the second patch and the delay change we
> need all information to make decisions, so a new version of the series
> would make sense.
> 
> 

Yes, this is clear, the next series will have some modifications for the 
css part.
Also I will send two series, first the general patches with bug fixes 
and comments and in a separate series the css specific patches.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
