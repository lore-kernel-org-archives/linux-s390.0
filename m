Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084453.237600492@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/32] [PATCH] correct vdso version string
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=128-vdso-version-string.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The glibc vdso code for s390 uses the version string 2.6.29, the
kernel uses the version string 2.6.26. No wonder the vdso code
is never used. The first kernel version to contain the vdso code
is 2.6.29 which makes this the correct version.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/vdso.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/vdso.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/vdso.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/vdso.h	2010-02-24 09:44:29.000000000 +0100
@@ -7,7 +7,7 @@
 #define VDSO32_LBASE	0
 #define VDSO64_LBASE	0
 
-#define VDSO_VERSION_STRING	LINUX_2.6.26
+#define VDSO_VERSION_STRING	LINUX_2.6.29
 
 #ifndef __ASSEMBLY__
 
