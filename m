Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 15:17:46 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 3/4] trace: add -mcount-nop option support
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
Message-Id: <patch-3.thread-aa7b8d.git-e02ed2dc082b.your-ad-here.call-01533557518-ext-9465@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

-mcount-nop gcc option generates the calls to the profiling functions
as nops which allows to avoid patching mcount jump with NOP instructions
initially.

-mcount-nop gcc option will be activated if platform selects
HAVE_NOP_MCOUNT and gcc actually supports it.
In addition to that CC_USING_NOP_MCOUNT is defined and could be used by
architectures to adapt ftrace patching behavior.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Makefile              | 6 ++++++
 kernel/trace/Kconfig  | 5 +++++
 kernel/trace/ftrace.c | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 621ebdbfbf89..281f4ededf3a 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,12 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
     CC_FLAGS_FTRACE	+= -mrecord-mcount
     export CC_USING_RECORD_MCOUNT := 1
   endif
+  ifdef CONFIG_HAVE_NOP_MCOUNT
+    ifeq ($(call cc-option-yn, -mnop-mcount),y)
+      CC_FLAGS_FTRACE	+= -mnop-mcount
+      CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+    endif
+  endif
 endif
 ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..855109214e3d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -47,6 +47,11 @@ config HAVE_FENTRY
 	help
 	  Arch supports the gcc options -pg with -mfentry
 
+config HAVE_NOP_MCOUNT
+	bool
+	help
+	  Arch supports the gcc options -pg with -mrecord-mcount and -nop-mcount
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caf9cbf35816..310dfcb20d5b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2981,12 +2981,14 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			p = &pg->records[i];
 			p->flags = rec_flags;
 
+#ifndef CC_USING_NOP_MCOUNT
 			/*
 			 * Do the initial record conversion from mcount jump
 			 * to the NOP instructions.
 			 */
 			if (!ftrace_code_disable(mod, p))
 				break;
+#endif
 
 			update_cnt++;
 		}
-- 
2.18.0.13.gd42ae10
