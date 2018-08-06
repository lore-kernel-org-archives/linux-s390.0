Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 15:17:44 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 2/4] trace: avoid calling cc-option -mrecord-mcount for every
 Makefile
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
Message-Id: <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
compiler flag support is tested for every Makefile.

Top 4 cc-option usages:
    511 -mrecord-mcount
     11  -fno-stack-protector
      9 -Wno-override-init
      2 -fsched-pressure

To address that move cc-option from scripts/Makefile.build to top Makefile
and export CC_USING_RECORD_MCOUNT to be used in original place.

While doing that also add -mrecord-mcount to CC_FLAGS_FTRACE (if gcc
actually supports it).

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Makefile               | 7 +++++++
 scripts/Makefile.build | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 503f533277c7..621ebdbfbf89 100644
--- a/Makefile
+++ b/Makefile
@@ -743,6 +743,13 @@ ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
 endif
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+  # gcc 5 supports generating the mcount tables directly
+  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
+    CC_FLAGS_FTRACE	+= -mrecord-mcount
+    export CC_USING_RECORD_MCOUNT := 1
+  endif
+endif
 ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 514ed63ff571..42ecb8cf7666 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -206,11 +206,8 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
-# gcc 5 supports generating the mcount tables directly
-ifneq ($(call cc-option,-mrecord-mcount,y),y)
-KBUILD_CFLAGS += -mrecord-mcount
-else
-# else do it all manually
+ifndef CC_USING_RECORD_MCOUNT
+# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -239,7 +236,7 @@ cmd_record_mcount =						\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
 	fi;
-endif # -record-mcount
+endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
-- 
2.18.0.13.gd42ae10
