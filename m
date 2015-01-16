Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1421400905.15194.15.camel@x220>
Subject: [PATCH] [linux-next] s390: Dump check for CONFIG_ZFCPDUMP
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 16 Jan 2015 10:35:05 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit 725908110a1f ("s390: add SMT support") added a check for
CONFIG_ZFCPDUMP. But the Kconfig symbol ZFCPDUMP was removed in v3.16
through commit bf28a5970de3 ("s390/dump: Remove CONFIG_ZFCPDUMP"). So
this check will always evaluate to false. No one noticed probably
because the code also checks for CONFIG_CRASH_DUMP which "also enables
s390 zfcpdump".

Dump the unneeded check.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
This trivial issue popped up in next-20150116. If s390 commits can still
be altered after they've hit linux-next this might just as well be
folded into commit 725908110a1f ("s390: add SMT support").

Entirely untested!

 arch/s390/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 370ff3a092a3..fd4a9308f95f 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -762,7 +762,7 @@ static void __init smp_detect_cpus(void)
 			panic("Could not find boot CPU type");
 	}
 
-#if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_CRASH_DUMP)
+#if defined(CONFIG_CRASH_DUMP)
 	/* Collect CPU state of previous system */
 	smp_store_cpu_states(info);
 #endif
-- 
1.9.3
