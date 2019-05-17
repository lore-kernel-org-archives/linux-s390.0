Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/4] s390: drop redundant directory creation from tools Makefile
Date: Fri, 17 May 2019 16:54:26 +0900
Message-Id: <20190517075428.13496-3-yamada.masahiro@socionext.com>
In-Reply-To: <20190517075428.13496-1-yamada.masahiro@socionext.com>
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

As you can see in scripts/Kbuild.include, the filechk creates the
parent directory of the target as needed.

This Makefile does not need to explicitly create the directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/tools/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 8fb66c99840a..4864ea5e6ceb 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -16,9 +16,6 @@ hostprogs-y		    += gen_opcode_table
 
 HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)
 
-# Ensure output directory exists
-_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
-
 filechk_facility-defs.h = $(obj)/gen_facilities
 
 filechk_dis-defs.h = \
-- 
2.17.1
