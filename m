Return-Path: <linux-kernel-owner+w=401wt.eu-S1030914AbXDJPvg@vger.kernel.org>
Subject: [Patch] statistics: small cleanup in debugfs write function
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 17:51:33 +0200
Message-Id: <1176220293.5572.16.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Code looks more sane with this little cleanup, although both memcpy()
and kfree() are supposed to cope with NULL pointer or zero length
respectively.

(Patch cleans up
statistics-infrastructure-simplify-statistics-debugfs-write-function.patch)

Patch is against 2.6.21-rc6-mm1.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 statistic.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -631,11 +631,13 @@ static ssize_t statistic_write_def(struc
 	if (!larger)
 		return -ENOMEM;
 	larger[*offset + len] = '\0';
-	memcpy(larger, seq_priv->w_buf, *offset);
+	if (seq_priv->w_buf) {
+		memcpy(larger, seq_priv->w_buf, *offset);
+		kfree(seq_priv->w_buf);
+	}
 	if (copy_from_user(larger + *offset, buf, len))
 		return -EFAULT;
 	*offset += len;
-	kfree(seq_priv->w_buf);
 	seq_priv->w_buf = larger;
 	seq_priv->w_offset = *offset;
 	return len;
