Return-Path: <linux-kernel-owner+w=401wt.eu-S965615AbXLTPeI@vger.kernel.org>
Message-Id: <20071220152108.742197558@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/47] Use new style spinlock initializer in __RWSEM_INITIALIZER.
Content-Disposition: inline; filename=125-rwlock-init.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/rwsem.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/include/asm-s390/rwsem.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/rwsem.h
+++ quilt-2.6/include/asm-s390/rwsem.h
@@ -91,8 +91,8 @@ struct rw_semaphore {
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-  __RWSEM_DEP_MAP_INIT(name) }
+ { RWSEM_UNLOCKED_VALUE, __SPIN_LOCK_UNLOCKED((name).wait.lock), \
+   LIST_HEAD_INIT((name).wait_list) __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
