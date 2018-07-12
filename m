Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v13 11/18] s390/time: remove read_boot_clock64()
Date: Wed, 11 Jul 2018 20:04:12 -0400
Message-Id: <20180712000419.5165-12-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

read_boot_clock64() was replaced by read_persistent_wall_and_boot_offset()
so remove it.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/s390/kernel/time.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index d1f5447d5687..e8766beee5ad 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -239,19 +239,6 @@ void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = timespec64_sub(*wall_time, boot_time);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
-{
-	unsigned char clk[STORE_CLOCK_EXT_SIZE];
-	__u64 delta;
-
-	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
-	memcpy(clk, tod_clock_base, 16);
-	*(__u64 *) &clk[1] -= delta;
-	if (*(__u64 *) &clk[1] > delta)
-		clk[0]--;
-	ext_to_timespec64(clk, ts);
-}
-
 static u64 read_tod_clock(struct clocksource *cs)
 {
 	unsigned long long now, adj;
-- 
2.18.0
