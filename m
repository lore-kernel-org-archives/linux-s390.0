Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:42299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLRPBb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Dec 2020 10:01:31 -0500
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 13/23] arch: generic: drop misleading warning on spurious IRQ
Date: Fri, 18 Dec 2020 15:57:36 +0100
Message-Id: <20201218145746.24205-14-info@metux.net>
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com, will@kernel.org, msalter@redhat.com, jacquiot.aurelien@gmail.com, gerg@linux-m68k.org, geert@linux-m68k.org, tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, maz@kernel.org, tony@atomide.com, arnd@arndb.de, linux-alpha@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arch@vger.kernel.org

The warning in ack_bad_irq() is misleading in several ways:
* the term "vector" isn't quite correct
* the printing format isn't consistent across the archs: some print decimal,
  some hex, some hex w/o 0x prefix.
* the printed linux irq isn't meaningful in all cases - we actually would
  want it to print the hw irq.

Since all call sites already print out more detailed and correct information,
we just don't need to duplicate this in each single arch. So just drop it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/asm-generic/hardirq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index 7317e8258b48..f5a0240cbf52 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -19,7 +19,6 @@ DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
 #ifndef ack_bad_irq
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
 }
 #endif
 
-- 
2.11.0
