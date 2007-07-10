Return-Path: <linux-kernel-owner+w=401wt.eu-S1761460AbXGJJ2m@vger.kernel.org>
Message-Id: <20070710093041.472843538@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/16] vmcp cleanup
Content-Disposition: inline; filename=001-vmcp-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Robert P. J. Day <rpjday@mindspring.com>

No need to use the "&" prefix and, since you're calling nonseekable_open(),
there is no need to use no_llseek().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmcp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmcp.c
+++ quilt-2.6/drivers/s390/char/vmcp.c
@@ -175,13 +175,12 @@ static long vmcp_ioctl(struct file *file
 
 static const struct file_operations vmcp_fops = {
 	.owner		= THIS_MODULE,
-	.open		= &vmcp_open,
-	.release	= &vmcp_release,
-	.read		= &vmcp_read,
-	.llseek		= &no_llseek,
-	.write		= &vmcp_write,
-	.unlocked_ioctl	= &vmcp_ioctl,
-	.compat_ioctl	= &vmcp_ioctl
+	.open		= vmcp_open,
+	.release	= vmcp_release,
+	.read		= vmcp_read,
+	.write		= vmcp_write,
+	.unlocked_ioctl	= vmcp_ioctl,
+	.compat_ioctl	= vmcp_ioctl
 };
 
 static struct miscdevice vmcp_dev = {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
