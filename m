Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:49712 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgBPOsq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 16 Feb 2020 09:48:46 -0500
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] s390: make 'install' not depend on vmlinux
Date: Sun, 16 Feb 2020 23:48:29 +0900
Message-Id: <20200216144829.27023-1-masahiroy@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org

For the same reason as commit 19514fc665ff ("arm, kbuild: make "make
install" not depend on vmlinux"), the install targets should never
trigger the rebuild of the kernel.

The variable, CONFIGURE, is not set by anyone. Remove it as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/Makefile      | 2 +-
 arch/s390/boot/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e0e3a465bbfd..8dfa2cf1f05c 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -146,7 +146,7 @@ all: bzImage
 #KBUILD_IMAGE is necessary for packaging targets like rpm-pkg, deb-pkg...
 KBUILD_IMAGE	:= $(boot)/bzImage
 
-install: vmlinux
+install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 bzImage: vmlinux
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index e2c47d3a1c89..0ff9261c915e 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -70,7 +70,7 @@ $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
 $(obj)/startup.a: $(OBJECTS) FORCE
 	$(call if_changed,ar)
 
-install: $(CONFIGURE) $(obj)/bzImage
+install:
 	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 	      System.map "$(INSTALL_PATH)"
 
-- 
2.17.1
