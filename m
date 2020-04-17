Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53770 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbgDQPCG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 11:02:06 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date: Fri, 17 Apr 2020 17:01:51 +0200
Message-Id: <20200417150151.17239-3-david@redhat.com>
In-Reply-To: <20200417150151.17239-1-david@redhat.com>
References: <20200417150151.17239-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
	"The original bootmem allocator is getting replaced by memblock. To
	cover the needs of the s390 kdump implementation the physical
	memory list is used."

zcore was converted to use resources instead of memblocks.
memblock_discard() will *not* mess with "physmem", only with "memory" and
"reserved" memblocks. So, that data will stay after early boot, to be
used in arch/s390/kernel/crash_dump.c to create the ELF header from
inside the 2nd (a.k.a. dumping) kernel.

We no longer need ARCH_KEEP_MEMBLOCK.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8206b2c19aa8..122bf4cad8a5 100644
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
--=20
2.25.1
