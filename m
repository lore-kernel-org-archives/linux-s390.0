Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] s390/ubsan: enable UBSAN for s390
Date: Mon, 12 Sep 2016 14:37:20 +0200
In-Reply-To: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
References: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1473683840-8700-3-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Marek <mmarek@suse.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Yang Shi <yang.shi@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This enables UBSAN for s390. We have to disable the null sanitizer
as s390 code does access memory via a null pointer (the prefix page).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/Kconfig                  | 2 ++
 arch/s390/boot/compressed/Makefile | 1 +
 arch/s390/kernel/Makefile          | 3 +++
 arch/s390/kernel/vdso32/Makefile   | 3 ++-
 arch/s390/kernel/vdso64/Makefile   | 3 ++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e49ca114..5862a93 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -74,6 +74,7 @@ config S390
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_SG_CHAIN
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
@@ -110,6 +111,7 @@ config S390
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_PROT_NUMA_PROT_NONE
+	select ARCH_WANTS_UBSAN_NO_NULL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS2
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 13723c3..66f42bb 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -17,6 +17,7 @@ KBUILD_CFLAGS += $(call cc-option,-mpacked-stack)
 KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 OBJECTS := $(addprefix $(objtree)/arch/s390/kernel/, head.o sclp.o ebcdic.o als.o)
 OBJECTS += $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 8bc18eb..30407e6 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -48,6 +48,9 @@ AFLAGS_head.o		+= -march=z900
 endif
 GCOV_PROFILE_sclp.o := n
 GCOV_PROFILE_als.o := n
+UBSAN_SANITIZE_als.o := n
+UBSAN_SANITIZE_early.o := n
+UBSAN_SANITIZE_sclp.o := n
 
 obj-y	:= traps.o time.o process.o base.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 6814545..6cc9478 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -24,8 +24,9 @@ obj-y += vdso32_wrapper.o
 extra-y += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling for VDSO code
+# Disable gcov profiling and ubsan for VDSO code
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 # Force dependency (incbin is bad)
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 0b0fd22..2d54c18 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -24,8 +24,9 @@ obj-y += vdso64_wrapper.o
 extra-y += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling for VDSO code
+# Disable gcov profiling and ubsan for VDSO code
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 # Force dependency (incbin is bad)
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
-- 
2.5.5
