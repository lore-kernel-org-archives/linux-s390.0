Return-Path: <linux-kernel-owner+w=401wt.eu-S1755949AbXD0ONL@vger.kernel.org>
Message-Id: <20070427140517.205443955@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 23/38] Improved kernel stack overflow checking.
Content-Disposition: inline; filename=126-stack-overflow.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
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

Index: quilt-2.6/arch/s390/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/Makefile	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/Makefile	2007-04-27 16:04:58.000000000 +0200
@@ -67,8 +67,10 @@
 
 ifeq ($(call cc-option-yn,-mstack-size=8192 -mstack-guard=128),y)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-size=$(STACK_SIZE)
+ifneq ($(call cc-option-yn,-mstack-size=8192),y)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-guard=$(CONFIG_STACK_GUARD)
 endif
+endif
 
 ifeq ($(call cc-option-yn,-mwarn-dynamicstack),y)
 cflags-$(CONFIG_WARN_STACK) += -mwarn-dynamicstack

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
