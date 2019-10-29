Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727406AbfJ2LJc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 07:09:32 -0400
Subject: Re: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
References: <20191028165549.14478-1-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6e845b02-9601-5c9d-3f99-c8a439df07ae@redhat.com>
Date: Tue, 29 Oct 2019 12:09:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191028165549.14478-1-iii@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 28.10.19 17:55, Ilya Leoshkevich wrote:
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
>   mm/sparse.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..0f1f36443a96 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
>   =09return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>   }
>  =20
> -struct page __init *__populate_section_memmap(unsigned long pfn,
> +struct page __meminit *__populate_section_memmap(unsigned long pfn,
>   =09=09unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>   {
>   =09unsigned long size =3D section_map_size();
> @@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, un=
signed long end_pfn)
>   #endif
>  =20
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static struct page *populate_section_memmap(unsigned long pfn,
> +static struct page * __meminit populate_section_memmap(unsigned long pfn=
,
>   =09=09unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>   {
>   =09return __populate_section_memmap(pfn, nr_pages, nid, altmap);
> @@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
>   =09vmemmap_free(start, end, NULL);
>   }
>   #else
> -struct page *populate_section_memmap(unsigned long pfn,
> +struct page * __meminit populate_section_memmap(unsigned long pfn,
>   =09=09unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>   {
>   =09struct page *page, *ret;
>=20

So mm/sparse-vmemmap.c:__populate_section_memmap() already has this=20
annotation. I guess it's the right thing to do as=20
populate_section_memmap() is called from

static struct page * __meminit section_activate()

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
