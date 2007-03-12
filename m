Return-Path: <linux-kernel-owner+w=401wt.eu-S965853AbXCLNsr@vger.kernel.org>
Date: Mon, 12 Mar 2007 14:48:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] memory detection: fix off by one bug.
Message-ID: <20070312134851.GB10204@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] memory detection: fix off by one bug.

diag 260 returns the address of the last addressable byte and not the
size of memory. Since we want the size we have to add 1 to the return
value.
Disable diag 260 for non z/Arch mode since it doesn't work there
anyway.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/early.c linux-2.6-patched/arch/s390/kernel/early.c
--- linux-2.6/arch/s390/kernel/early.c	2007-03-12 13:52:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/early.c	2007-03-12 13:52:58.000000000 +0100
@@ -141,9 +141,9 @@ static noinline __init void detect_machi
 		machine_flags |= 4;
 }
 
+#ifdef CONFIG_64BIT
 static noinline __init int memory_fast_detect(void)
 {
-
 	unsigned long val0 = 0;
 	unsigned long val1 = 0xc;
 	int ret = -ENOSYS;
@@ -161,9 +161,15 @@ static noinline __init int memory_fast_d
 	if (ret || val0 != val1)
 		return -ENOSYS;
 
-	memory_chunk[0].size = val0;
+	memory_chunk[0].size = val0 + 1;
 	return 0;
 }
+#else
+static inline int memory_fast_detect(void)
+{
+	return -ENOSYS;
+}
+#endif
 
 #define ADDR2G	(1UL << 31)
 
