Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] s390: Remove unused variable in copy_from_realmem()
Date: Tue, 15 Oct 2013 08:50:11 +0200
Message-Id: <1381819811-28811-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-s390.vger.kernel.org>

arch/s390/kernel/crash_dump.c: In function 'copy_from_realmem':
arch/s390/kernel/crash_dump.c:48:6: warning: unused variable 'rc' [-Wunused-variable]

Introduced by commit 4d3b0664a0d0c0dc7501cfbd067f74226aeca510 ("s390: Allow
vmalloc target buffers for copy_from_oldmem()").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/s390/kernel/crash_dump.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 7dd21720e5b0..3db6af0601a5 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -45,7 +45,6 @@ static inline void *load_real_addr(void *addr)
 static int copy_from_realmem(void *dest, void *src, size_t count)
 {
 	unsigned long size;
-	int rc;
 
 	if (!count)
 		return 0;
-- 
1.7.9.5
