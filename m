Return-Path: <linux-kernel-owner+w=401wt.eu-S932706AbXCZV1Y@vger.kernel.org>
Message-Id: <20070326212637.082960257@de.ibm.com>
References: <20070326212459.711271424@de.ibm.com>
Date: Mon, 26 Mar 2007 23:25:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 3/8] Improved kernel stack overflow checking.
Content-Disposition: inline; filename=111-stack-overflow.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Recent cvs versions of gcc have support for an improved stack overflow
checking that calculates the size of the guard size for each function.
If the compiler accepts -mstack-size without -mstack-guard then the
new stack check is available. We always want to use the new stack
checker.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Makefile |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6/arch/s390/Makefile
===================================================================
--- linux-2.6.orig/arch/s390/Makefile
+++ linux-2.6/arch/s390/Makefile
@@ -67,8 +67,10 @@ endif
 
 ifeq ($(call cc-option-yn,-mstack-size=8192 -mstack-guard=128),y)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-size=$(STACK_SIZE)
+ifneq ($(call cc-option-yn,-mstack-size=8192),y)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-guard=$(CONFIG_STACK_GUARD)
 endif
+endif
 
 ifeq ($(call cc-option-yn,-mwarn-dynamicstack),y)
 cflags-$(CONFIG_WARN_STACK) += -mwarn-dynamicstack

-- 
