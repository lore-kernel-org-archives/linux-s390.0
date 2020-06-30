Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbgF3IRl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 04:17:41 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date: Tue, 30 Jun 2020 10:17:28 +0200
Message-Id: <20200630081730.6862-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This is the follow-up of [1]:
	[PATCH RFC 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK

This series is based on the latest s390/features branch, which contains
"s390/zcore: remove memmap device". [2]

Looking into why we still create memblocks for stdnaby/hotplugged memory
(via add_memory()), I discovered that we might not need ARCH_KEEP_MEMBLOCK
on s390x after all.

This is relevant in the context of virtio-mem, where we hotplug a lot of
small memory blocks (and want to avoid managing unused metadata). But also
for existing setups, it might help to free up some memory after boot.

Compile-tested on s390x, pseries, arm64, i386, mips64, powernv, sh, and
x86_64.

[1] https://lkml.kernel.org/r/20200417150151.17239-1-david@redhat.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features

RFC -> v1:
- "s390/zcore: traverse resources instead of memblocks" has been replaced
  on s390/features by "s390/zcore: remove memmap devic"
- Add "mm/memblock: expose only miminal interface to add/walk physmem"
-- Sort out section mismatch errors when using physmem after boot without
   ARCH_KEEP_MEMBLOCK
- "s390/mm: don't set ARCH_KEEP_MEMBLOCK"
-- Rephrase description

David Hildenbrand (2):
  mm/memblock: expose only miminal interface to add/walk physmem
  s390/mm: don't set ARCH_KEEP_MEMBLOCK

 arch/s390/Kconfig             |  1 -
 arch/s390/kernel/crash_dump.c |  6 ++--
 include/linux/memblock.h      | 17 +++++++---
 mm/memblock.c                 | 63 +++++++++++++++++++----------------
 4 files changed, 50 insertions(+), 37 deletions(-)

-- 
2.26.2
