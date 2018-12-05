Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 5 Dec 2018 06:35:10 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC 7/7] mm: better document PG_reserved
Message-ID: <20181205143510.GA17232@bombadil.infradead.org>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-8-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205122851.5891-8-david@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, yi.z.zhang@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 05, 2018 at 01:28:51PM +0100, David Hildenbrand wrote:
> I don't see a reason why we have to document "Some of them might not even
> exist". If there is a user, we should document it. E.g. for balloon
> drivers we now use PG_offline to indicate that a page might currently
> not be backed by memory in the hypervisor. And that is independent from
> PG_reserved.

I think you're confused by the meaning of "some of them might not even
exist".  What this means is that there might not be memory there; maybe
writes to that memory will be discarded, or maybe they'll cause a machine
check.  Maybe reads will return ~0, or 0, or cause a machine check.
We just don't know what's there, and we shouldn't try touching the memory.

> +++ b/include/linux/page-flags.h
> @@ -17,8 +17,22 @@
>  /*
>   * Various page->flags bits:
>   *
> - * PG_reserved is set for special pages, which can never be swapped out. Some
> - * of them might not even exist...
> + * PG_reserved is set for special pages. The "struct page" of such a page
> + * should in general not be touched (e.g. set dirty) except by their owner.
> + * Pages marked as PG_reserved include:
> + * - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
> + * - Pages allocated early during boot (bootmem, memblock)
> + * - Zero pages
> + * - Pages that have been associated with a zone but are not available for
> + *   the page allocator (e.g. excluded via online_page_callback())
> + * - Pages to exclude from the hibernation image (e.g. loaded kexec images)
> + * - MMIO pages (communicate with a device, special caching strategy needed)
> + * - MCA pages on ia64 (pages with memory errors)
> + * - Device memory (e.g. PMEM, DAX, HMM)
> + * Some architectures don't allow to ioremap pages that are not marked
> + * PG_reserved (as they might be in use by somebody else who does not respect
> + * the caching strategy). Consequently, PG_reserved for a page mapped into
> + * user space can indicate the zero page, the vDSO, MMIO pages or device memory.

So maybe just add one more option to the list.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
