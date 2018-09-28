Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
Date: Thu, 27 Sep 2018 21:44:13 -0700
Message-Id: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-s390.vger.kernel.org>

futex_detect_cmpxchg() checks whether cmpxchg is available by trying
it on the NULL pointer and seeing what the error code is (EFAULT vs
ENOSYS).  This happens with KERNEL_DS set, which is impolite: while
the NULL *user* pointer is definitely invalid when there is no user
program running, the NULL *kernel* pointer seems more like a
programming error than a safe place to do an intentionally-failing
access.  An upcoming hardening series I'm working on causes the
existing code to OOPS, because it considers any failed uaccess with
KERNEL_DS to be a sign of a bug.

Explicitly set USER_DS to avoid this problem.

Cc: linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---

I have a couple questions here:

 - Is this actually okay on all architectures?  That is, are there
   cases where we'll screw up if we fail a USER_DS access this early?
   s390 stands out as the obvious special case (where USER_DS is not
   than just a subset of KERNEL_DS), but s390 opts out.

 - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
   some 32-bit configurations that don't have cmpxchg and don't know
   about it at compile time?

 kernel/futex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 11fc3bb456d6..16bd3e72602a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3593,6 +3593,7 @@ static void __init futex_detect_cmpxchg(void)
 {
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
 	u32 curval;
+	mm_segment_t old_seg;
 
 	/*
 	 * This will fail and we want it. Some arch implementations do
@@ -3604,8 +3605,11 @@ static void __init futex_detect_cmpxchg(void)
 	 * implementation, the non-functional ones will return
 	 * -ENOSYS.
 	 */
+	old_seg = get_fs();
+	set_fs(USER_DS);
 	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
 		futex_cmpxchg_enabled = 1;
+	set_fs(old_seg);
 #endif
 }
 
-- 
2.17.1
