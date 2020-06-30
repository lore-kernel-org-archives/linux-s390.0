Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731064AbgF3IRr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jun 2020 04:17:47 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date: Tue, 30 Jun 2020 10:17:30 +0200
Message-Id: <20200630081730.6862-3-david@redhat.com>
In-Reply-To: <20200630081730.6862-1-david@redhat.com>
References: <20200630081730.6862-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
	"The original bootmem allocator is getting replaced by memblock. To
	cover the needs of the s390 kdump implementation the physical
	memory list is used."

As we can now reference "physmem" managed in the memblock allocator after
init even without ARCH_KEEP_MEMBLOCK, and s390x does no longer need
other memblock metadata after boot (esp., the zcore memmap device that used
it got removed), we can stop setting ARCH_KEEP_MEMBLOCK.

With this change, we no longer create memblocks for standby/hotplugged
memory (added via add_memory()) and free up memblock metdata (except
physmem) after boot.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c7d7ede6300c5..7697a1f8e819a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -102,7 +102,6 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_BH
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
-	select ARCH_KEEP_MEMBLOCK
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.26.2
