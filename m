Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESSWh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 May 2020 14:22:37 -0400
From: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] s390/sclp_vt220: Fix console name to match device
Date: Tue, 19 May 2020 20:16:54 +0200
Message-Id: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Vidic <vvidic@valentin-vidic.from.hr>, stable@vger.kernel.org

Console name reported in /proc/consoles:

  ttyS1                -W- (EC p  )    4:65

does not match device name:

  crw--w----    1 root     root        4,  65 May 17 12:18 /dev/ttysclp0

so debian-installer gets confused and fails to start.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc: stable@vger.kernel.org
---
 drivers/s390/char/sclp_vt220.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 3f9a6ef650fa..3c2ed6d01387 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -35,8 +35,8 @@
 #define SCLP_VT220_MINOR		65
 #define SCLP_VT220_DRIVER_NAME		"sclp_vt220"
 #define SCLP_VT220_DEVICE_NAME		"ttysclp"
-#define SCLP_VT220_CONSOLE_NAME		"ttyS"
-#define SCLP_VT220_CONSOLE_INDEX	1	/* console=ttyS1 */
+#define SCLP_VT220_CONSOLE_NAME		"ttysclp"
+#define SCLP_VT220_CONSOLE_INDEX	0	/* console=ttysclp0 */
 
 /* Representation of a single write request */
 struct sclp_vt220_request {
-- 
2.20.1
