Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:51274 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgAGVAP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:15 -0500
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  7 Jan 2020 13:59:52 -0700
Message-Id: <20200107205959.7575-2-logang@deltatee.com>
In-Reply-To: <20200107205959.7575-1-logang@deltatee.com>
References: <20200107205959.7575-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v2 1/8] mm/memory_hotplug: Drop the flags field from struct mhp_restrictions
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>

This variable is not used anywhere and should therefore be removed
from the structure.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/memory_hotplug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ba0dca6aac6e..e47a29761088 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -55,11 +55,9 @@ enum {
 
 /*
  * Restrictions for the memory hotplug:
- * flags:  MHP_ flags
  * altmap: alternative allocator for memmap array
  */
 struct mhp_restrictions {
-	unsigned long flags;
 	struct vmem_altmap *altmap;
 };
 
-- 
2.20.1
