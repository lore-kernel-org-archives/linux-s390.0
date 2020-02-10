Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgBJTdL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 14:33:11 -0500
Received: by mail-wr1-f70.google.com with SMTP id m15so5493261wrs.22
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 11:33:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 02/35] KVM: s390/interrupt: do not pin adapter interrupt pages
Date: Mon, 10 Feb 2020 20:33:06 +0100
Message-Id: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
References: <083a3fd0-7b56-e92b-bf15-3383b7f5488b@de.ibm.com>
In-Reply-To: <083a3fd0-7b56-e92b-bf15-3383b7f5488b@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>



> Am 10.02.2020 um 19:41 schrieb Christian Borntraeger <borntraeger@de.ibm.c=
om>:
>=20
> =EF=BB=BF
>=20
>> On 10.02.20 13:26, David Hildenbrand wrote:
>>> On 07.02.20 12:39, Christian Borntraeger wrote:
>>> From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>>>=20
>>> The adapter interrupt page containing the indicator bits is currently
>>> pinned. That means that a guest with many devices can pin a lot of
>>> memory pages in the host. This also complicates the reference tracking
>>> which is needed for memory management handling of protected virtual
>>> machines.
>>> We can reuse the pte notifiers to "cache" the page without pinning it.
>>>=20
>>> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>>> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
>>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>=20
>> So, instead of pinning explicitly, look up the page address, cache it,
>> and glue its lifetime to the gmap table entry. When that entry is
>> changed, invalidate the cached page. On re-access, look up the page
>> again and register the gmap notifier for the table entry again.
>=20
> I think I might want to split this into two parts.
> part 1: a naive approach that always does get_user_pages_remote/put_page
> part 2: do the complex caching
>=20
> Ulrich mentioned that this actually could make the map/unmap a no-op as we=

> have the address and bit already in the irq route. In the end this might b=
e
> as fast as todays pinning as we replace a list walk with a page table walk=
.=20
> Plus it would simplify the code. Will have a look if that is the case.

If we could simplify that heavily, that would be awesome!=
