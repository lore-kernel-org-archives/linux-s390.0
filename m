Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/12] s390: make chkbss work with clang
Date: Mon,  8 Apr 2019 23:26:24 +0200
Message-Id: <20190408212648.2407234-11-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

llvm skips an empty .bss section entirely, which makes
the check fail with an unexpected error:

/tmp/binutils-multi-test/bin/s390x-linux-gnu-objdump: section '.bss' mentioned in a -j option, but not found in any input file
error: arch/s390/boot/compressed/decompressor.o .bss section is not empty
../arch/s390/scripts/Makefile.chkbss:20: recipe for target 'arch/s390/boot/compressed/decompressor.o.chkbss' failed

Change the check so we first see if a .bss section exists
before trying to read its size.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/scripts/Makefile.chkbss | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/scripts/Makefile.chkbss b/arch/s390/scripts/Makefile.chkbss
index cd7e8f4419f5..884a9caff5fb 100644
--- a/arch/s390/scripts/Makefile.chkbss
+++ b/arch/s390/scripts/Makefile.chkbss
@@ -11,7 +11,8 @@ chkbss: $(addprefix $(obj)/, $(chkbss-files))
 
 quiet_cmd_chkbss = CHKBSS  $<
       cmd_chkbss = \
-	if ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
+	if $(OBJDUMP) -h $< | grep -q "\.bss" && \
+	   ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
 		echo "error: $< .bss section is not empty" >&2; exit 1; \
 	fi; \
 	touch $@;
-- 
2.20.0
