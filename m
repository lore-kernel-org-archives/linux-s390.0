Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726816AbgBJSRT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:17:19 -0500
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d8622308-6089-50a4-54e0-277dc7c8c74b@redhat.com>
Date: Mon, 10 Feb 2020 19:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>

On 07.02.20 12:39, Christian Borntraeger wrote:
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

My question would be: What guarantees that the page will stay accessible
(for I/O)? IIRC, pages can be converted back to secure/inaccessible
whenever the guest wants to access them. How will that be dealt with?

I would assume some magic counter that tracks if the page still has to
remain accessible. Once all clients that require the page to be
"accessible" on the I/O path are done, the page can be made inaccessible
again. But then, I would assume there would be something like a

/* make page accessible and make sure the page will remain accessible */
arch_get_page_accessible(page);

/* we're done dealing with the page content */
arch_put_page_accessible(page);

You mention page references. I think you should elaborate how that is
expected to work in the patch description more detailed.


(side note: I assume you guys have a plan for dealing with kdump wanting
to dump inaccessible pages. the kexec kernel would have to talk to the
UV to convert pages - and also make pages accessible on the I/O path I
guess - or one would want to mark and skip encrypted pages completely in
kdump somehow, as the content is essentially garbage)



cc Michal (not sure if your area of expertise)
https://lore.kernel.org/kvm/20200207113958.7320-2-borntraeger@de.ibm.com/

--=20
Thanks,

David / dhildenb
