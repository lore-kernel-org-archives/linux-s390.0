From: Philipp Rudo <prudo@linux.ibm.com>
Date: Tue, 07 Aug 2018 13:33:02 +0000
Subject: [PATCH v2 1/5] zfcpdump: Remove unused macros
Message-Id: <20180807133306.46056-2-prudo@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

There are no more users for these macros. Remove them.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 zipl/include/zipl.h | 2 --
 zipl/src/Makefile   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/zipl/include/zipl.h b/zipl/include/zipl.h
index 2aed54fb..7670a0f9 100644
--- a/zipl/include/zipl.h
+++ b/zipl/include/zipl.h
@@ -48,8 +48,6 @@
 #define MENU_DEFAULT_PROMPT		0
 #define MENU_DEFAULT_TIMEOUT		0
 
-#define FSDUMP_IMAGE	STRINGIFY(ZFCPDUMP_DIR) "/" STRINGIFY(ZFCPDUMP_FS_IMAGE)
-#define FSDUMP_RAMDISK	STRINGIFY(ZFCPDUMP_DIR) "/" STRINGIFY(ZFCPDUMP_FS_RD)
 #define FSDUMP_PART_IMAGE	STRINGIFY(ZFCPDUMP_DIR) "/" \
 					STRINGIFY(ZFCPDUMP_PART_IMAGE)
 #define FSDUMP_PART_RAMDISK	STRINGIFY(ZFCPDUMP_DIR) "/" \
diff --git a/zipl/src/Makefile b/zipl/src/Makefile
index 1634c0d5..f8c36dc2 100644
--- a/zipl/src/Makefile
+++ b/zipl/src/Makefile
@@ -3,8 +3,6 @@ include ../../common.mak
 
 ALL_CPPFLAGS += -I../include -I../boot \
 	    -DZFCPDUMP_DIR=$(ZFCPDUMP_DIR) \
-	    -DZFCPDUMP_FS_IMAGE=$(ZFCPDUMP_FS_IMAGE) \
-	    -DZFCPDUMP_FS_RD=$(ZFCPDUMP_FS_RD) \
 	    -DZFCPDUMP_PART_IMAGE=$(ZFCPDUMP_PART_IMAGE) \
 	    -DZFCPDUMP_PART_RD=$(ZFCPDUMP_PART_RD) \
 	    -D_FILE_OFFSET_BITS=64 $(NO_PIE_CFLAGS)
-- 
2.16.4
