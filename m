Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728897AbgBQMH5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 07:07:57 -0500
Subject: Re: [PATCH v2 05/42] s390/mm: provide memory management functions for
 protected KVM guests
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-6-borntraeger@de.ibm.com>
 <f5523486-ee76-e6c1-9563-658bca7f3b0d@redhat.com>
 <87742e00-9a8d-b7b4-ab96-05e8c9d39534@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <31c45ff8-a01a-6ec1-c169-9f52ace9f1f3@redhat.com>
Date: Mon, 17 Feb 2020 13:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <87742e00-9a8d-b7b4-ab96-05e8c9d39534@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org


>>> +		if (local_drain) {
>>> +			lru_add_drain_all();
>>
>> I do wonder if that is valid to be called with all the locks at this point.
> 
> This function uses per cpu workers and needs no other locks. Also verified 
> with lockdep. 

Okay, perfect.

>>> +/**
>>> + * To be called with the page locked or with an extra reference!
>>
>> Can we have races here? (IOW, two callers concurrently for the same page)
> 
> That would be fine and is part of the design. The ultravisor calls will
> either make the page accessible or will be a (mostly) no-op.
> In fact, we allow for slight over-indication of "needs to be exported"
> 
> What about:
> 
> /*
>  * To be called with the page locked or with an extra reference! This will
>  * prevent gmap_make_secure from touching the page concurrently. Having 2
>  * parallel make_page_accessible is fine, as the UV calls will become a 
>  * no-op if the page is already exported.
>  */

Yes, much clearer, thanks!



-- 
Thanks,

David / dhildenb
