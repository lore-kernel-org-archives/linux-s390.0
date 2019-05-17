Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/4] s390: drop unneeded -Wall addition from tools Makefile
Date: Fri, 17 May 2019 16:54:25 +0900
Message-Id: <20190517075428.13496-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190517075428.13496-1-yamada.masahiro@socionext.com>
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The top level Makefile adds -Wall globally for all host tools:

  KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \

I see two "-Wall" added for compiling these tools.

Of course, it is allowed to pass the same option multiple times, but
we do not need to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/tools/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 4ff6a2124522..8fb66c99840a 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -14,8 +14,7 @@ kapi:	$(kapi-hdrs-y)
 hostprogs-y		    += gen_facilities
 hostprogs-y		    += gen_opcode_table
 
-HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
-HOSTCFLAGS_gen_opcode_table.o += -Wall
+HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)
 
 # Ensure output directory exists
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
-- 
2.17.1
