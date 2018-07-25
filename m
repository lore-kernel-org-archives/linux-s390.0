From: Philipp Rudo <prudo@linux.ibm.com>
Date: Wed, 25 Jul 2018 11:36:14 +0000
Subject: [PATCH 4/5] zipl: Move macro definition to Makefile
Message-Id: <20180725113615.93755-5-prudo@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In the zipl Makefile macros are defined with the sole purpose to define
other macros in zipl.h. Remove this unnecessary indirection.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
---
 zipl/include/zipl.h | 5 -----
 zipl/src/Makefile   | 5 ++---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/zipl/include/zipl.h b/zipl/include/zipl.h
index fb68ae88..770801e5 100644
--- a/zipl/include/zipl.h
+++ b/zipl/include/zipl.h
@@ -48,11 +48,6 @@
 #define MENU_DEFAULT_PROMPT		0
 #define MENU_DEFAULT_TIMEOUT		0
 
-#define ZFCPDUMP_IMAGE		STRINGIFY(ZFCPDUMP_DIR) "/" \
-					STRINGIFY(ZFCPDUMP_PART_IMAGE)
-#define ZFCPDUMP_INITRD		STRINGIFY(ZFCPDUMP_DIR) "/" \
-					STRINGIFY(ZFCPDUMP_PART_RD)
-
 #define MAX_DUMP_VOLUMES		32
 
 /* Internal component load address type */
diff --git a/zipl/src/Makefile b/zipl/src/Makefile
index b9018b4b..be14fce5 100644
--- a/zipl/src/Makefile
+++ b/zipl/src/Makefile
@@ -2,9 +2,8 @@
 include ../../common.mak
 
 ALL_CPPFLAGS += -I../include -I../boot \
-	    -DZFCPDUMP_DIR=$(ZFCPDUMP_DIR) \
-	    -DZFCPDUMP_PART_IMAGE=$(ZFCPDUMP_IMAGE) \
-	    -DZFCPDUMP_PART_RD=$(ZFCPDUMP_INITRD) \
+	    -DZFCPDUMP_IMAGE="STRINGIFY($(ZFCPDUMP_DIR)/$(ZFCPDUMP_IMAGE))" \
+	    -DZFCPDUMP_INITRD="STRINGIFY($(ZFCPDUMP_DIR)/$(ZFCPDUMP_INITRD))" \
 	    -D_FILE_OFFSET_BITS=64 $(NO_PIE_CFLAGS)
 ALL_LDFLAGS += -Wl,-z,noexecstack $(NO_PIE_LDFLAGS)
 
-- 
2.16.4
