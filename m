Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgKSIQp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:16:45 -0500
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
 <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
 <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <10c005bb-f590-d213-8e43-f3411248e79f@linux.ibm.com>
Date: Thu, 19 Nov 2020 10:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 19.11.20 10:12, Sebastian Andrzej Siewior wrote:
> On 2020-11-19 09:45:08 [+0200], Julian Wiedmann wrote:
>> On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
>>> The size of struct th_header is 8 byte and the size of struct th_sweep
>>> is 16 byte. The memory for is allocated, initialized, used and
>>> deallocated a few lines later.
>>>
>>> It is more efficient to avoid the allocation/free dance and keeping the
>>> variable on stack. Especially since the compiler is smart enough to not
>>> allocate the memory on stack but assign the values directly.
>>>
>>> Declare struct th_sweep/th_header on stack and initialize it to zero.
>>> Use the local variable instead of the pointer.
>>>
>>
>> Frankly, I'd much rather see us use the pointers that are returned from
>> skb_push() and skb_put(). No need for the on-stack & memcpy indirection.
> 
> You are aware that the compiler optimizes the on-stack memory away and
> you get the zero-init for free due to the way the assignment is made?
> There is no memcpy() in the resulting code.
> 
> Sebastian
> 

I am not worried about performance at all. Yet readability matters.
