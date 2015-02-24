Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ameen Ali <ameenali023@gmail.com>
Subject: [PATCH] dcssblk.c : Array index 'i' is used before limits check.
Date: Tue, 24 Feb 2015 18:41:50 +0200
Message-Id: <1424796110-7736-1-git-send-email-ameenali023@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, keescook@chromium.org, wsa@the-dreams.de
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ameen Ali <ameenali023@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

avoid out-of-bounds-read by checking count before indexing.

Signed-off-by : Ameen Ali <Ameenali023@gmail.com>
---
 drivers/s390/block/dcssblk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 96128cb..da21281 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -547,7 +547,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	 * parse input
 	 */
 	num_of_segments = 0;
-	for (i = 0; ((buf[i] != '\0') && (buf[i] != '\n') && i < count); i++) {
+	for (i = 0; (i < count && (buf[i] != '\0') && (buf[i] != '\n')); i++) {
 		for (j = i; (buf[j] != ':') &&
 			(buf[j] != '\0') &&
 			(buf[j] != '\n') &&
-- 
2.1.0
