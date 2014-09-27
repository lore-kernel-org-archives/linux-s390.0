Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] s390: remove unused Kconfig params
Date: Sat, 27 Sep 2014 08:25:30 +0200
Message-Id: <1411799130-17875-1-git-send-email-michael.opdenacker@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>
List-ID: <linux-s390.vger.kernel.org>

Remove the below Kconfig parameters, which are no longer
used anywhere in the source code and Makefiles:

HAVE_MARCH_Z900_FEATURES
HAVE_MARCH_Z990_FEATURES

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/s390/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 05c78bb5f570..d8085a9e9ebd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -156,16 +156,8 @@ source "kernel/Kconfig.freezer"
 
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
@@ -192,7 +184,6 @@ config MARCH_G5
 
 config MARCH_Z900
 	bool "IBM zSeries model z800 and z900"
-	select HAVE_MARCH_Z900_FEATURES if 64BIT
 	help
 	  Select this to enable optimizations for model z800/z900 (2064 and
 	  2066 series). This will enable some optimizations that are not
@@ -200,7 +191,6 @@ config MARCH_Z900
 
 config MARCH_Z990
 	bool "IBM zSeries model z890 and z990"
-	select HAVE_MARCH_Z990_FEATURES if 64BIT
 	help
 	  Select this to enable optimizations for model z890/z990 (2084 and
 	  2086 series). The kernel will be slightly faster but will not work
-- 
1.9.1
