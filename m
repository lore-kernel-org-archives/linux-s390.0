Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730068AbhAUNtc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 08:49:32 -0500
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-3-git-send-email-pmorel@linux.ibm.com>
 <6c232520-dbd1-80e4-e3a3-949964df7403@linux.ibm.com>
 <3bce47db-c58c-6a2e-be72-9953f16a2dd4@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v4 2/3] s390x: define UV compatible I/O
 allocation
Message-ID: <75d5f645-cbfb-0a39-54ff-c61c67ed6355@linux.ibm.com>
Date: Thu, 21 Jan 2021 14:48:44 +0100
MIME-Version: 1.0
In-Reply-To: <3bce47db-c58c-6a2e-be72-9953f16a2dd4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

On 1/21/21 2:02 PM, Pierre Morel wrote:
> 
> 
> On 1/21/21 10:46 AM, Janosch Frank wrote:
>> On 1/21/21 10:13 AM, Pierre Morel wrote:
>>> To centralize the memory allocation for I/O we define
>>> the alloc_io_page/free_io_page functions which share the I/O
>>> memory with the host in case the guest runs with
>>> protected virtualization.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   MAINTAINERS           |  1 +
>>>   lib/s390x/malloc_io.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>>>   lib/s390x/malloc_io.h | 45 ++++++++++++++++++++++++++++
>>>   s390x/Makefile        |  1 +
>>>   4 files changed, 117 insertions(+)
>>>   create mode 100644 lib/s390x/malloc_io.c
>>>   create mode 100644 lib/s390x/malloc_io.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 54124f6..89cb01e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -82,6 +82,7 @@ M: Thomas Huth <thuth@redhat.com>
>>>   M: David Hildenbrand <david@redhat.com>
>>>   M: Janosch Frank <frankja@linux.ibm.com>
>>>   R: Cornelia Huck <cohuck@redhat.com>
>>> +R: Pierre Morel <pmorel@linux.ibm.com>
>>
>> If you're ok with the amount of mails you'll get then go ahead.
>> But I think maintainer file changes should always be in a separate patch.
>>
>>>   L: kvm@vger.kernel.org
>>>   L: linux-s390@vger.kernel.org
>>>   F: s390x/*
>>> diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
>>> new file mode 100644
>>> index 0000000..bfe8c6a
>>> --- /dev/null
>>> +++ b/lib/s390x/malloc_io.c
>>> @@ -0,0 +1,70 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>
>> I think we wanted to use:
> 
> @Janosch , @Thomas
> 
>> /* SPDX-License-Identifier: GPL-2.0-or-later */
> 
> or
> 
> // SPDX-License-Identifier: GPL-2.0-only
> 
> later or only ?
> 
> /* or // ?
> 
> 
> If both are OK, I will take the Janosch proposition which is in use in 
> vm.[ch] and ignore the Linux checkpatch warning.
> 
> Just to : Why are you people not using the Linux style code completely 
> instead of making new exceptions.
> 
> i.e. SPDX license and MAINTAINERS
> 

s390 also has /* */ style SPDX and GPL2.0+ statements in the kernel...

Since KUT has way less developers the style rules aren't as strict and
currently I see that as an advantage. Following checkpatch down the
cliff is a bad idea in the kernel and for unit tests. It's most often
correct, but not always.
