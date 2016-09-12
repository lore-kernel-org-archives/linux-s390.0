Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] ubsan: allow to disable the null sanitizer
Date: Mon, 12 Sep 2016 14:37:19 +0200
In-Reply-To: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
References: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1473683840-8700-2-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Marek <mmarek@suse.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Yang Shi <yang.shi@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some architectures use a hardware defined struct at address zero.
Checking for a null pointer will result in many ubsan reports.
Let users disable the null sanitizer.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/Kconfig.ubsan      | 11 +++++++++++
 scripts/Makefile.ubsan |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 39494af..851c3f2 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -1,6 +1,9 @@
 config ARCH_HAS_UBSAN_SANITIZE_ALL
 	bool
 
+config ARCH_WANTS_UBSAN_NO_NULL
+	def_bool n
+
 config UBSAN
 	bool "Undefined behaviour sanity checker"
 	help
@@ -34,3 +37,11 @@ config UBSAN_ALIGNMENT
 	  This option enables detection of unaligned memory accesses.
 	  Enabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
+
+config UBSAN_NULL
+	bool "Enable checking of null pointers"
+	depends on UBSAN
+	default y if UBSAN && !ARCH_WANTS_UBSAN_NO_NULL
+	help
+	  This option enables detection of memory accesses via a
+	  null pointer.
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 77ce538..3b1b138 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -3,7 +3,6 @@ ifdef CONFIG_UBSAN
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=vla-bound)
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=null)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
@@ -15,6 +14,10 @@ ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
 
+ifdef CONFIG_UBSAN_NULL
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize=null)
+endif
+
       # -fsanitize=* options makes GCC less smart than usual and
       # increase number of 'maybe-uninitialized false-positives
       CFLAGS_UBSAN += $(call cc-option, -Wno-maybe-uninitialized)
-- 
2.5.5
