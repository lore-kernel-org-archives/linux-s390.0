Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727663AbfKDN6L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 08:58:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4DrBDJ069217
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 08:58:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w2my318ef-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 08:58:09 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 4 Nov 2019 13:58:07 -0000
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
 <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
 <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Nov 2019 14:58:02 +0100
MIME-Version: 1.0
In-Reply-To: <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <69ddb6a7-8f69-fbc4-63a4-4f5695117078@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 04.11.19 11:19, David Hildenbrand wrote:
>>>> to synchronize page import/export with the I/O for paging. For example you can actually
>>>> fault in a page that is currently under paging I/O. What do you do? import (so that the
>>>> guest can run) or export (so that the I/O will work). As this turned out to be harder then
>>>> we though we decided to defer paging to a later point in time.
>>>
>>> I don't quite see the issue yet. If you page out, the page will
>>> automatically (on access) be converted to !secure/encrypted memory. If
>>> the UV/guest wants to access it, it will be automatically converted to
>>> secure/unencrypted memory. If you have concurrent access, it will be
>>> converted back and forth until one party is done.
>>
>> IO does not trigger an export on an imported page, but an error
>> condition in the IO subsystem. The page code does not read pages through
> 
> Ah, that makes it much clearer. Thanks!
> 
>> the cpu, but often just asks the device to read directly and that's
>> where everything goes wrong. We could bounce swapping, but chose to pin
>> for now until we find a proper solution to that problem which nicely
>> integrates into linux.
> 
> How hard would it be to
> 
> 1. Detect the error condition
> 2. Try a read on the affected page from the CPU (will will automatically convert to encrypted/!secure)
> 3. Restart the I/O
> 
> I assume that this is a corner case where we don't really have to care about performance in the first shot.

We have looked into this. You would need to implement this in the low level
handler for every I/O. DASD, FCP, PCI based NVME, iscsi. Where do you want
to stop?
There is no proper global bounce buffer that works for everything. 

>>>
>>> A proper automatic conversion should make this work. What am I missing?
>>>
>>>>
>>>> As we do not want to rely on the userspace to do the mlock this is now done in the kernel.
>>>
>>> I wonder if we could come up with an alternative (similar to how we
>>> override VM_MERGEABLE in the kernel) that can be called and ensured in
>>> the kernel. E.g., marking whole VMAs as "don't page" (I remember
>>> something like "special VMAs" like used for VDSOs that achieve exactly
>>> that, but I am absolutely no expert on that). That would be much nicer
>>> than pinning all pages and remembering what you pinned in huge page
>>> arrays ...
>>
>> It might be more worthwhile to just accept one or two releases with
>> pinning and fix the root of the problem than design a nice stopgap.
> 
> Quite honestly, to me this feels like a prototype hack that deserves a proper solution first. The issue with this hack is that it affects user space (esp. MADV_DONTNEED no longer working correctly). It's not just something you once fix in the kernel and be done with it.

I disagree. Pinning is a valid initial version. I would find it strange to
allow it for AMD SEV, but not allowing it for s390x. 
As far as I can tell  MADV_DONTNEED continues to work within the bounds
of specification. In fact, it does work (or does not depending on your 
perspective :-) ) exactly in the same way as on hugetlbfs,which is also
a way of pinning.

And yes, I am in full agreement that we must work on lifting that
restriction. 


>>
>> Btw. s390 is not alone with the problem and we'll try to have another
>> discussion tomorrow with AMD to find a solution which works for more
>> than one architecture.
> 
> Let me know if there was an interesting outcome.
