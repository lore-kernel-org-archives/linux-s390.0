Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25244 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbgDUQSQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Apr 2020 12:18:16 -0400
Subject: Re: [kvm-unit-tests PATCH v5 00/10] s390x: Testing the Channel
 Subsystem I/O
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <028ece05-1429-7761-cf4e-6fabc34e6aa0@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4a5f0636-cd73-164a-8c7a-ca5679f01e56@redhat.com>
Date: Tue, 21 Apr 2020 18:18:09 +0200
MIME-Version: 1.0
In-Reply-To: <028ece05-1429-7761-cf4e-6fabc34e6aa0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 21.04.20 18:13, Pierre Morel wrote:
> 
> 
> On 2020-02-20 13:00, Pierre Morel wrote:
> 
> ...snip...
> 
>>
>>
>> Pierre Morel (10):
>>    s390x: saving regs for interrupts
>>    s390x: Use PSW bits definitions in cstart
>>    s390x: cr0: adding AFP-register control bit
>>    s390x: export the clock get_clock_ms() utility
> 
> Please can you consider applying these 4 patches only.
> I will send some changes I made for the patches on css tests.
> 

The first one requires a little more brain power - can anybody at IBM
help reviewing that?


-- 
Thanks,

David / dhildenb
