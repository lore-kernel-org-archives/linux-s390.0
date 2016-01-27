Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] debugobjects: Allow bigger number of objects
Date: Wed, 27 Jan 2016 15:37:58 +0100
Message-Id: <1453905478-13409-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On my bigger s390 systems  I always get "Out of memory.
ODEBUG disabled". Since the number of objects is needed at
compile time, we can not change the size dynamically before
the caches etc are available. Doubling the size seems to
do the trick. Since it is init data it will be freed anyway,
this should be ok.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 547f7f9..519b5a1 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -21,7 +21,7 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE	512
+#define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
-- 
2.3.0
