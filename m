Return-Path: <linux-kernel-owner+w=401wt.eu-S934252AbYCEMCY@vger.kernel.org>
Message-Id: <20080305115714.669054011@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/10] Fix IPL from NSS.
Content-Disposition: inline; filename=008-maxorder.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

IPL from NSS didn't work because the memory detection routine omits any
memory sections with a size lower than what MAX_ORDER defines.
This causes the detection routine to skip the first memory segment which
has a size of 1MB. Which later on will let the kernel think that there
is no memory available at all.
Since in addition the z/VM memory increment size is 1MB force MAX_ORDER
to be 9, so we can support 1MB segments.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -351,6 +351,10 @@ endchoice
 
 source "fs/Kconfig.binfmt"
 
+config FORCE_MAX_ZONEORDER
+	int
+	default "9"
+
 config PROCESS_DEBUG
 	bool "Show crashed user process info"
 	help

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
