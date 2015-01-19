Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] s390: char: Free memory on error path.
Date: Mon, 19 Jan 2015 23:02:00 +0100
Message-Id: <1421704920-29820-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, rhoppe@de.ibm.com, linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
List-ID: <linux-s390.vger.kernel.org>

Free allocated page in case of error returned by hmcdrv_ftp_startup.

Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
---
 drivers/s390/char/hmcdrv_ftp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/hmcdrv_ftp.c b/drivers/s390/char/hmcdrv_ftp.c
index 4bd6332..f6e00af 100644
--- a/drivers/s390/char/hmcdrv_ftp.c
+++ b/drivers/s390/char/hmcdrv_ftp.c
@@ -199,8 +199,10 @@ int hmcdrv_ftp_probe(void)
 
 	rc = hmcdrv_ftp_startup();
 
-	if (rc)
+	if (rc) {
+		free_page((unsigned long) ftp.buf);
 		return rc;
+	}
 
 	rc = hmcdrv_ftp_do(&ftp);
 	free_page((unsigned long) ftp.buf);
-- 
2.1.0
