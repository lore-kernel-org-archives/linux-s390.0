Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F8C433F5
	for <linux-s390@archiver.kernel.org>; Sun,  7 Nov 2021 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C006008E
	for <linux-s390@archiver.kernel.org>; Sun,  7 Nov 2021 16:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhKGQ0M (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 7 Nov 2021 11:26:12 -0500
Received: from condef-09.nifty.com ([202.248.20.74]:18454 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhKGQ0M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 7 Nov 2021 11:26:12 -0500
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-09.nifty.com with ESMTP id 1A7GLsob025203
        for <linux-s390@vger.kernel.org>; Mon, 8 Nov 2021 01:21:54 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 1A7GLGH8014967;
        Mon, 8 Nov 2021 01:21:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1A7GLGH8014967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636302077;
        bh=s1NyX1ZaqRz0lA+F7W3QeWU8jgMRJfk5xOkduk3mJDw=;
        h=From:To:Cc:Subject:Date:From;
        b=m0YHGAor3BXzpCAAhVxMD4/60mb3KnJZc6x6hDUnosRLTpvDnHE/yy5uVjr5o5PKH
         XXh4Jexb0oYCKU+Cwm46YHNTPsVPYO1h8UDQYQKQ67Jdef6E+2rz60lGpSyZeCmw7M
         pIPVo0On/X6wRtDuNJKobBzYAsm9cIeD1ICzIhVeVPWDjqEWzOhmX1W58ZgHuRvPrt
         gElvI1HrWMGbX1B13rlvG+QbDZzCY3XTSQwYBmGmDLffP7ZcfbepQxmw6XqWJqYY7q
         MBxkZDgDjajtV9NcavXvyLfX+y16nEValrDAyhucwiUMzDm/cmYfK8qye0gyojQJp/
         +Jc4vfK1tJT0w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390/vdso: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 01:21:11 +0900
Message-Id: <20211107162111.323701-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since commit 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to
link vDSO"), $(LD) is directly used, hence -nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/vdso32/Makefile | 2 +-
 arch/s390/kernel/vdso64/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index e3e6ac5686df..245bddfe9bc0 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_32 += -m31 -s
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
 
-LDFLAGS_vdso32.so.dbg += -fPIC -shared -nostdlib -soname=linux-vdso32.so.1 \
+LDFLAGS_vdso32.so.dbg += -fPIC -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 6568de236701..e7d911780935 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -25,7 +25,7 @@ KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
-ldflags-y := -fPIC -shared -nostdlib -soname=linux-vdso64.so.1 \
+ldflags-y := -fPIC -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
-- 
2.30.2

