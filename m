Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 2/4] s390: make thin archives not directly depend on *.o.chkbss files
Date: Thu, 17 Jan 2019 19:02:42 +0900
Message-Id: <1547719364-18849-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When I was refactoring cmd_ar_builtin in scripts/Makefile.build,
I noticed the build breakage of s390.

Some Makefiles of s390 add extra dependencies to built-in.a;
built-in.a depends on timestamp files *.o.chkbss, but $(AR) does
not want to include them into built-in.a.

Insert a phony target 'chkbss' in between so that $(AR) can take
$(filter-out $(PHONY), $^) as input.

While I was here, I refactored Makefile.chkbss a little bit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
I want Acked-by from a s390 maintainer so this series can go
into kbuild tree.

Changes in v2:
 - New patch

 arch/s390/boot/Makefile            |  4 ++--
 arch/s390/boot/compressed/Makefile |  4 ++--
 arch/s390/scripts/Makefile.chkbss  | 25 +++++++++++--------------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index d5ad724..b4d8a42 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -67,6 +67,6 @@ install: $(CONFIGURE) $(obj)/bzImage
 	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 	      System.map "$(INSTALL_PATH)"
 
-chkbss := $(OBJECTS)
-chkbss-target := $(obj)/startup.a
+chkbss := $(obj-y)
+chkbss-target := startup.a
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index b1bdd15..fa529c5 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -63,6 +63,6 @@ OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section
 $(obj)/piggy.o: $(obj)/vmlinux.bin$(suffix-y) FORCE
 	$(call if_changed,objcopy)
 
-chkbss := $(filter-out $(obj)/piggy.o $(obj)/info.o,$(OBJECTS))
-chkbss-target := $(obj)/vmlinux.bin
+chkbss := $(filter-out piggy.o info.o, $(obj-y))
+chkbss-target := vmlinux.bin
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
diff --git a/arch/s390/scripts/Makefile.chkbss b/arch/s390/scripts/Makefile.chkbss
index 9bba2c1..cd7e8f44 100644
--- a/arch/s390/scripts/Makefile.chkbss
+++ b/arch/s390/scripts/Makefile.chkbss
@@ -1,23 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0
 
+chkbss-target ?= built-in.a
+$(obj)/$(chkbss-target): chkbss
+
+chkbss-files := $(addsuffix .chkbss, $(chkbss))
+clean-files += $(chkbss-files)
+
+PHONY += chkbss
+chkbss: $(addprefix $(obj)/, $(chkbss-files))
+
 quiet_cmd_chkbss = CHKBSS  $<
-define cmd_chkbss
-	rm -f $@; \
+      cmd_chkbss = \
 	if ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
 		echo "error: $< .bss section is not empty" >&2; exit 1; \
 	fi; \
 	touch $@;
-endef
-
-chkbss-target ?= $(obj)/built-in.a
-ifneq (,$(findstring /,$(chkbss)))
-chkbss-files := $(patsubst %, %.chkbss, $(chkbss))
-else
-chkbss-files := $(patsubst %, $(obj)/%.chkbss, $(chkbss))
-endif
-
-$(chkbss-target): $(chkbss-files)
-targets += $(notdir $(chkbss-files))
 
-%.o.chkbss: %.o
+$(obj)/%.o.chkbss: $(obj)/%.o
 	$(call cmd,chkbss)
-- 
2.7.4
