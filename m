From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] s390/ebdic: disable gcov on ebcdic.o
Date: Wed, 25 Mar 2015 14:15:35 +0100
Message-ID: <1427289336-22883-2-git-send-email-borntraeger@de.ibm.com>
References: <1427289336-22883-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1427289336-22883-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

ebcdic.o is also used for the compressed kernel image. The decompressor
has no gcov support, so better do not add any gcov related functions.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 31fab26..89352da 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -8,6 +8,10 @@ CFLAGS_REMOVE_early.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 endif
 
+# ebcdic.o is also used in arch/s390/boot/compressed/ with does not
+# have gcov support
+GCOV_PROFILE_ebcdic.o = n
+
 #
 # Passing null pointers is ok for smp code, since we access the lowcore here.
 #
-- 
2.1.4
