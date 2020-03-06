Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:38408 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgCFRJD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 6 Mar 2020 12:09:03 -0500
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  6 Mar 2020 10:08:46 -0700
Message-Id: <20200306170846.9333-8-logang@deltatee.com>
In-Reply-To: <20200306170846.9333-1-logang@deltatee.com>
References: <20200306170846.9333-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v4 7/7] mm/memremap: Set caching mode for PCI P2PDMA memory to WC
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>

PCI BAR IO memory should never be mapped as WB, however prior to this
the PAT bits were set WB and it was typically overridden by MTRR
registers set by the firmware.

Set PCI P2PDMA memory to be UC as this is what it currently, typically,
ends up being mapped as on x86 after the MTRR registers override the
cache setting.

Future use-cases may need to generalize this by adding flags to
select the caching type, as some P2PDMA cases may not want UC.
However, those use-cases are not upstream yet and this can be changed
when they arrive.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 06742372a203..9033ae401448 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -190,7 +190,10 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		}
 		break;
 	case MEMORY_DEVICE_DEVDAX:
+		need_devmap_managed = false;
+		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		params.pgprot = pgprot_noncached(params.pgprot);
 		need_devmap_managed = false;
 		break;
 	default:
-- 
2.20.1
