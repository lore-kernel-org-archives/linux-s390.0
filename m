Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 13 Dec 2015 20:51:49 +0200
From: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
Subject: [PATCH] s390: char: constify hmcdrv_ftp_ops structs
Message-ID: <20151213185149.GA24510@waves>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Julia Lawall <julia.lawall@lip6.fr>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Constifies hmcdrv_ftp_ops structures in s390's char
driver since they are not modified after their
initialization.

Detected and found using Coccinelle.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
---
 drivers/s390/char/hmcdrv_ftp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_ftp.c b/drivers/s390/char/hmcdrv_ftp.c
index d4b61d9..8cb7d8f 100644
--- a/drivers/s390/char/hmcdrv_ftp.c
+++ b/drivers/s390/char/hmcdrv_ftp.c
@@ -37,7 +37,7 @@ struct hmcdrv_ftp_ops {
 static enum hmcdrv_ftp_cmdid hmcdrv_ftp_cmd_getid(const char *cmd, int len);
 static int hmcdrv_ftp_parse(char *cmd, struct hmcdrv_ftp_cmdspec *ftp);
 
-static struct hmcdrv_ftp_ops *hmcdrv_ftp_funcs; /* current operations */
+static const struct hmcdrv_ftp_ops *hmcdrv_ftp_funcs; /* current operations */
 static DEFINE_MUTEX(hmcdrv_ftp_mutex); /* mutex for hmcdrv_ftp_funcs */
 static unsigned hmcdrv_ftp_refcnt; /* start/shutdown reference counter */
 
@@ -290,13 +290,13 @@ ssize_t hmcdrv_ftp_cmd(char __kernel *cmd, loff_t offset,
  */
 int hmcdrv_ftp_startup(void)
 {
-	static struct hmcdrv_ftp_ops hmcdrv_ftp_zvm = {
+	static const struct hmcdrv_ftp_ops hmcdrv_ftp_zvm = {
 		.startup = diag_ftp_startup,
 		.shutdown = diag_ftp_shutdown,
 		.transfer = diag_ftp_cmd
 	};
 
-	static struct hmcdrv_ftp_ops hmcdrv_ftp_lpar = {
+	static const struct hmcdrv_ftp_ops hmcdrv_ftp_lpar = {
 		.startup = sclp_ftp_startup,
 		.shutdown = sclp_ftp_shutdown,
 		.transfer = sclp_ftp_cmd
-- 
2.4.3


-- 
Kind Regards,
Aya Saif El-yazal Mahfouz
