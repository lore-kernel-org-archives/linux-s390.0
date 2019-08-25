Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYNZO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 25 Aug 2019 09:25:14 -0400
From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/11] MAINTAINERS: make scripts/ftrace/ maintained
Date: Sun, 25 Aug 2019 21:23:30 +0800
Message-Id: <20190825132330.5015-12-changbin.du@gmail.com>
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Changbin Du <changbin.du@gmail.com>

Make scripts/ftrace/ maintained and I would like to help with reviewing
related patches.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd0..ca012ea260d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16293,6 +16293,7 @@ F:	drivers/char/tpm/
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
+R:	Changbin Du <changbin.du@gmail.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 S:	Maintained
 F:	Documentation/trace/ftrace.rst
@@ -16303,6 +16304,7 @@ F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
 F:	tools/testing/selftests/ftrace/
+F:	scripts/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
-- 
2.20.1
