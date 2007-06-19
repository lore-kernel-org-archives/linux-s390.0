Return-Path: <linux-kernel-owner+w=401wt.eu-S1757358AbXFSIp6@vger.kernel.org>
Message-Id: <20070619084641.563238581@de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
Date: Tue, 19 Jun 2007 10:45:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/6] Fix zfcpdump header
Content-Disposition: inline; filename=002-zfcp-dumphdr.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Added members for volume number and real memory size to header information.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/zcore.c |    3 +++
 1 file changed, 3 insertions(+)

Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -267,7 +267,9 @@ struct zcore_header {
 	u64 tod;
 	cpuid_t cpu_id;
 	u32 arch_id;
+	u32 volnr;
 	u32 build_arch;
+	u64 rmem_size;
 	char pad2[4016];
 } __attribute__((packed,__aligned__(16)));
 
@@ -559,6 +561,7 @@ static void __init zcore_header_init(int
 	else
 		hdr->arch_id = DUMP_ARCH_S390;
 	hdr->mem_size = sys_info.mem_size;
+	hdr->rmem_size = sys_info.mem_size;
 	hdr->mem_end = sys_info.mem_size;
 	hdr->num_pages = sys_info.mem_size / PAGE_SIZE;
 	hdr->tod = get_clock();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
