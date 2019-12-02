Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43396 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbfLBQw4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 11:52:56 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2GmDmf091880
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 11:52:54 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wkm46sa3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 11:52:53 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 2 Dec 2019 16:52:51 -0000
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-3-git-send-email-pmorel@linux.ibm.com>
 <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
 <7daddc03-35ec-f376-c80a-a849f9e11714@linux.ibm.com>
 <3ce5d72d-ed1d-c689-a13f-6f409d085df7@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 2 Dec 2019 17:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <3ce5d72d-ed1d-c689-a13f-6f409d085df7@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2f1383bf-15f0-b2f5-96d4-a4a443f33a96@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com



On 2019-12-02 12:17, David Hildenbrand wrote:
> On 02.12.19 12:11, Janosch Frank wrote:
>> On 11/28/19 3:36 PM, David Hildenbrand wrote:
>>> On 28.11.19 13:46, Pierre Morel wrote:
>>>> Let's define the PSW bits  explicitly, it will clarify their
>>>> usage.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>>>   lib/s390x/asm/arch_def.h  |  6 ++----
>>>
>>> I'm sorry, but I don't really see a reason to move these 4/5 defines to
>>> a separate header. Can you just keep them in arch_def.h and extend?
>>>
>>> (none of your other patches touch arch_bits.h - and it is somewhat a
>>> weird name. Where to put something new: arch_def.h or arch_bits.h? I
>>> would have understood "psw.h", but even that, I don't consider necessary)
>>>
>>
>> On a related note:
>> I'd still like to split up the file soonish, maybe moving the functions
>> into a new file?
>>
>> @Thomas/David: What's your opinion on that?
> 
> Sure, as long as the file header is not longer as its actual content :D
> 

No problem for me.
What should the file header be?

-- 
Pierre Morel
IBM Lab Boeblingen
