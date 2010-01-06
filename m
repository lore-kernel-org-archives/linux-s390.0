Return-Path: <linux-kernel-owner+w=401wt.eu-S1755516Ab0AFP0j@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] S390: use helpers for rlimits
Date: Wed,  6 Jan 2010 16:24:32 +0100
Message-Id: <1262791479-26594-4-git-send-email-jslaby@suse.cz>
In-Reply-To: <1262791479-26594-1-git-send-email-jslaby@suse.cz>
References: <1262791479-26594-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: jirislaby@gmail.com
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Make sure compiler won't do weird things with limits. E.g. fetching
them twice may return 2 different values after writable limits are
implemented.

I.e. either use rlimit helpers added in
3e10e716abf3c71bdb5d86b8f507f9e72236c9cd
or ACCESS_ONCE if not applicable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 arch/s390/mm/mmap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index f4558cc..869efba 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -40,7 +40,7 @@
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = rlimit(RLIMIT_STACK);
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
@@ -61,7 +61,7 @@ static inline int mmap_is_legacy(void)
 #endif
 	return sysctl_legacy_va_layout ||
 	    (current->personality & ADDR_COMPAT_LAYOUT) ||
-	    current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY;
+	    rlimit(RLIMIT_STACK) == RLIM_INFINITY;
 }
 
 #ifndef CONFIG_64BIT
-- 
1.6.5.7
