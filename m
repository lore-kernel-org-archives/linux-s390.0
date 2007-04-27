Return-Path: <linux-kernel-owner+w=401wt.eu-S1755856AbXD0OPz@vger.kernel.org>
Message-Id: <20070427140512.629629759@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/38] cio: Allow 0 and 1 as input for channel path status attribute.
Content-Disposition: inline; filename=102-cio-chpid01.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Channel path status can now be modified by writing '0' and '1'
to the sysfs status attribute in addition to 'offline' and
'online' respectively.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c	2007-04-27 16:04:52.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/chsc.c	2007-04-27 16:04:53.000000000 +0200
@@ -1169,9 +1169,9 @@
 	if (!num_args)
 		return count;
 
-	if (!strnicmp(cmd, "on", 2))
+	if (!strnicmp(cmd, "on", 2) || !strcmp(cmd, "1"))
 		error = s390_vary_chpid(cp->chpid, 1);
-	else if (!strnicmp(cmd, "off", 3))
+	else if (!strnicmp(cmd, "off", 3) || !strcmp(cmd, "0"))
 		error = s390_vary_chpid(cp->chpid, 0);
 	else
 		error = -EINVAL;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
