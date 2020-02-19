Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgBSIbZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:25 -0500
Subject: Re: [PATCH v2 01/42] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-2-borntraeger@de.ibm.com>
 <107a8a72-b745-26f2-5805-c4d99ce77b35@redhat.com>
 <dd33cc1a-214d-b949-8f5e-9c2d40a8e518@de.ibm.com>
 <a8f8786e-1ed0-0c44-08d0-ebc58f43ae40@redhat.com>
 <20200218154610.GB27565@linux.intel.com>
 <20200218160242.GB1133@willie-the-truck>
 <d2536349-bc47-2b0f-79dc-4bb7cea5182d@de.ibm.com>
 <20200218213548.GI28156@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e7050290-316d-f938-6ccb-690b2e7ef0e3@redhat.com>
Date: Wed, 19 Feb 2020 09:31:14 +0100
MIME-Version: 1.0
In-Reply-To: <20200218213548.GI28156@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Will Deacon <will@kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

On 18.02.20 22:35, Sean Christopherson wrote:
> On Tue, Feb 18, 2020 at 05:15:57PM +0100, Christian Borntraeger wrote:
>>
>>
>> On 18.02.20 17:02, Will Deacon wrote:
>>> On Tue, Feb 18, 2020 at 07:46:10AM -0800, Sean Christopherson wrote:
>>>> On Tue, Feb 18, 2020 at 09:27:20AM +0100, David Hildenbrand wrote:
>>>>> On 17.02.20 12:10, Christian Borntraeger wrote:
>>>>>> So yes, if everything is setup properly this should not fail in real life
>>>>>> and only we have a kernel (or firmware) bug.
>>>>>>
>>>>>
>>>>> Then, without feedback from other possible users, this should be a void
>>>>> function. So either introduce error handling or convert it to a void for
>>>>> now (and add e.g., BUG_ON and a comment inside the s390x implementation).
>>>>
>>>> My preference would also be for a void function (versus ignoring an int
>>>> return).
>>>
>>> The gup code could certainly handle the error value, although the writeback
>>> is a lot less clear (so a BUG_ON() would seem to be sufficient for now).
>>
>> Sean, David. Can we agree on merging patch 39?
> 
> I'm a-ok with adding error checking, ignoring the return value is the only
> option I don't like :-)

Same over here :)

-- 
Thanks,

David / dhildenb
