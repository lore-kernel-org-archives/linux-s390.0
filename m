Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Date: Fri,  3 Jul 2020 15:39:08 +0200
Message-Id: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This series is based on the latest s390/features branch [1]. It implements
vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
- Freeing empty page tables (now also done for idendity mapping).
- Handling cases where the vmemmap of a section does not fill huge pages
  completely.

vmemmap_free() is currently never used, unless adiing standby memory fails
(unlikely). This is relevant for virtio-mem, which adds/removes memory
in memory block/section granularity (always removes memory in the same
granularity it added it).

I gave this a proper test with my virtio-mem prototype (which I will share
once the basic QEMU implementation is upstream), both with 56 byte memmap
per page and 64 byte memmap per page, with and without huge page support.
In both cases, removing memory (routed through arch_remove_memory()) will
result in
- all populated vmemmap pages to get removed/freed
- all applicable page tables for the vmemmap getting removed/freed
- all applicable page tables for the idendity mapping getting removed/freed
Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
environments.

This is the basis for real memory hotunplug support for s390x and should
complete my journey to s390x vmem/vmemmap code for now :)

What needs double-checking is tlb flushing. AFAIKS, as there are no valid
accesses, doing a single range flush at the end is sufficient, both when
removing vmemmap pages and the idendity mapping.

Along, some minor cleanups.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features

David Hildenbrand (9):
  s390/vmem: rename vmem_add_mem() to vmem_add_range()
  s390/vmem: recursive implementation of vmem_remove_range()
  s390/vmemmap: implement vmemmap_free()
  s390/vmemmap: cleanup when vmemmap_populate() fails
  s390/vmemmap: take the vmem_mutex when populating/freeing
  s390/vmem: cleanup empty page tables
  s390/vmemmap: fallback to PTEs if mapping large PMD fails
  s390/vmemmap: remember unused sub-pmd ranges
  s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive
    sections

 arch/s390/mm/vmem.c | 400 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 338 insertions(+), 62 deletions(-)

-- 
2.26.2
