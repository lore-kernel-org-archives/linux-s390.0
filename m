Return-Path: <linux-kernel-owner+w=401wt.eu-S1765287AbYEFQDS@vger.kernel.org>
Message-Id: <20080506155111.984508377@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/8] s390mach compile warning
Content-Disposition: inline; filename=005-cio-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix the following compile warning:

drivers/s390/s390mach.c: In function 's390_collect_crw_info':
drivers/s390/s390mach.c:77: warning: ignoring return value of 'down_interruptibl

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/s390mach.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/s390mach.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.c
+++ quilt-2.6/drivers/s390/s390mach.c
@@ -48,10 +48,11 @@ s390_collect_crw_info(void *param)
 	int ccode;
 	struct semaphore *sem;
 	unsigned int chain;
+	int ignore;
 
 	sem = (struct semaphore *)param;
 repeat:
-	down_interruptible(sem);
+	ignore = down_interruptible(sem);
 	chain = 0;
 	while (1) {
 		if (unlikely(chain > 1)) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
