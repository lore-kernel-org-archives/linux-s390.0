Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 1/3] processor: remove spin_cpu_yield
Date: Sat,  8 Jun 2019 13:08:51 +0200
In-Reply-To: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
Message-Id: <20190608110853.35961-2-heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

spin_cpu_yield is unused, therefore remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/powerpc/include/asm/processor.h | 2 --
 include/linux/processor.h            | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ef573fe9873e..a9993e7a443b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -346,8 +346,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #define spin_cpu_relax()	barrier()
 
-#define spin_cpu_yield()	spin_cpu_relax()
-
 #define spin_end()	HMT_medium()
 
 #define spin_until_cond(cond)					\
diff --git a/include/linux/processor.h b/include/linux/processor.h
index dbc952eec869..dc78bdc7079a 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -32,15 +32,6 @@
 #define spin_cpu_relax() cpu_relax()
 #endif
 
-/*
- * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
- * necessary. This should be used if the wait is expected to take longer
- * than context switch overhead, but we can't sleep or do a directed yield.
- */
-#ifndef spin_cpu_yield
-#define spin_cpu_yield() cpu_relax_yield()
-#endif
-
 #ifndef spin_end
 #define spin_end()
 #endif
-- 
2.17.1
