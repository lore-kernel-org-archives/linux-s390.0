Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v1 9/9] mm: better document PG_reserved
References: <20181214111014.15672-1-david@redhat.com>
 <20181214111014.15672-10-david@redhat.com>
 <03f65c6f-1287-4c63-6705-16e58d659d94@infradead.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <affd050a-ae5d-f027-1cb8-0d30822f8f12@redhat.com>
Date: Mon, 17 Dec 2018 10:34:59 +0100
MIME-Version: 1.0
In-Reply-To: <03f65c6f-1287-4c63-6705-16e58d659d94@infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Pavel Tatashin <pasha.tatashin@oracle.com>, yi.z.zhang@linux.intel.com, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On 15.12.18 01:12, Randy Dunlap wrote:
> On 12/14/18 3:10 AM, David Hildenbrand wrote:
>> The usage of PG_reserved and how PG_reserved pages are to be treated is
>> buried deep down in different parts of the kernel. Let's shine some light
>> onto these details by documenting current users and expected
>> behavior.
>>
>> Especially, clarify on the "Some of them might not even exist" case.
>> These are physical memory gaps that will never be dumped as they
>> are not marked as IORESOURCE_SYSRAM. PG_reserved does in general not
>> hinder anybody from dumping or swapping. In some cases, these pages
>> will not be stored in the hibernation image.
> 
> Hi,
> Thanks for the doc update.
> Comments below.
> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
>> Cc: Miles Chen <miles.chen@mediatek.com>
>> Cc: yi.z.zhang@linux.intel.com
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/linux/page-flags.h | 33 +++++++++++++++++++++++++++++++--
>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 808b4183e30d..9de2e941cbd5 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -17,8 +17,37 @@
>>  /*
>>   * Various page->flags bits:
>>   *
>> - * PG_reserved is set for special pages, which can never be swapped out. Some
>> - * of them might not even exist...
>> + * PG_reserved is set for special pages. The "struct page" of such a page
>> + * should in general not be touched (e.g. set dirty) except by their owner.
> 
>                                                                by its owner.

Indeed.

> 
>> + * Pages marked as PG_reserved include:
>> + * - Pages part of the kernel image (including vDSO) and similar (e.g. BIOS,
>> + *   initrd, HW tables)
>> + * - Pages reserved or allocated early during boot (before the page allocator
>> + *   was initialized). This includes (depending on the architecture) the
>> + *   initial vmmap, initial page tables, crashkernel, elfcorehdr, and much
> 
>                 VM map,

This should actually be vmemmap (aka struct pages).

> 
>> + *   much more. Once (if ever) freed, PG_reserved is cleared and they will
>> + *   be given to the page allocator.
>> + * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
>> + *   to read/write these pages might end badly. Don't touch!
>> + * - The zero page(s)
>> + * - Pages not added to the page allocator when onlining a section because
>> + *   they were excluded via the online_page_callback() or because they are
>> + *   PG_hwpoison.
>> + * - Pages allocated in the context of kexec/kdump (loaded kernel image,
>> + *   control pages, vmcoreinfo)
>> + * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
>> + *   not marked PG_reserved (as they might be in use by somebody else who does
>> + *   not respect the caching strategy).
>> + * - Pages part of an offline section (struct pages of offline sections should
>> + *   not be trusted as they will be initialized when first onlined).
>> + * - MCA pages on ia64
>> + * - Pages holding CPU notes for POWER Firmware Assisted Dump
>> + * - Device memory (e.g. PMEM, DAX, HMM)
>> + * Some PG_reserved pages will be excluded from the hibernation image.
>> + * PG_reserved does in general not hinder anybody from dumping or swapping
>> + * and is no longer required for remap_pfn_range(). ioremap might require it.
>> + * Consequently, PG_reserved for a page mapped into user space can indicate
>> + * the zero page, the vDSO, MMIO pages or device memory.
>>   *
>>   * The PG_private bitflag is set on pagecache pages if they contain filesystem
>>   * specific data (which is normally at page->private). It can be used by
>>
> 
> cheers.
> 

Thanks!

-- 

Thanks,

David / dhildenb

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
