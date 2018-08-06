Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 15:17:42 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 1/4] trace: handle CC_FLAGS_FTRACE more accurately
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
Message-Id: <patch-1.thread-aa7b8d.git-42971afe87de.your-ad-here.call-01533557518-ext-9465@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

CC_FLAGS_FTRACE is exported and later used to remove ftrace relevant
build flags from files which should be built without ftrace support.
For that reason add -mfentry to CC_FLAGS_FTRACE as well. That fixes
a problem with vdso32 build on s390, where -mfentry could not be used
together with -m31 flag.

At the same time flags like -pg and -mfentry are not relevant for asm
files, so avoid adding them to KBUILD_AFLAGS.

Introduce CC_FLAGS_USING instead of CC_USING_FENTRY to collect
-DCC_USING_FENTRY (and future alike) which are relevant for both
KBUILD_CFLAGS and KBUILD_AFLAGS.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7a3c4548162b..503f533277c7 100644
--- a/Makefile
+++ b/Makefile
@@ -743,12 +743,15 @@ ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
 endif
-export CC_FLAGS_FTRACE
 ifdef CONFIG_HAVE_FENTRY
-CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
+  ifeq ($(call cc-option-yn, -mfentry),y)
+    CC_FLAGS_FTRACE	+= -mfentry
+    CC_FLAGS_USING	+= -DCC_USING_FENTRY
+  endif
 endif
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY)
-KBUILD_AFLAGS	+= $(CC_USING_FENTRY)
+export CC_FLAGS_FTRACE
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
+KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
-- 
2.18.0.13.gd42ae10
