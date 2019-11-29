Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58446 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2NEU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 08:04:20 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATD36cl142386
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 08:04:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar9mury-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 08:04:18 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 29 Nov 2019 13:04:17 -0000
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
References: <7abb4725-b814-8b43-8a4f-e0e2cf7a44f8@linux.ibm.com>
 <30DD27E7-BE6E-4986-AD69-7718E6B9A730@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 29 Nov 2019 14:04:12 +0100
MIME-Version: 1.0
In-Reply-To: <30DD27E7-BE6E-4986-AD69-7718E6B9A730@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ce7a6a0b-bf9e-cfd6-c517-3aa15ed7a771@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com



On 2019-11-28 20:48, David Hildenbrand wrote:
> 
> 
>> Am 28.11.2019 um 20:16 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>>
>> ﻿
>>> On 2019-11-28 15:36, David Hildenbrand wrote:
>>>> On 28.11.19 13:46, Pierre Morel wrote:
>>>> Let's define the PSW bits  explicitly, it will clarify their
>>>> usage.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>>>   lib/s390x/asm/arch_def.h  |  6 ++----
>>> I'm sorry, but I don't really see a reason to move these 4/5 defines to
>>> a separate header. Can you just keep them in arch_def.h and extend?
>>
>> no because arch_def.h contains C structures and inline.
> 
> (resend because the iOS Mail app does crazy html thingies)
> 
> You‘re looking for
> 
> #ifndef __ASSEMBLER__
> ...
> 
> See lib/s390x/asm/sigp.h
> 

Yes, better. :)

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
