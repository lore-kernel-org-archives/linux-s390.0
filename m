Return-Path: <linux-kernel-owner+w=401wt.eu-S1752919AbZCJDNf@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: John Stultz <johnstul@us.ibm.com>
In-Reply-To: <200903080230.10099.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
Content-Type: text/plain
Date: Mon, 09 Mar 2009 20:09:42 -0700
Message-Id: <1236654582.3792.7.camel@jstultz-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2009-03-08 at 03:30 +0100, Frans Pop wrote:
> Kernels after 2.6.27 fail to boot in the Hercules S/390 emulator, quite
> early in the boot process:
>      0.000000! Initializing cgroup subsys cpuset
>      0.000000! Initializing cgroup subsys cpu
>      0.000000! Linux version 2.6.29-rc7 (root@aragorn) (gcc version 4.2.4 (Debian 4.2.4-4)) #11 SMP Thu Mar 5 20:02:03 CET 2009
>      0.000000! setup: Linux is running natively in 31-bit mode
>      0.000000! setup: The hardware system has IEEE compatible floating point units
>      0.000000! Zone PFN ranges:
>      0.000000!   Normal   0x00000000 -> 0x00010000
>      0.000000! Movable zone start PFN for each node
>      0.000000! early_node_map 1! active PFN ranges
>      0.000000!     0: 0x00000000 -> 0x00010000
>      0.000000! Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
>      0.000000! Kernel command line: ro vmpoff="LOGOFF" root=/dev/disk/by-path/ccw-0.0.0120-part1 BOOT_IMAGE=4
>      0.000000! PID hash table entries: 1024 (order: 10, 4096 bytes)
>      0.000503! console  ttyS0! enabled
>      0.002333! Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>      0.012841! Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>      0.129660! Memory: 252032k/262144k available (2271k kernel code, 0k reserved, 922k data, 164k init)
>      0.130086! Write protected kernel read-only data: 0x12000 - 0x2fbfff
>      0.133887! Security Framework initialized
>      0.134064! SELinux:  Disabled at boot.
>      0.134996! Mount-cache hash table entries: 512
>      0.141419! Initializing cgroup subsys ns
>      0.141605! Initializing cgroup subsys cpuacct
>      0.142009! Initializing cgroup subsys devices
>      0.180403! cpu: 2 configured CPUs, 0 standby CPUs
> [... here the boot stops, normally followed by: ...]
>      17179568.691707! cpu 0 phys_idx=0 vers=00 ident=002623 machine=3090 unused=0000
>      17179568.699479! cpu 1 phys_idx=1 vers=00 ident=102623 machine=3090 unused=0000
>      17179568.699636! Brought up 2 CPUs
> 
> I've bisected this to the following commit:
> commit 5cd1c9c5cf30d4b33df3d3f74d8142f278d536b7
> Author: Roman Zippel <zippel@linux-m68k.org>
> Date:   Mon Sep 22 14:42:43 2008 -0700
>     timekeeping: fix rounding problem during clock update
> 
> After reverting 5cd1c9c5cf30 and the somewhat related 6c9bacb41c10 on top
> of 2.6.28.7, the system boots OK again [1].

Huh. No clue right off. What clocksource is in use on this system?

cat /sys/devices/system/clocksource/clocksource0/current_clocksource


Also can you provide the output with the following patch?

thanks
-john


diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 900f1b6..e832ffc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -547,6 +547,7 @@ void update_wall_time(void)
 	 * add the remainder to the error difference.
 	 */
 	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
+	printk("xtime.tv_nsec: %ld  clock->xtime_nsec: %lld shift: %ld\n", xtime.tv_nsec, clock->xtime_nsec, clock->shift);
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
 
