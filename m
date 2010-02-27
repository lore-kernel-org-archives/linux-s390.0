Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 29/66] arch/s390/include/asm/unaligned.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:10 +0100
Message-Id: <1267289508-31031-30-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

arch/s390/include/asm/unaligned.h:5: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/s390/include/asm/unaligned.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/include/asm/unaligned.h b/arch/s390/include/asm/unaligned.h
index da9627a..1ce42c3 100644
--- a/arch/s390/include/asm/unaligned.h
+++ b/arch/s390/include/asm/unaligned.h
@@ -2,7 +2,7 @@
 #define _ASM_S390_UNALIGNED_H
 
 /*
- * The S390 can do unaligned accesses itself. 
+ * The S390 can do unaligned accesses itself.
  */
 #include <linux/unaligned/access_ok.h>
 #include <linux/unaligned/generic.h>
-- 
1.7.0.90.g251a4
