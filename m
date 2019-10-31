Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbfJaU5K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 16:57:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VKuheT048177
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 16:57:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w04kxmwcs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 16:57:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 31 Oct 2019 20:57:07 -0000
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 31 Oct 2019 21:57:02 +0100
MIME-Version: 1.0
In-Reply-To: <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 10/31/19 6:30 PM, David Hildenbrand wrote:
> On 31.10.19 16:41, Christian Borntraeger wrote:
>>
>>
>> On 25.10.19 10:49, David Hildenbrand wrote:
>>> On 24.10.19 13:40, Janosch Frank wrote:
>>>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>>
>>>> Pin the guest pages when they are first accessed, instead of all at
>>>> the same time when starting the guest.
>>>
>>> Please explain why you do stuff. Why do we have to pin the hole guest memory? Why can't we mlock() the hole memory to avoid swapping in user space?
>>
>> Basically we pin the guest for the same reason as AMD did it for their SEV. It is hard
> 
> Pinning all guest memory is very ugly. What you want is "don't page", 
> what you get is unmovable pages all over the place. I was hoping that 
> you could get around this by having an automatic back-and-forth 
> conversion in place (due to the special new exceptions).

Yes, that's one of the ideas that have been circulating.

> 
>> to synchronize page import/export with the I/O for paging. For example you can actually
>> fault in a page that is currently under paging I/O. What do you do? import (so that the
>> guest can run) or export (so that the I/O will work). As this turned out to be harder then
>> we though we decided to defer paging to a later point in time.
> 
> I don't quite see the issue yet. If you page out, the page will 
> automatically (on access) be converted to !secure/encrypted memory. If 
> the UV/guest wants to access it, it will be automatically converted to 
> secure/unencrypted memory. If you have concurrent access, it will be 
> converted back and forth until one party is done.

IO does not trigger an export on an imported page, but an error
condition in the IO subsystem. The page code does not read pages through
the cpu, but often just asks the device to read directly and that's
where everything goes wrong. We could bounce swapping, but chose to pin
for now until we find a proper solution to that problem which nicely
integrates into linux.

> 
> A proper automatic conversion should make this work. What am I missing?
> 
>>
>> As we do not want to rely on the userspace to do the mlock this is now done in the kernel.
> 
> I wonder if we could come up with an alternative (similar to how we 
> override VM_MERGEABLE in the kernel) that can be called and ensured in 
> the kernel. E.g., marking whole VMAs as "don't page" (I remember 
> something like "special VMAs" like used for VDSOs that achieve exactly 
> that, but I am absolutely no expert on that). That would be much nicer 
> than pinning all pages and remembering what you pinned in huge page 
> arrays ...

It might be more worthwhile to just accept one or two releases with
pinning and fix the root of the problem than design a nice stopgap.

Btw. s390 is not alone with the problem and we'll try to have another
discussion tomorrow with AMD to find a solution which works for more
than one architecture.
