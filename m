Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgDMBhz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 Apr 2020 21:37:55 -0400
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6BC0A3BE0
        for <linux-s390@vger.kernel.org>; Sun, 12 Apr 2020 18:37:55 -0700 (PDT)
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-02.nifty.com with ESMTP id 03D1VfNO005254
        for <linux-s390@vger.kernel.org>; Mon, 13 Apr 2020 10:31:41 +0900
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] s390: ptrace: hard-code "s390x" instead of UTS_MACHINE
Date: Mon, 13 Apr 2020 10:31:13 +0900
Message-Id: <20200413013113.8529-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org

s390 uses the UTS_MACHINE defined arch/s390/Makefile as follows:

  UTS_MACHINE     := s390x

We do not need to pass the fixed string from the command line.
Hard-code user_regset_view::name, like many other architectures do.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/Makefile | 5 -----
 arch/s390/kernel/ptrace.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 75f26d775027..a8f136943deb 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -33,11 +33,6 @@ CFLAGS_stacktrace.o	+= -fno-optimize-sibling-calls
 CFLAGS_dumpstack.o	+= -fno-optimize-sibling-calls
 CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
 
-#
-# Pass UTS_MACHINE for user_regset definition
-#
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
-
 obj-y	:= traps.o time.o process.o base.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 58faa12542a1..994a8b86edae 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1416,7 +1416,7 @@ static const struct user_regset s390_regsets[] = {
 };
 
 static const struct user_regset_view user_s390_view = {
-	.name = UTS_MACHINE,
+	.name = "s390x",
 	.e_machine = EM_S390,
 	.regsets = s390_regsets,
 	.n = ARRAY_SIZE(s390_regsets)
-- 
2.25.1
