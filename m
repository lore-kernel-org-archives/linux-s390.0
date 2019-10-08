Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC v2] s390/purgatory: Make sure we fail the build if purgatory has missing symbols
Date: Tue,  8 Oct 2019 10:54:21 +0200
Message-Id: <20191008085421.11011-2-hdegoede@redhat.com>
In-Reply-To: <20191008085421.11011-1-hdegoede@redhat.com>
References: <20191008085421.11011-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Since we link purgatory with -r aka we enable "incremental linking"
no checks for unresolved symbols are done while linking the purgatory.

This commit adds an extra check for unresolved symbols by calling ld
without -r before running objcopy to generate purgatory.ro.

This will help us catch missing symbols in the purgatory sooner.

Note this commit also removes --no-undefined from LDFLAGS_purgatory
as that has no effect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Using 2 if_changed lines under a single rule does not work, then
  1 of the 2 will always execute each build.
  Instead add a new (unused) purgatory.chk intermediate which gets
  linked from purgatory.ro without -r to do the missing symbols check
- This also fixes the check generating an a.out file (oops)
---
 arch/s390/purgatory/.gitignore |  1 +
 arch/s390/purgatory/Makefile   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
index 04a03433c720..c82157f46b18 100644
--- a/arch/s390/purgatory/.gitignore
+++ b/arch/s390/purgatory/.gitignore
@@ -1,3 +1,4 @@
 purgatory
+purgatory.chk
 purgatory.lds
 purgatory.ro
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bc0d7a0d0394..13e9a5dc0a07 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -4,7 +4,7 @@ OBJECT_FILES_NON_STANDARD := y
 
 purgatory-y := head.o purgatory.o string.o sha256.o mem.o
 
-targets += $(purgatory-y) purgatory.lds purgatory purgatory.ro
+targets += $(purgatory-y) purgatory.lds purgatory purgatory.chk purgatory.ro
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
@@ -26,15 +26,22 @@ KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 
-LDFLAGS_purgatory := -r --no-undefined -nostdlib -z nodefaultlib -T
+# Since we link purgatory with -r unresolved symbols are not checked, so we
+# also link a purgatory.chk binary without -r to check for unresolved symbols.
+PURGATORY_LDFLAGS := -nostdlib -z nodefaultlib
+LDFLAGS_purgatory := -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
 $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
+$(obj)/purgatory.chk: $(obj)/purgatory FORCE
+		$(call if_changed,ld)
+
 OBJCOPYFLAGS_purgatory.ro := -O elf64-s390
 OBJCOPYFLAGS_purgatory.ro += --remove-section='*debug*'
 OBJCOPYFLAGS_purgatory.ro += --remove-section='.comment'
 OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
-$(obj)/purgatory.ro: $(obj)/purgatory FORCE
+$(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 		$(call if_changed,objcopy)
 
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
-- 
2.23.0
