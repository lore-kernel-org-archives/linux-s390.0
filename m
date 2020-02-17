Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728737AbgBQJPR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 04:15:17 -0500
Subject: Re: [PATCH v2 01/42] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <107a8a72-b745-26f2-5805-c4d99ce77b35@redhat.com>
Date: Mon, 17 Feb 2020 10:14:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> With the introduction of protected KVM guests on s390 there is now a
> concept of inaccessible pages. These pages need to be made accessible
> before the host can access them.
>=20
> While cpu accesses will trigger a fault that can be resolved, I/O
> accesses will just fail.  We need to add a callback into architecture
> code for places that will do I/O, namely when writeback is started or
> when a page reference is taken.
>=20
> This is not only to enable paging, file backing etc, it is also
> necessary to protect the host against a malicious user space. For
> example a bad QEMU could simply start direct I/O on such protected
> memory.  We do not want userspace to be able to trigger I/O errors and
> thus we the logic is "whenever somebody accesses that page (gup) or
> doing I/O, make sure that this page can be accessed. When the guest
> tries to access that page we will wait in the page fault handler for
> writeback to have finished and for the page_ref to be the expected
> value.
>=20
> If wanted by others, the callbacks can be extended with error handlin
> and a parameter from where this is called.

s/handlin/handling/

One last question from my side:

Why is it OK to ignore errors here. IOW, why not squash "[PATCH v2
39/42] example for future extension: mm:gup/writeback: add callbacks for
inaccessible pages: error cases" into this patch.

I can see in patch "[PATCH v2 05/42] s390/mm: provide memory management
functions for protected KVM guests", that the call can fail for various
reasons. That puzzles me a bit - what would happen if any of that fails?
Or will it actually never fail for s390x (and all that error handling in
arch_make_page_accessible() is essentially dead code in real life?)

--=20
Thanks,

David / dhildenb
