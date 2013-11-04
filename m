Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] s390: remove unused Kconfig parameters
Date: Mon,  4 Nov 2013 10:43:39 +0100
Message-Id: <1383558219-5223-1-git-send-email-michael.opdenacker@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>
List-ID: <linux-s390.vger.kernel.org>

This removes the HAVE_MARCH_Z900_FEATURES and
HAVE_MARCH_Z990_FEATURES Kconfig parameters,
which were no longer used anywhere in the source code
and Makefiles.

Actually, HAVE_MARCH_Z990_FEATURES is no longer used
after removing HAVE_MARCH_Z900_FEATURES.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/s390/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7143793859fa..df2182d35376 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -153,16 +153,8 @@ source "kernel/Kconfig.freezer"
 
 menu "Processor type and features"
 
-config HAVE_MARCH_Z900_FEATURES
-	def_bool n
-
-config HAVE_MARCH_Z990_FEATURES
-	def_bool n
-	select HAVE_MARCH_Z900_FEATURES
-
 config HAVE_MARCH_Z9_109_FEATURES
 	def_bool n
-	select HAVE_MARCH_Z990_FEATURES
 
 config HAVE_MARCH_Z10_FEATURES
 	def_bool n
@@ -189,7 +181,6 @@ config MARCH_G5
 
 config MARCH_Z900
 	bool "IBM zSeries model z800 and z900"
-	select HAVE_MARCH_Z900_FEATURES if 64BIT
 	help
 	  Select this to enable optimizations for model z800/z900 (2064 and
 	  2066 series). This will enable some optimizations that are not
@@ -197,7 +188,6 @@ config MARCH_Z900
 
 config MARCH_Z990
 	bool "IBM zSeries model z890 and z990"
-	select HAVE_MARCH_Z990_FEATURES if 64BIT
 	help
 	  Select this to enable optimizations for model z890/z990 (2084 and
 	  2086 series). The kernel will be slightly faster but will not work
-- 
1.8.1.2
