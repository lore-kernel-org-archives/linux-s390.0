Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44554 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgBNGmu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 01:42:50 -0500
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] s390/mm: Explicitly compare PAGE_DEFAULT_KEY against zero in storage_key_init_range
Date: Thu, 13 Feb 2020 23:42:07 -0700
Message-Id: <20200214064207.10381-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

 In file included from ../arch/s390/purgatory/purgatory.c:10:
 In file included from ../include/linux/kexec.h:18:
 In file included from ../include/linux/crash_core.h:6:
 In file included from ../include/linux/elfcore.h:5:
 In file included from ../include/linux/user.h:1:
 In file included from ../arch/s390/include/asm/user.h:11:
 ../arch/s390/include/asm/page.h:45:6: warning: converting the result of
 '<<' to a boolean always evaluates to false
 [-Wtautological-constant-compare]
         if (PAGE_DEFAULT_KEY)
            ^
 ../arch/s390/include/asm/page.h:23:44: note: expanded from macro
 'PAGE_DEFAULT_KEY'
 #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
                                                  ^
 1 warning generated.

Explicitly compare this against zero to silence the warning as it is
intended to be used in a boolean context.

Fixes: de3fa841e429 ("s390/mm: fix compile for PAGE_DEFAULT_KEY != 0")
Link: https://github.com/ClangBuiltLinux/linux/issues/860
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/s390/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 85e944f04c70..1019efd85b9d 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -42,7 +42,7 @@ void __storage_key_init_range(unsigned long start, unsigned long end);
 
 static inline void storage_key_init_range(unsigned long start, unsigned long end)
 {
-	if (PAGE_DEFAULT_KEY)
+	if (PAGE_DEFAULT_KEY != 0)
 		__storage_key_init_range(start, end);
 }
 
-- 
2.25.0
