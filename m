Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390: remove unneeded dependency for gen_facilities
Date: Tue,  8 Nov 2016 10:55:47 +0900
Message-Id: <1478570147-30873-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Paul Bolle <pebolle@tiscali.nl>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The dependency between the object and the source is handled by
scripts/Makefile.host, so only "hostprogs-y += gen_facilities"
is fine.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/tools/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 6d9814c..4b5e1e4 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -9,7 +9,5 @@ define filechk_facilities.h
 	$(obj)/gen_facilities
 endef
 
-$(obj)/gen_facilities.o: $(srctree)/arch/s390/tools/gen_facilities.c
-
 include/generated/facilities.h: $(obj)/gen_facilities FORCE
 	$(call filechk,facilities.h)
-- 
1.9.1
