Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:56032 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfLITOF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 9 Dec 2019 14:14:05 -0500
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  9 Dec 2019 12:13:46 -0700
Message-Id: <20191209191346.5197-7-logang@deltatee.com>
In-Reply-To: <20191209191346.5197-1-logang@deltatee.com>
References: <20191209191346.5197-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 6/6] mm/memremap: Set caching mode for PCI P2PDMA memory to WC
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>

PCI BAR IO memory should never be mapped as WB, however prior to this
the PAT bits were set WB and it was typically overridden by MTRR
registers set by the firmware.

Set PCI P2PDMA memory to be WC (writecombining) as the only current
user (the NVMe CMB) was originally mapped WC before the P2PDMA code
replaced the mapping with devm_memremap_pages().

Future use-cases may need to generalize this by adding flags to
select the caching type, as some P2PDMA cases will not want WC.
However, those use-cases are not upstream yet and this can be changed
when they arrive.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 mm/memremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 4edcca074e15..ced32593e4a7 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -187,7 +187,10 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		}
 		break;
 	case MEMORY_DEVICE_DEVDAX:
+		need_devmap_managed = false;
+		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		pgprot = pgprot_writecombine(pgprot);
 		need_devmap_managed = false;
 		break;
 	default:
-- 
2.20.1
