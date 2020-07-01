Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731978AbgGAPfB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 11:35:01 -0400
Received: by mail-wm1-f72.google.com with SMTP id g6so18176652wmk.4
        for <linux-s390@vger.kernel.org>; Wed, 01 Jul 2020 08:34:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to add/walk physmem
Date: Wed, 1 Jul 2020 17:34:54 +0200
Message-Id: <62588A3E-81FA-4C79-B215-D1D33887597C@redhat.com>
References: <20200701150643.GA2999146@linux.ibm.com>
In-Reply-To: <20200701150643.GA2999146@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>



> Am 01.07.2020 um 17:07 schrieb Mike Rapoport <rppt@linux.ibm.com>:
>=20
> =EF=BB=BFHi David,
>=20
>> On Wed, Jul 01, 2020 at 04:18:29PM +0200, David Hildenbrand wrote:
>> "physmem" in the memblock allocator is somewhat weird: it's not actually
>> used for allocation, it's simply information collected during boot, which=

>> describes the unmodified physical memory map at boot time, without any
>> standby/hotplugged memory. It's only used on s390x and is currently the
>> only reason s390x keeps using CONFIG_ARCH_KEEP_MEMBLOCK.
>>=20
>> Physmem isn't numa aware and current users don't specify any flags. Let's=

>> hide it from the user, exposing only for_each_physmem(), and simplify. Th=
e
>> interface for physmem is now really minimalistic:
>> - memblock_physmem_add() to add ranges
>> - for_each_physmem() / __next_physmem_range() to walk physmem ranges
>>=20
>> Don't place it into an __init section and don't discard it without
>> CONFIG_ARCH_KEEP_MEMBLOCK. As we're reusing __next_mem_range(), remove
>> the __meminit notifier to avoid section mismatch warnings once
>> CONFIG_ARCH_KEEP_MEMBLOCK is no longer used with
>> CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
>>=20
>> While fixing up the documentation, sneak in some related cleanups. We can=

>> stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.
>=20
> As you noted in the previous version it should have been
> CONFIG_ARCH_KEEP_MEMBLOCK ;-)

Grml :) maybe maintainers can fix that up when applying in case there are no=
 other comments.

Thanks Mike for the fast review!=
