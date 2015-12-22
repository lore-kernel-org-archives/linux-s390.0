Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] s390: fix build failure
Date: Tue, 22 Dec 2015 12:10:01 +0530
Message-Id: <1450766401-20747-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

s390 defconfig fails with the error:
ERROR: "phys_to_pfn_t" [drivers/s390/block/dcssblk.ko] undefined!

We need CONFIG_HAS_IOMEM for phys_to_pfn_t() and for that we need to
have CONFIG_PCI.

Fixes: bfac97e7b361 ("mm, dax, pmem: introduce pfn_t")
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

s390 defconfig with next-20151222 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/98258271

 arch/s390/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 9256b48..e56b6df 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -207,3 +207,4 @@ CONFIG_CRC7=m
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
 CONFIG_CMM=m
+CONFIG_PCI=y
-- 
1.9.1
