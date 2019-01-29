Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 64/68] x86/xen/time: Output xen sched_clock time from 0
Date: Tue, 29 Jan 2019 12:36:26 +0100
Message-Id: <20190129113137.917364608@linuxfoundation.org>
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit 38669ba205d178d2d38bfd194a196d65a44d5af2 upstream.

It is expected for sched_clock() to output data from 0, when system boots.

Add an offset xen_sched_clock_offset (similarly how it is done in other
hypervisors i.e. kvm_sched_clock_offset) to count sched_clock() from 0,
when time is first initialized.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-14-pasha.tatashin@oracle.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/time.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -31,6 +31,8 @@
 /* Xen may fire a timer up to this many ns early */
 #define TIMER_SLOP	100000
 
+static u64 xen_sched_clock_offset __read_mostly;
+
 /* Get the TSC speed from Xen */
 static unsigned long xen_tsc_khz(void)
 {
@@ -57,6 +59,11 @@ static u64 xen_clocksource_get_cycles(st
 	return xen_clocksource_read();
 }
 
+static u64 xen_sched_clock(void)
+{
+	return xen_clocksource_read() - xen_sched_clock_offset;
+}
+
 static void xen_read_wallclock(struct timespec *ts)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
@@ -367,7 +374,7 @@ void xen_timer_resume(void)
 }
 
 static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_clocksource_read,
+	.sched_clock = xen_sched_clock,
 	.steal_clock = xen_steal_clock,
 };
 
@@ -505,6 +512,7 @@ static void __init xen_time_init(void)
 
 void __ref xen_init_time_ops(void)
 {
+	xen_sched_clock_offset = xen_clocksource_read();
 	pv_time_ops = xen_time_ops;
 
 	x86_init.timers.timer_init = xen_time_init;
@@ -547,6 +555,7 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
+	xen_sched_clock_offset = xen_clocksource_read();
 	pv_time_ops = xen_time_ops;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
