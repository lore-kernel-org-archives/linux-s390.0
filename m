Return-Path: <linux-kernel-owner+w=401wt.eu-S1761533AbXHVMdh@vger.kernel.org>
Message-Id: <20070822123642.015644219@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/10] cio: dont forget to set last slot to NULL in ccw_uevent().
Content-Disposition: inline; filename=001-cio-uevent.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/device.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -117,7 +117,10 @@ static int ccw_uevent(struct device *dev
 	snprint_alias(modalias_buf, sizeof(modalias_buf), id, "");
 	ret = add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &len,
 			     "MODALIAS=%s", modalias_buf);
-	return ret;
+	if (ret)
+		return ret;
+	envp[i] = NULL;
+	return 0;
 }
 
 struct bus_type ccw_bus_type;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
