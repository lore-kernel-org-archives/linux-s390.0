Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbhANI6J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 03:58:09 -0500
Subject: Re: [kvm-unit-tests PATCH v4 4/9] s390x: Split assembly into multiple
 files
References: <20210112132054.49756-1-frankja@linux.ibm.com>
 <20210112132054.49756-5-frankja@linux.ibm.com>
 <c07280f6-f56c-ea6c-1255-28a36a2385c0@redhat.com>
 <fce05f26-8cdb-009d-a88d-c799c3784506@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <46f771fa-f1a2-825e-8cd0-d9a81d1b1d73@redhat.com>
Date: Thu, 14 Jan 2021 09:54:03 +0100
MIME-Version: 1.0
In-Reply-To: <fce05f26-8cdb-009d-a88d-c799c3784506@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 13/01/2021 13.15, Janosch Frank wrote:
> On 1/13/21 1:04 PM, Thomas Huth wrote:
>> On 12/01/2021 14.20, Janosch Frank wrote:
>>> I've added too much to cstart64.S which is not start related
>>> already. Now that I want to add even more code it's time to split
>>> cstart64.S. lib.S has functions that are used in tests. macros.S
>>> contains macros which are used in cstart64.S and lib.S
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> ---
>>>    s390x/Makefile   |   6 +--
>>>    s390x/cstart64.S | 119 ++---------------------------------------------
>>>    s390x/lib.S      |  65 ++++++++++++++++++++++++++
>>
>> lib.S is a very generic name ... maybe rather use cpuasm.S or something similar?
> 
> instr.S ?

Hmm, no, if I read something like that, I'd expect wrapper functions for 
single instructions, which is not what we have here.

Looking at the two functions, both are related to CPU stuff (reset and 
state), so something with "cpu" in the name would be best, I think. Maybe 
just cpu.S ?

Or if you intend to add non-CPU related stuff here later, maybe something 
like misc.S ?

> Or maybe entry.S to make it similar to the kernel?

No, entry.S sounds like a startup code, which we already have in cstart64.S, 
so I'd rather avoid that name.

  Thomas
