Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] s390/purgatory: Make sure we fail the build if purgatory has missing symbols
Date: Thu, 12 Dec 2019 21:53:04 +0100
Message-Id: <20191212205304.191610-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

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

diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitign=
ore
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
@@ -4,7 +4,7 @@ OBJECT_FILES_NON_STANDARD :=3D y
=20
 purgatory-y :=3D head.o purgatory.o string.o sha256.o mem.o
=20
-targets +=3D $(purgatory-y) purgatory.lds purgatory purgatory.ro
+targets +=3D $(purgatory-y) purgatory.lds purgatory purgatory.chk purgat=
ory.ro
 PURGATORY_OBJS =3D $(addprefix $(obj)/,$(purgatory-y))
=20
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
@@ -26,15 +26,22 @@ KBUILD_CFLAGS +=3D $(CLANG_FLAGS)
 KBUILD_CFLAGS +=3D $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS :=3D $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
=20
-LDFLAGS_purgatory :=3D -r --no-undefined -nostdlib -z nodefaultlib -T
+# Since we link purgatory with -r unresolved symbols are not checked, so=
 we
+# also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
+PURGATORY_LDFLAGS :=3D -nostdlib -z nodefaultlib
+LDFLAGS_purgatory :=3D -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.chk :=3D -e purgatory_start $(PURGATORY_LDFLAGS)
 $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
=20
+$(obj)/purgatory.chk: $(obj)/purgatory FORCE
+		$(call if_changed,ld)
+
 OBJCOPYFLAGS_purgatory.ro :=3D -O elf64-s390
 OBJCOPYFLAGS_purgatory.ro +=3D --remove-section=3D'*debug*'
 OBJCOPYFLAGS_purgatory.ro +=3D --remove-section=3D'.comment'
 OBJCOPYFLAGS_purgatory.ro +=3D --remove-section=3D'.note.*'
-$(obj)/purgatory.ro: $(obj)/purgatory FORCE
+$(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 		$(call if_changed,objcopy)
=20
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro F=
ORCE
--=20
2.23.0
