Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgBJS2n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:28:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AILlC5087143
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:28:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ums0trm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:28:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 18:28:40 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <d8622308-6089-50a4-54e0-277dc7c8c74b@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 19:28:34 +0100
MIME-Version: 1.0
In-Reply-To: <d8622308-6089-50a4-54e0-277dc7c8c74b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f7065c72-0487-9d03-a286-f75a60b4ac5f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>



On 10.02.20 19:17, David Hildenbrand wrote:
> On 07.02.20 12:39, Christian Borntraeger wrote:
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
> 
> My question would be: What guarantees that the page will stay accessible
> (for I/O)? IIRC, pages can be converted back to secure/inaccessible
> whenever the guest wants to access them. How will that be dealt with?

Yes, in patch 5 we do use the page lock, PageWriteBack and page_ref_freeze
to only make the page secure again if no I/O is going to be started or
still running.

We have minimized the common code impact (just these 3 callbacks) so that 
architecture code can do the right thing.

> 
> I would assume some magic counter that tracks if the page still has to
> remain accessible. Once all clients that require the page to be
> "accessible" on the I/O path are done, the page can be made inaccessible
> again. But then, I would assume there would be something like a
> 
> /* make page accessible and make sure the page will remain accessible */
> arch_get_page_accessible(page);
> 
> /* we're done dealing with the page content */
> arch_put_page_accessible(page);
> 
> You mention page references. I think you should elaborate how that is
> expected to work in the patch description more detailed.
> 
> 
> (side note: I assume you guys have a plan for dealing with kdump wanting
> to dump inaccessible pages. the kexec kernel would have to talk to the
> UV to convert pages - and also make pages accessible on the I/O path I
> guess - or one would want to mark and skip encrypted pages completely in
> kdump somehow, as the content is essentially garbage)

On kexec and kdump the ultravisor is called as part of the the diagnose
308 subcodes 0 and 1 to make sure that a: kdump works (no fault on a 
previously secure page) and b: the content of the secure page is no 
longer accessible.
