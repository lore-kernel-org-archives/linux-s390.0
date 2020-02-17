Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729110AbgBQVOm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 16:14:42 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HLEA25023085
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 16:14:41 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dnt143t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 16:14:40 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 21:14:39 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <28792269-e053-ac70-a344-45612ee5c729@de.ibm.com>
 <20200213195602.GD18610@linux.intel.com>
 <e2c41b25-6d6d-6685-3450-2e3e8d84efd1@de.ibm.com>
 <6da2e3d0-a2be-18d2-3548-b546052d14e3@amd.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 22:14:31 +0100
MIME-Version: 1.0
In-Reply-To: <6da2e3d0-a2be-18d2-3548-b546052d14e3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <695952e7-62a9-14f0-68ce-fb41593eb4a3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, kvm-ppc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>



On 17.02.20 21:55, Tom Lendacky wrote:
[...]

>>> What is the use case for calling arch_make_page_accessible() in the follow()
>>> and gup() paths?  Live migration is the only thing that comes to mind, and
>>> for live migration I would expect you would want to keep the secure guest
>>> running when copying pages to the target, i.e. use pre-copy.  That would
>>> conflict with converting the page in place.  Rather, migration would use a
>>> separate dedicated path to copy the encrypted contents of the secure page to
>>> a completely different page, and send *that* across the wire so that the
>>> guest can continue accessing the original page.
>>> Am I missing a need to do this for the swap/reclaim case?  Or is there a
>>> completely different use case I'm overlooking?
>>
>> This is actually to protect the host against a malicious user space. For 
>> example a bad QEMU could simply start direct I/O on such protected memory.
>> We do not want userspace to be able to trigger I/O errors and thus we
>> implemented the logic to "whenever somebody accesses that page (gup) or
>> doing I/O, make sure that this page can be accessed. When the guest tries
>> to access that page we will wait in the page fault handler for writeback to
>> have finished and for the page_ref to be the expected value.
> 
> So in this case, when the guest tries to access the page, the page may now
> be corrupted because I/O was allowed to be done to it? Or will the I/O
> have been blocked in some way, but without generating the I/O error?

No the I/O would be blocked by the hardware. Thats why we encrypt and export
the page for I/O usage. As soon as the refcount drops to the expected value
the guest can access its (unchanged) content after the import. the import
would check the hash etc. so no corruption of the guest state in any case.
(apart from denial of service, which is always possible)
If we would not have these hooks a malicious user could trigger I/O (which 
would be blocked) but the blocked I/O would generate an I/O error. And this
could bring trouble to some device drivers. And we want to avoid that.

In other words: the hardware/firmware will ensure guest integrity.But host
integrity (kernel vs userspace) must be enforced by the host kernel as usual
and this is one part of it.

But thanks for the clarification that you do not need those hooks.
