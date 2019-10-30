Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbfJ3Pdd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 11:33:33 -0400
Subject: Re: [PATCH v2] mm/sparse.c: mark populate_section_memmap as __meminit
References: <20191030151639.41486-1-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <26d03485-054e-40cc-2a04-151f9d96fdae@redhat.com>
Date: Wed, 30 Oct 2019 16:33:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191030151639.41486-1-iii@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>

On 30.10.19 16:16, Ilya Leoshkevich wrote:
> Building the kernel on s390 with -Og produces the following warning:
>=20
> WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from th=
e function populate_section_memmap() to the function .meminit.text:__popula=
te_section_memmap()
> The function populate_section_memmap() references
> the function __meminit __populate_section_memmap().
> This is often because populate_section_memmap lacks a __meminit
> annotation or the annotation of __populate_section_memmap is wrong.
>=20
> While -Og is not supported, in theory this might still happen with
> another compiler or on another architecture. So fix this by using the
> correct section annotations.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>=20
> v1 -> v2: Do not touch mm/sparse.c version of __populate_section_memmap:
> its __init annotation is correct, since it is only called during init
> phase (by sparse_init_nid), and contains the call to another __init
> function. Spotted by kbuild test robot <lkp@intel.com> and Oscar
> Salvador <osalvador@suse.de>.
>=20
> I was notified that v1 has already been included into
> http://ozlabs.org/~akpm/mmots/broken-out. Since this is not a git
> repository, I've decided to send a v2 instead of the fix. Please let me
> know if I should send a fix instead.

That's fine, Andrew will simply replace the patch.

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
