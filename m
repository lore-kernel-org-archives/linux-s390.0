Return-Path: <linux-kernel-owner@vger.kernel.org>
From: John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 1/3] clocksource: s390: Convert s390 to use clocksource_register_khz
Date: Mon, 23 Jan 2012 16:05:48 -0800
Message-Id: <1327363550-19952-2-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1327363550-19952-1-git-send-email-john.stultz@linaro.org>
References: <1327363550-19952-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Converts s390 TOD clock to use clocksource_register_khz

The tod freq I calculated seems a bit fast. Need someone
to double check me here.

CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/s390/kernel/time.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index fa02f44..37e8ec5 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -207,8 +207,6 @@ static struct clocksource clocksource_tod = {
 	.rating		= 400,
 	.read		= read_tod_clock,
 	.mask		= -1ULL,
-	.mult		= 1000,
-	.shift		= 12,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -267,7 +265,16 @@ void __init time_init(void)
 	if (register_external_interrupt(0x1406, timing_alert_interrupt))
 		panic("Couldn't request external interrupt 0x1406");
 
-	if (clocksource_register(&clocksource_tod) != 0)
+	/* s390 TOD apparently runs at 4,096,000,000 cycs/sec
+	 * XXX - Brute forced tod freq from:
+	 *    2^shift/mult * NSEC_PER_SEC	= cyc/sec
+	 *    2^12 / 1000  * 1000000000		= cyc/sec
+	 *    2^12 * 1000000			= cyc/sec
+	 *    2^12 * 1000			= kcyc/sec
+	 *    1000<<12				= kcyc/sec
+	 * Could be totally wrong. -johnstul
+	 */
+	if (clocksource_register_khz(&clocksource_tod, (1000<<12) ) != 0)
 		panic("Could not register TOD clock source");
 
 	/* Enable TOD clock interrupts on the boot cpu. */
-- 
1.7.3.2.146.gca209
