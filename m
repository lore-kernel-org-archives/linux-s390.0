Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Aug 2011 18:37:02 +0200
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] s390: fix _TIF_SINGLE_STEP definition
Message-ID: <20110818163702.GF20085@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

_TIF_SINGLE_STEP is incorrectly defined as 1<<TIF_FREEZE.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 arch/s390/include/asm/thread_info.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/arch/s390/include/asm/thread_info.h
===================================================================
--- work.orig/arch/s390/include/asm/thread_info.h
+++ work/arch/s390/include/asm/thread_info.h
@@ -117,7 +117,7 @@ static inline struct thread_info *curren
 #define _TIF_SIE		(1<<TIF_SIE)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_31BIT		(1<<TIF_31BIT)
-#define _TIF_SINGLE_STEP	(1<<TIF_FREEZE)
+#define _TIF_SINGLE_STEP	(1<<TIF_SINGLE_STEP)
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
 
 #ifdef CONFIG_64BIT
