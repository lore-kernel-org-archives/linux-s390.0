Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1781103AbgJZOaG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 10:30:06 -0400
Date: Mon, 26 Oct 2020 15:29:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 compile fix for 5.10-rc2
Message-ID: <20201026142956.GA9584@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull a simple fix, so that s390 compiles again after Joe Perches' commit
33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
which went in just before 5.10-rc1.

Thanks,
Heiko

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-2

for you to fetch changes up to 8e90b4b1305a80b1d7712370a163eff269ac1ba2:

  s390: correct __bootdata / __bootdata_preserved macros (2020-10-26 14:18:01 +0100)

----------------------------------------------------------------
- Fix s390 compile breakage caused by commit 33def8498fdd
  ("treewide: Convert macro and uses of __section(foo) to __section("foo")")

----------------------------------------------------------------
Vasily Gorbik (1):
      s390: correct __bootdata / __bootdata_preserved macros

 arch/s390/include/asm/sections.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sections.h
index a996d3990a02..0c2151451ba5 100644
--- a/arch/s390/include/asm/sections.h
+++ b/arch/s390/include/asm/sections.h
@@ -26,14 +26,14 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
  * final .boot.data section, which should be identical in the decompressor and
  * the decompressed kernel (that is checked during the build).
  */
-#define __bootdata(var) __section(".boot.data.var") var
+#define __bootdata(var) __section(".boot.data." #var) var
 
 /*
  * .boot.preserved.data is similar to .boot.data, but it is not part of the
  * .init section and thus will be preserved for later use in the decompressed
  * kernel.
  */
-#define __bootdata_preserved(var) __section(".boot.preserved.data.var") var
+#define __bootdata_preserved(var) __section(".boot.preserved.data." #var) var
 
 extern unsigned long __sdma, __edma;
 extern unsigned long __stext_dma, __etext_dma;
