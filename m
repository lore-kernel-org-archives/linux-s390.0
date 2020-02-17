Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbgBQLKK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 06:10:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HB3iBV142337
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 06:10:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dp81c32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 06:10:09 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 11:10:06 -0000
Subject: Re: [PATCH v2 01/42] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-2-borntraeger@de.ibm.com>
 <107a8a72-b745-26f2-5805-c4d99ce77b35@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 12:10:01 +0100
MIME-Version: 1.0
In-Reply-To: <107a8a72-b745-26f2-5805-c4d99ce77b35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <dd33cc1a-214d-b949-8f5e-9c2d40a8e518@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>



On 17.02.20 10:14, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> With the introduction of protected KVM guests on s390 there is now a
>> concept of inaccessible pages. These pages need to be made accessible
>> before the host can access them.
>>
>> While cpu accesses will trigger a fault that can be resolved, I/O
>> accesses will just fail.  We need to add a callback into architecture
>> code for places that will do I/O, namely when writeback is started or
>> when a page reference is taken.
>>
>> This is not only to enable paging, file backing etc, it is also
>> necessary to protect the host against a malicious user space. For
>> example a bad QEMU could simply start direct I/O on such protected
>> memory.  We do not want userspace to be able to trigger I/O errors and
>> thus we the logic is "whenever somebody accesses that page (gup) or
>> doing I/O, make sure that this page can be accessed. When the guest
>> tries to access that page we will wait in the page fault handler for
>> writeback to have finished and for the page_ref to be the expected
>> value.
>>
>> If wanted by others, the callbacks can be extended with error handlin
>> and a parameter from where this is called.
> 
> s/handlin/handling/

ack. 
> 
> One last question from my side:
> 
> Why is it OK to ignore errors here. IOW, why not squash "[PATCH v2
> 39/42] example for future extension: mm:gup/writeback: add callbacks for
> inaccessible pages: error cases" into this patch.

I can certainly squash this in. But I have never heard feedback from the 
memory management people if they would prefer the patch as-is (no overhead
at all for !s390) or already with the error handling. 
> 
> I can see in patch "[PATCH v2 05/42] s390/mm: provide memory management
> functions for protected KVM guests", that the call can fail for various
> reasons. That puzzles me a bit - what would happen if any of that fails?

The convert _to_ secure has error handling. uv_convert_from_secure (the
one that is used for arch_make_page_accessible can only fail if we mess up,
e.g. an "export" on memory that we have donated to the ultravisor.


> Or will it actually never fail for s390x (and all that error handling in
> arch_make_page_accessible() is essentially dead code in real life?)

So yes, if everything is setup properly this should not fail in real life
and only we have a kernel (or firmware) bug.
