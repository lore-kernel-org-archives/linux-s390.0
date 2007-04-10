Return-Path: <linux-kernel-owner+w=401wt.eu-S1030904AbXDJPrl@vger.kernel.org>
Subject: [Patch] statistics: fix string termination
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 17:47:38 +0200
Message-Id: <1176220058.5572.11.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Make sure strsep() in statistic_release_def() finds a terminanal '\0' and
doesn't attempt to access bytes outside the given buffer.

(Patch fixes
statistics-infrastructure-simplify-statistics-debugfs-write-function.patch)

Patch is against 2.6.21-rc6-mm1.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 statistic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -627,9 +627,10 @@ static ssize_t statistic_write_def(struc
 		return -EPIPE;
 	if (*offset + len > 16 * PAGE_SIZE)
 		return -ENOMEM;
-	larger = kmalloc(*offset + len, GFP_KERNEL);
+	larger = kmalloc(*offset + len + 1, GFP_KERNEL);
 	if (!larger)
 		return -ENOMEM;
+	larger[*offset + len] = '\0';
 	memcpy(larger, seq_priv->w_buf, *offset);
 	if (copy_from_user(larger + *offset, buf, len))
 		return -EFAULT;
