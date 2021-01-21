Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729542AbhAUNoo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 08:44:44 -0500
Subject: Re: [kvm-unit-tests PATCH v4 2/3] s390x: define UV compatible I/O
 allocation
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-3-git-send-email-pmorel@linux.ibm.com>
 <6c232520-dbd1-80e4-e3a3-949964df7403@linux.ibm.com>
 <3bce47db-c58c-6a2e-be72-9953f16a2dd4@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0a46a299-c52d-2c7f-bb38-8d58afe053e0@redhat.com>
Date: Thu, 21 Jan 2021 14:43:03 +0100
MIME-Version: 1.0
In-Reply-To: <3bce47db-c58c-6a2e-be72-9953f16a2dd4@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

On 21/01/2021 14.02, Pierre Morel wrote:
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
>>>   MAINTAINERS           |  1 +
>>>   lib/s390x/malloc_io.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>>>   lib/s390x/malloc_io.h | 45 ++++++++++++++++++++++++++++
>>>   s390x/Makefile        |  1 +
>>>   4 files changed, 117 insertions(+)
>>>   create mode 100644 lib/s390x/malloc_io.c
>>>   create mode 100644 lib/s390x/malloc_io.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 54124f6..89cb01e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -82,6 +82,7 @@ M: Thomas Huth <thuth@redhat.com>
>>>   M: David Hildenbrand <david@redhat.com>
>>>   M: Janosch Frank <frankja@linux.ibm.com>
>>>   R: Cornelia Huck <cohuck@redhat.com>
>>> +R: Pierre Morel <pmorel@linux.ibm.com>
>>
>> If you're ok with the amount of mails you'll get then go ahead.
>> But I think maintainer file changes should always be in a separate patch.
>>
>>>   L: kvm@vger.kernel.org
>>>   L: linux-s390@vger.kernel.org
>>>   F: s390x/*
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

If it's a new file, it's up to the author. I personally prefer -later, but I 
think IBM's preference is normally -only instead. Please check with your 
colleagues.
Most s390x-related files in the kvm-unit-tests currently use "GPL-2.0-only", 
so that should be ok anyway.

> /* or // ?

I don't mind. // seems to be kernel style for .c files, but so far we've 
only used /* with SPDX in the kvm-unit-tests, so both should be fine, I think.

> Just to : Why are you people not using the Linux style code completely 
> instead of making new exceptions.
> 
> i.e. SPDX license and MAINTAINERS

Actually, I wonder why the Linux documentation still recommends the 
identifiers that are marked as deprecated on the SPDX website. The 
deprecated "GPL-2.0" can be rather confusing, since it IMHO can easily be 
mistaken as "GPL-2.0+", so the newer identifiers are better, indeed.

Not sure what you mean with MAINTAINERS, though.

  Thomas
