Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgBUL0W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 06:26:22 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBPSOM074745
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 06:26:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uc2e54p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 06:26:20 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Feb 2020 11:26:18 -0000
Subject: Re: [PATCH v3 00/37] KVM: s390: Add support for protected VMs
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <5556ee4a-09c6-117a-be99-4a5e136b78ea@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Feb 2020 12:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <5556ee4a-09c6-117a-be99-4a5e136b78ea@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0665a90a-19f2-39a8-8a48-d180a622e9f2@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org



On 21.02.20 11:54, David Hildenbrand wrote:
> On 20.02.20 11:39, Christian Borntraeger wrote:
>> mm people: This series contains a "pretty small" common code memory
>> management change that will allow paging, guest backing with files etc
>> almost just like normal VMs. It should be a no-op for all architectures
>> not opting in. And it should be usable for others that also try to get
>> notified on "the pages are in the process of being used for things like
>> I/O". This time I included error handling and an ACK from Will Deacon.
>>
>> mm-related patches CCed on linux-mm, the complete list can be found on
>> the KVM and linux-s390 list. 
>>
>> Andrew, any chance to either take " mm:gup/writeback: add callbacks for
>> inaccessible pages" or ACK so that I can take it?
> 
> Summary: Mostly LGTM. Especially
> - UAPI interface is minimal and clean
> - Core MM changes are minimal and clean (and AFAIKT Andrea was involved
>   when discussing the approach, so it can't be wrong ;) )
> - Is no longer prototype quality ;)
> 
> There are still some things I want to double check (esp. how KVM memory
> slots are handled - I somewhat dislike that we cannot replace/add new
> ones while in PV. One would have to fence that somehow in QEMU as long
> as the guest is in PV mode e.g., once we would support memory hotplug
> ... but looks like this is what the HW requires us to enforce for now),
> certain races, etc. but I assume these things could be fixed later on.


In fact you can do that. The hardware checks the integrity on guest physical
address. So it is perfectly possible to remap a kvm slot as long as the
eńcrypted content matches what counter, guest content hash and guest address
tell. (It is like swapping, you move the encrypted content from one host 
page to another). 
For new pages (not unpacked and never touched by the guest) the ultravisor
will bring a zeroed out page on first import.

What does not work is when the user space address changes for a guest
virtio indicator. But this was already broken before (we never did an
adapter unmap/remap).

> 
> Can we get a new version once the other reviewers are done, so at least
> I can have a final look?

Just the updated patches as reply (e.g. a 3.2 for patch 9) or the full monty?
