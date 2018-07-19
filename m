Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 14/26] s390/time: add read_persistent_wall_and_boot_offset()
Date: Thu, 19 Jul 2018 16:55:33 -0400
Message-Id: <20180719205545.16512-15-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

read_persistent_wall_and_boot_offset() will replace read_boot_clock64()
because on some architectures it is more convenient to read both sources
as one may depend on the other. For s390, implementation is the same
as read_boot_clock64() but also calling and returning value of
read_persistent_clock64()

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/time.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index cf561160ea88..d1f5447d5687 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -221,6 +221,24 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ext_to_timespec64(clk, ts);
 }
 
+void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+						 struct timespec64 *boot_offset)
+{
+	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	struct timespec64 boot_time;
+	__u64 delta;
+
+	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
+	memcpy(clk, tod_clock_base, STORE_CLOCK_EXT_SIZE);
+	*(__u64 *)&clk[1] -= delta;
+	if (*(__u64 *)&clk[1] > delta)
+		clk[0]--;
+	ext_to_timespec64(clk, &boot_time);
+
+	read_persistent_clock64(wall_time);
+	*boot_offset = timespec64_sub(*wall_time, boot_time);
+}
+
 void read_boot_clock64(struct timespec64 *ts)
 {
 	unsigned char clk[STORE_CLOCK_EXT_SIZE];
-- 
2.18.0
