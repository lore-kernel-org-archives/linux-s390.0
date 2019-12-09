Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726665AbfLIUw7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 15:52:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id 18so248126wmp.0
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 12:52:56 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the pgprot_t in arch_add_memory()
Date: Mon, 9 Dec 2019 21:52:53 +0100
Message-Id: <F98E5D42-BD24-4A01-95EF-44329DDF8190@redhat.com>
References: <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
In-Reply-To: <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, David Hildenbrand <david@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.com>



> Am 09.12.2019 um 21:43 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Mon, Dec 9, 2019 at 12:24 PM Logan Gunthorpe <logang@deltatee=
.com> wrote:
>>=20
>>=20
>>=20
>>> On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
>>> On 09.12.19 20:13, Logan Gunthorpe wrote:
>>>> devm_memremap_pages() is currently used by the PCI P2PDMA code to crea=
te
>>>> struct page mappings for IO memory. At present, these mappings are cre=
ated
>>>> with PAGE_KERNEL which implies setting the PAT bits to be WB. However,=
 on
>>>> x86, an mtrr register will typically override this and force the cache
>>>> type to be UC-. In the case firmware doesn't set this register it is
>>>> effectively WB and will typically result in a machine check exception
>>>> when it's accessed.
>>>>=20
>>>> Other arches are not currently likely to function correctly seeing the=
y
>>>> don't have any MTRR registers to fall back on.
>>>>=20
>>>> To solve this, add an argument to arch_add_memory() to explicitly
>>>> set the pgprot value to a specific value.
>>>>=20
>>>> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
>>>> simple change to pass the pgprot_t down to their respective functions
>>>> which set up the page tables. For x86_32, set the page tables explicit=
ly
>>>> using _set_memory_prot() (seeing they are already mapped). For sh, rej=
ect
>>>> anything but PAGE_KERNEL settings -- this should be fine, for now, see=
ing
>>>> sh doesn't support ZONE_DEVICE anyway.
>>>>=20
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>> ---
>>>> arch/arm64/mm/mmu.c            | 4 ++--
>>>> arch/ia64/mm/init.c            | 5 ++++-
>>>> arch/powerpc/mm/mem.c          | 4 ++--
>>>> arch/s390/mm/init.c            | 4 ++--
>>>> arch/sh/mm/init.c              | 5 ++++-
>>>> arch/x86/mm/init_32.c          | 7 ++++++-
>>>> arch/x86/mm/init_64.c          | 4 ++--
>>>> include/linux/memory_hotplug.h | 2 +-
>>>> mm/memory_hotplug.c            | 2 +-
>>>> mm/memremap.c                  | 2 +-
>>>> 10 files changed, 25 insertions(+), 14 deletions(-)
>>>>=20
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 60c929f3683b..48b65272df15 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1050,7 +1050,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long =
addr)
>>>> }
>>>>=20
>>>> #ifdef CONFIG_MEMORY_HOTPLUG
>>>> -int arch_add_memory(int nid, u64 start, u64 size,
>>>> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
>>>>                     struct mhp_restrictions *restrictions)
>>>=20
>>> Can we fiddle that into "struct mhp_restrictions" instead?
>>=20
>> Yes, if that's what people want, it's pretty trivial to do. I chose not
>> to do it that way because it doesn't get passed down to add_pages() and
>> it's not really a "restriction". If I don't hear any objections, I will
>> do that for v2.
>=20
> +1 to storing this information alongside the altmap in that structure.
> However, I agree struct mhp_restrictions, with the MHP_MEMBLOCK_API
> flag now gone, has lost all of its "restrictions". How about dropping
> the 'flags' property and renaming the struct to 'struct
> mhp_modifiers'?
>=20

I=E2=80=98d prefer that over an arch_add_memory_protected() as suggested by=
 Michal. But if we can change it after adding the memory (as also suggested=
 by Michal), that would also be nice.

Cheers!
