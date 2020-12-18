Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:41181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgLROfV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Dec 2020 09:35:21 -0500
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 03/23] arch: arm: drop misleading warning on spurious IRQ
Date: Fri, 18 Dec 2020 15:31:02 +0100
Message-Id: <20201218143122.19459-4-info@metux.net>
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
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
 arch/arm/include/asm/hw_irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
index cecc13214ef1..5305c7e33aee 100644
--- a/arch/arm/include/asm/hw_irq.h
+++ b/arch/arm/include/asm/hw_irq.h
@@ -9,7 +9,6 @@ static inline void ack_bad_irq(int irq)
 {
 	extern unsigned long irq_err_count;
 	irq_err_count++;
-	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
 }
 
 #define ARCH_IRQ_INIT_FLAGS	(IRQ_NOREQUEST | IRQ_NOPROBE)
-- 
2.11.0
