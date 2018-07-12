Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v13 10/18] time: default boot time offset to local_clock()
Date: Wed, 11 Jul 2018 20:04:11 -0400
Message-Id: <20180712000419.5165-11-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

read_persistent_wall_and_boot_offset() is called during boot to read
both the persistent clock and also return the offset between the boot time
and the value of persistent clock.

Change the default boot_offset from zero to local_clock() so architectures,
that do not have a dedicated boot_clock but have early sched_clock(), such
as SPARCv9, x86, and possibly more will benefit from this change by getting
a better and more consistent estimate of the boot time without need for an
arch specific implementation.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/time/timekeeping.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cb738f825c12..30d7f64ffc87 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1503,14 +1503,17 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
  * Weak dummy function for arches that do not yet support it.
  * wall_time	- current time as returned by persistent clock
  * boot_offset	- offset that is defined as wall_time - boot_time
- *		  default to 0.
+ * The default function calculates offset based on the current value of
+ * local_clock(). This way architectures that support sched_clock() but don't
+ * support dedicated boot time clock will provide the best estimate of the
+ * boot time.
  */
 void __weak __init
 read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 				     struct timespec64 *boot_offset)
 {
 	read_persistent_clock64(wall_time);
-	*boot_offset = (struct timespec64){0};
+	*boot_offset = ns_to_timespec64(local_clock());
 }
 
 /* Flag for if timekeeping_resume() has injected sleeptime */
-- 
2.18.0
