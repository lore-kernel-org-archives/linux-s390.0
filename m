Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387539AbgF3RLK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 13:11:10 -0400
Received: by mail-wr1-f70.google.com with SMTP id w4so17144513wrm.5
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2020 10:11:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/2] mm/memblock: expose only miminal interface to add/walk physmem
Date: Tue, 30 Jun 2020 19:11:04 +0200
Message-Id: <31512CDA-4B5E-447C-B84A-C1A592323975@redhat.com>
References: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
In-Reply-To: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>



> Am 30.06.2020 um 18:58 schrieb David Hildenbrand <david@redhat.com>:
>=20
> =EF=BB=BF
>>=20
>>> extern struct memblock memblock;
>>> @@ -114,6 +110,19 @@ int memblock_remove(phys_addr_t base, phys_addr_t s=
ize);
>>> int memblock_free(phys_addr_t base, phys_addr_t size);
>>> int memblock_reserve(phys_addr_t base, phys_addr_t size);
>>> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> +/**
>>> + * for_each_physmem_range - iterate through physmem areas not included i=
n type.
>>> + * @i: u64 used as loop variable
>>> + * @type: ptr to memblock_type which excludes from the iteration, can b=
e %NULL
>>> + * @p_start: ptr to phys_addr_t for start address of the range, can be %=
NULL
>>> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NUL=
L
>>> + */
>>> +#define for_each_physmem_range(i, type, p_start, p_end)            \
>>> +    for (i =3D 0, __next_physmem_range(&i, type, p_start, p_end);    \
>>> +         i !=3D (u64)ULLONG_MAX;                    \
>>> +         __next_physmem_range(&i, type, p_start, p_end))
>>> +void __next_physmem_range(u64 *idx, struct memblock_type *type,
>>> +              phys_addr_t *out_start, phys_addr_t *out_end);
>>=20
>> __next_physmem_range() is not really necessary, the
>> for_each_physmem_range() macro can use __next_mem_range() directly, but
>> I suspect it won't look nice :)
>>=20
>> Can you please make __next_physmem_range() static inline if we are to
>> keep it?
>=20
> The thing is, then I have to expose "physmem" to something outside
> memblock.c. That's what I wanted to avoid here. (instead, have a minimal
> interface that is sufficient enough for this special case of physmem -
> add memory during boot, walk memory after boot. Performance is not an
> issue).

... but it might do with an extern declaration within the inline function. W=
ill have a look tomorrow, thanks!=
