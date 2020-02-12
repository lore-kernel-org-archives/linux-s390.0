Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727054AbgBLMrT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 07:47:19 -0500
Subject: Re: [PATCH v2 RFC] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
 <20200211092341.3965-1-borntraeger@de.ibm.com>
 <01d1c188-38fb-e405-83d7-6184adccba5a@redhat.com>
 <b72359a7-fb4b-6862-33e2-5cba9d48ab56@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d80d9846-b10a-08e1-91ae-32e9ba86a483@redhat.com>
Date: Wed, 12 Feb 2020 13:47:08 +0100
MIME-Version: 1.0
In-Reply-To: <b72359a7-fb4b-6862-33e2-5cba9d48ab56@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com, "dgilbert@redhat.com" <dgilbert@redhat.com>

On 12.02.20 13:22, Christian Borntraeger wrote:
> 
> 
> On 12.02.20 13:16, David Hildenbrand wrote:
>>
>>> +	/*
>>> +	 * We resolve the gpa to hva when setting the IRQ routing. If userspace
>>> +	 * decides to mess with the memslots it better also updates the irq
>>> +	 * routing. Otherwise we will write to the wrong userspace address.
>>> +	 */
>>
>> I guess this is just as old handling, where a page was pinned. But
>> slightly better :) So the pages are definitely part of guest memory.
>>
>> Fun stuff: If (a nasty) guest (in current code) zappes this page using
>> balloon inflation and the page is re-accessed (e.g., by the guest or by
>> the host), a new page will be faulted in, and there will be an
>> inconsistency between what the guest/user space sees and what this code
>> sees. Going via the user space address looks cleaner.
>>
>> Now, with postcopy live migration, we will also zap all guest memory
>> before starting the guest, I do wonder if that produces a similar
>> inconsistency ... usually, when pages are pinned in the kernel, we
>> inhibit the balloon and implicitly also postcopy.
>>
>> If so, this actually fixes an issue. But might depend on the order
>> things are initialized in user space. Or I am messing up things :)
> 
> Yes, the current code has some corner cases where a guest can shoot himself
> in the foot. This variant could actually be safer. 

At least with postcopy it would be a silent migration issue, not guest
triggered. But I am not sure if it can trigger.

Anyhow, this is safer :)

-- 
Thanks,

David / dhildenb
