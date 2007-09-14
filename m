From: "Robert P. J. Day" <rpjday@mindspring.com>
Date: Fri, 14 Sep 2007 10:54:12 +0000
Subject: [PATCH] S390:  Remove obsolete recommendation for 8M ramdisk size.
Message-Id: <Pine.LNX.4.64.0709140653050.19294@localhost.localdomain>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 4245b7f..ca4d7f0 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -361,8 +361,7 @@ config BLK_DEV_RAM_SIZE
 	default "4096"
 	help
 	  The default value is 4096 kilobytes. Only change this if you know
-	  what are you doing. If you are using IBM S/390, then set this to
-	  8192.
+	  what are you doing.

 config BLK_DEV_RAM_BLOCKSIZE
 	int "Default RAM disk block size (bytes)"
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
