Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] mm/sparse.c: mark populate_section_memmap as __meminit
Date: Wed, 30 Oct 2019 16:16:39 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191030151639.41486-1-iii@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>

Building the kernel on s390 with -Og produces the following warning:

WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from the function populate_section_memmap() to the function .meminit.text:__populate_section_memmap()
The function populate_section_memmap() references
the function __meminit __populate_section_memmap().
This is often because populate_section_memmap lacks a __meminit
annotation or the annotation of __populate_section_memmap is wrong.

While -Og is not supported, in theory this might still happen with
another compiler or on another architecture. So fix this by using the
correct section annotations.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1 -> v2: Do not touch mm/sparse.c version of __populate_section_memmap:
its __init annotation is correct, since it is only called during init
phase (by sparse_init_nid), and contains the call to another __init
function. Spotted by kbuild test robot <lkp@intel.com> and Oscar
Salvador <osalvador@suse.de>.

I was notified that v1 has already been included into
http://ozlabs.org/~akpm/mmots/broken-out. Since this is not a git
repository, I've decided to send a v2 instead of the fix. Please let me
know if I should send a fix instead.

 mm/sparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index f6891c1992b1..c2c01b6330af 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static struct page *populate_section_memmap(unsigned long pfn,
+static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
@@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
 	vmemmap_free(start, end, NULL);
 }
 #else
-struct page *populate_section_memmap(unsigned long pfn,
+struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	struct page *page, *ret;
-- 
2.23.0
