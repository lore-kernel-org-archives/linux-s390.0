Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] s390: delete unneeded #include <linux/kconfig.h> from facilities_src.h
Date: Sun,  6 Nov 2016 12:45:27 +0900
Message-Id: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The header facilities_src.h is only included from gen_facilities.c
and the tool is compiled with the following extra options:

    HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)

Please note $(LINUXINCLUDE) is expanded into build options including:

    -include $(srctree)/include/linux/kconfig.h

So, the Makefile always forces the tool to include kconfig.h, i.e.,
the #include <linux/kconfig.h> directive in the header is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/asm/facilities_src.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/include/asm/facilities_src.h b/arch/s390/include/asm/facilities_src.h
index 3b758f6..8b1a692 100644
--- a/arch/s390/include/asm/facilities_src.h
+++ b/arch/s390/include/asm/facilities_src.h
@@ -6,8 +6,6 @@
 #error "This file can only be included by gen_facilities.c"
 #endif
 
-#include <linux/kconfig.h>
-
 struct facility_def {
 	char *name;
 	int *bits;
-- 
1.9.1
