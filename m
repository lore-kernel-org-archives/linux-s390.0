Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 9/9] mm: better document PG_reserved
Date: Mon, 14 Jan 2019 13:59:03 +0100
Message-Id: <20190114125903.24845-10-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: linux-mm@kvack.org
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Miles Chen <miles.chen@mediatek.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Pavel Tatashin <pasha.tatashin@oracle.com>, yi.z.zhang@linux.intel.com, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

The usage of PG_reserved and how PG_reserved pages are to be treated is
buried deep down in different parts of the kernel. Let's shine some light
onto these details by documenting current users and expected
behavior.

Especially, clarify on the "Some of them might not even exist" case.
These are physical memory gaps that will never be dumped as they
are not marked as IORESOURCE_SYSRAM. PG_reserved does in general not
hinder anybody from dumping or swapping. In some cases, these pages
will not be stored in the hibernation image.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: yi.z.zhang@linux.intel.com
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 808b4183e30d..9f8712a4b1a5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,8 +17,37 @@
 /*
  * Various page->flags bits:
  *
- * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist...
+ * PG_reserved is set for special pages. The "struct page" of such a page
+ * should in general not be touched (e.g. set dirty) except by its owner.
+ * Pages marked as PG_reserved include:
+ * - Pages part of the kernel image (including vDSO) and similar (e.g. BIOS,
+ *   initrd, HW tables)
+ * - Pages reserved or allocated early during boot (before the page allocator
+ *   was initialized). This includes (depending on the architecture) the
+ *   initial vmemmap, initial page tables, crashkernel, elfcorehdr, and much
+ *   much more. Once (if ever) freed, PG_reserved is cleared and they will
+ *   be given to the page allocator.
+ * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
+ *   to read/write these pages might end badly. Don't touch!
+ * - The zero page(s)
+ * - Pages not added to the page allocator when onlining a section because
+ *   they were excluded via the online_page_callback() or because they are
+ *   PG_hwpoison.
+ * - Pages allocated in the context of kexec/kdump (loaded kernel image,
+ *   control pages, vmcoreinfo)
+ * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
+ *   not marked PG_reserved (as they might be in use by somebody else who does
+ *   not respect the caching strategy).
+ * - Pages part of an offline section (struct pages of offline sections should
+ *   not be trusted as they will be initialized when first onlined).
+ * - MCA pages on ia64
+ * - Pages holding CPU notes for POWER Firmware Assisted Dump
+ * - Device memory (e.g. PMEM, DAX, HMM)
+ * Some PG_reserved pages will be excluded from the hibernation image.
+ * PG_reserved does in general not hinder anybody from dumping or swapping
+ * and is no longer required for remap_pfn_range(). ioremap might require it.
+ * Consequently, PG_reserved for a page mapped into user space can indicate
+ * the zero page, the vDSO, MMIO pages or device memory.
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
