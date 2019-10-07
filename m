Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfJGSHH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Oct 2019 14:07:07 -0400
From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC] s390/purgatory: Make sure we fail the build if purgatory has missing symbols
Date: Mon,  7 Oct 2019 20:07:03 +0200
Message-Id: <20191007180703.3678-2-hdegoede@redhat.com>
In-Reply-To: <20191007180703.3678-1-hdegoede@redhat.com>
References: <20191007180703.3678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Since we link purgatory with -r aka we enable "incremental linking"
no checks for unresolved symbols are done while linking the purgatory.

This commit adds an extra check for unresolved symbols by calling ld
without -r before running objcopy to generate purgatory.ro.

This will help us catch missing symbols in the purgatory sooner.

Note this commit also removes --no-undefined from LDFLAGS_purgatory.ro
as that has no effect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/s390/purgatory/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bc0d7a0d0394..d5405fe7b2e2 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -26,15 +26,21 @@ KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 
-LDFLAGS_purgatory := -r --no-undefined -nostdlib -z nodefaultlib -T
+LDFLAGS_purgatory := -r -nostdlib -z nodefaultlib -T
 $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
+# Since we link purgatory with -r unresolved symbols are not checked,
+# so we check this before generating purgatory.ro instead
+quiet_cmd_check_purgatory = CHK     $<
+      cmd_check_purgatory = ld -e purgatory_start $<
+
 OBJCOPYFLAGS_purgatory.ro := -O elf64-s390
 OBJCOPYFLAGS_purgatory.ro += --remove-section='*debug*'
 OBJCOPYFLAGS_purgatory.ro += --remove-section='.comment'
 OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
 $(obj)/purgatory.ro: $(obj)/purgatory FORCE
+		$(call if_changed,check_purgatory)
 		$(call if_changed,objcopy)
 
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
-- 
2.23.0
