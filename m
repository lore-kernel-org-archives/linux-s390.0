From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:36 +0000
Subject: [CRIU][PATCH v2 08/17] s390: Enable s390 build in Makefile
Message-Id: <20170629192445.55580-9-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cfc5870..848cf0f 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ UNAME-M := $(shell uname -m)
 
 #
 # Supported Architectures
-ifneq ($(filter-out x86 arm aarch64 ppc64,$(ARCH)),)
+ifneq ($(filter-out x86 arm aarch64 ppc64 s390,$(ARCH)),)
         $(error "The architecture $(ARCH) isn't supported")
 endif
 
@@ -65,6 +65,13 @@ ifeq ($(ARCH),x86)
         DEFINES		:= -DCONFIG_X86_64
 endif
 
+ifeq ($(ARCH),s390)
+        ARCH		:= s390
+        SRCARCH		:= s390
+        VDSO		:= y
+        DEFINES		:= -DCONFIG_S390
+endif
+
 LDARCH ?= $(SRCARCH)
 export LDARCH VDSO
 export PROTOUFIX DEFINES
-- 
2.7.4
