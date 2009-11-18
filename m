Return-Path: <linux-kernel-owner+w=401wt.eu-S1755815AbZKROws@vger.kernel.org>
From: Jiri Slaby <jslaby@novell.com>
Subject: [PATCH 05/16] S390: use ACCESS_ONCE for rlimits
Date: Wed, 18 Nov 2009 15:51:51 +0100
Message-Id: <1258555922-2064-5-git-send-email-jslaby@novell.com>
In-Reply-To: <4B040A03.2020508@gmail.com>
References: <4B040A03.2020508@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: jirislaby@gmail.com
Cc: mingo@elte.hu, nhorman@tuxdriver.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, marcin.slusarz@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org, Jiri Slaby <jslaby@novell.com>, James Morris <jmorris@namei.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Make sure compiler won't do weird things with limits. E.g. fetching
them twice may return 2 different values after writable limits are
implemented.

Signed-off-by: Jiri Slaby <jslaby@novell.com>
Cc: James Morris <jmorris@namei.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 arch/s390/mm/mmap.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index f4558cc..90d3216 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -40,7 +40,8 @@
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = ACCESS_ONCE(current->signal->
+			rlim[RLIMIT_STACK].rlim_cur);
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
@@ -59,9 +60,11 @@ static inline int mmap_is_legacy(void)
 	if (!is_compat_task())
 		return 1;
 #endif
+	if (ACCESS_ONCE(current->signal->rlim[RLIMIT_STACK].rlim_cur) ==
+			RLIM_INFINITY)
+		return 1;
 	return sysctl_legacy_va_layout ||
-	    (current->personality & ADDR_COMPAT_LAYOUT) ||
-	    current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY;
+	    (current->personality & ADDR_COMPAT_LAYOUT);
 }
 
 #ifndef CONFIG_64BIT
-- 
1.6.4.2
