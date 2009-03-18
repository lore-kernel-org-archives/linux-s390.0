Return-Path: <linux-kernel-owner+w=401wt.eu-S1756587AbZCRMt2@vger.kernel.org>
Message-Id: <20090318124845.179144118@de.ibm.com>
References: <20090318124829.637003183@de.ibm.com>
Date: Wed, 18 Mar 2009 13:48:31 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/6] topology: define SD_MC_INIT to fix performance regression
Content-Disposition: inline; filename=002-sd-mc-init.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The default values for SD_MC_INIT cause an additional cpu usage of up
to 40% on some network benchmarks compared to the plain SD_CPU_INIT
values. So just define SD_MC_INIT to SD_CPU_INIT.
More tuning needs to be done.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/topology.h |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/arch/s390/include/asm/topology.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/topology.h
+++ quilt-2.6/arch/s390/include/asm/topology.h
@@ -30,6 +30,8 @@ static inline void s390_init_cpu_topolog
 };
 #endif
 
+#define SD_MC_INIT SD_CPU_INIT
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_S390_TOPOLOGY_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
