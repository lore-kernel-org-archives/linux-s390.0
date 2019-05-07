Return-Path: <SRS0=f00L=TH=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: Factor out memory block device
 handling
From: David Hildenbrand <david@redhat.com>
References: <20190507183804.5512-1-david@redhat.com>
 <CAPcyv4gxwhsiZ8Hjm4cNbjmLXV2m4s=t14ZoH0uf8AADP2nOtA@mail.gmail.com>
 <6f69e615-2b4a-ff31-5d2a-e1711c564f9b@redhat.com>
Message-ID: <ad971f57-5f09-c056-beef-6a7b63311106@redhat.com>
Date: Tue, 7 May 2019 21:37:45 +0200
MIME-Version: 1.0
In-Reply-To: <6f69e615-2b4a-ff31-5d2a-e1711c564f9b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Deucher <alexander.deucher@amd.com>, Andrew Banman <andrew.banman@hpe.com>, Andy Lutomirski <luto@kernel.org>, Arun KS <arunks@codeaurora.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@c-s.fr>, Chris Wilson <chris@chris-wilson.co.uk>, Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Logan Gunthorpe <logang@deltatee.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Nicholas Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Paul Mackerras <paulus@samba.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Vasily Gorbik <gor@linux.ibm.com>, Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-ID: <linux-s390.vger.kernel.org>

On 07.05.19 21:21, David Hildenbrand wrote:
> On 07.05.19 21:04, Dan Williams wrote:
>> On Tue, May 7, 2019 at 11:38 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> We only want memory block devices for memory to be onlined/offlined
>>> (add/remove from the buddy). This is required so user space can
>>> online/offline memory and kdump gets notified about newly onlined memory.
>>>
>>> Only such memory has the requirement of having to span whole memory blocks.
>>> Let's factor out creation/removal of memory block devices. This helps
>>> to further cleanup arch_add_memory/arch_remove_memory() and to make
>>> implementation of new features easier. E.g. supplying a driver for
>>> memory block devices becomes way easier (so user space is able to
>>> distinguish different types of added memory to properly online it).
>>>
>>> Patch 1 makes sure the memory block size granularity is always respected.
>>> Patch 2 implements arch_remove_memory() on s390x. Patch 3 prepares
>>> arch_remove_memory() to be also called without CONFIG_MEMORY_HOTREMOVE.
>>> Patch 4,5 and 6 factor out creation/removal of memory block devices.
>>> Patch 7 gets rid of some unlikely errors that could have happened, not
>>> removing links between memory block devices and nodes, previously brought
>>> up by Oscar.
>>>
>>> Did a quick sanity test with DIMM plug/unplug, making sure all devices
>>> and sysfs links properly get added/removed. Compile tested on s390x and
>>> x86-64.
>>>
>>> Based on git://git.cmpxchg.org/linux-mmots.git
>>>
>>> Next refactoring on my list will be making sure that remove_memory()
>>> will never deal with zones / access "struct pages". Any kind of zone
>>> handling will have to be done when offlining system memory / before
>>> removing device memory. I am thinking about remove_pfn_range_from_zone()",
>>> du undo everything "move_pfn_range_to_zone()" did.
>>>
>>> v1 -> v2:
>>> - s390x/mm: Implement arch_remove_memory()
>>> -- remove mapping after "__remove_pages"
>>>
>>>
>>> David Hildenbrand (8):
>>>   mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
>>>   s390x/mm: Implement arch_remove_memory()
>>>   mm/memory_hotplug: arch_remove_memory() and __remove_pages() with
>>>     CONFIG_MEMORY_HOTPLUG
>>>   mm/memory_hotplug: Create memory block devices after arch_add_memory()
>>>   mm/memory_hotplug: Drop MHP_MEMBLOCK_API
>>
>> So at a minimum we need a bit of patch staging guidance because this
>> obviously collides with the subsection bits that are built on top of
>> the existence of MHP_MEMBLOCK_API. What trigger do you envision as a
>> replacement that arch_add_memory() use to determine that subsection
>> operations should be disallowed?
>>
> 
> Looks like we now have time to sort it out :)
> 
> 
> Looking at your series
> 
> [PATCH v8 08/12] mm/sparsemem: Prepare for sub-section ranges
> 
> is the "single" effectively place using MHP_MEMBLOCK_API, namely
> "subsection_check()". Used when adding/removing memory.
> 
> 
> +static int subsection_check(unsigned long pfn, unsigned long nr_pages,
> +		unsigned long flags, const char *reason)
> +{
> +	/*
> +	 * Only allow partial section hotplug for !memblock ranges,
> +	 * since register_new_memory() requires section alignment, and
> +	 * CONFIG_SPARSEMEM_VMEMMAP=n requires sections to be fully
> +	 * populated.
> +	 */
> +	if ((!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)
> +				|| (flags & MHP_MEMBLOCK_API))
> +			&& ((pfn & ~PAGE_SECTION_MASK)
> +				|| (nr_pages & ~PAGE_SECTION_MASK))) {
> +		WARN(1, "Sub-section hot-%s incompatible with %s\n", reason,
> +				(flags & MHP_MEMBLOCK_API)
> +				? "memblock api" : "!CONFIG_SPARSEMEM_VMEMMAP");
> +		return -EINVAL;
> +	}
> +	return 0;
>  }
> 
> 
> (flags & MHP_MEMBLOCK_API)) && ((pfn & ~PAGE_SECTION_MASK) || (nr_pages
> & ~PAGE_SECTION_MASK)))
> 
> sounds like something the caller (add_memory()) always has to take care
> of. No need to check. The one imposing this restriction is the only caller.
> 
> In my opinion, that check/function can go completely.
> 
> Am I missing something / missing another user?
> 

In other word, this series moves the restriction out of
arch_add_memory() and therefore you don't need subsection_check() at all
anymore. At least if I am not missing something :)

-- 

Thanks,

David / dhildenb
