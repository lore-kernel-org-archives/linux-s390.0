Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726952AbgBTMPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 07:15:23 -0500
Subject: Re: [PATCH v3 01/37] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c47b3511-2447-e463-abb8-9bd3f35932c8@redhat.com>
Date: Thu, 20 Feb 2020 13:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Will Deacon <will@kernel.org>

On 20.02.20 11:39, Christian Borntraeger wrote:
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


Subject: "mm: gup..."

And I'd probably add that on s390x, it's unlikely to ever return !0.
(why the WARN_ON is okay and has to be tackled once relevant)

>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb
