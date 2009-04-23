Return-Path: <linux-kernel-owner+w=401wt.eu-S1754678AbZDWLtw@vger.kernel.org>
Message-Id: <20090423114725.022249915@de.ibm.com>
References: <20090423114638.865214111@de.ibm.com>
Date: Thu, 23 Apr 2009 13:46:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] ipl: fix compile breakage
Content-Disposition: inline; filename=001-ipl-compile-breakage.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix this for !CONFIG_SMP:

arch/s390/kernel/ipl.c: In function 'stop_run':
arch/s390/kernel/ipl.c:1461: error: implicit declaration of function 'signal_processor'

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -23,6 +23,7 @@
 #include <asm/ebcdic.h>
 #include <asm/reset.h>
 #include <asm/sclp.h>
+#include <asm/sigp.h>
 #include <asm/checksum.h>
 
 #define IPL_PARM_BLOCK_VERSION 0

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
