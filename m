Return-Path: <linux-kernel-owner+w=401wt.eu-S1756478AbZCLRGB@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator - hang traced
Date: Thu, 12 Mar 2009 18:05:46 +0100
References: <200903080230.10099.elendil@planet.nl> <1236817822.7680.148.camel@localhost.localdomain> <1236818863.7680.156.camel@localhost.localdomain>
In-Reply-To: <1236818863.7680.156.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sDUuJvWsoaqzwEi"
Message-Id: <200903121805.48041.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

--Boundary-00=_sDUuJvWsoaqzwEi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 12 March 2009, john stultz wrote:
> On Wed, 2009-03-11 at 17:30 -0700, john stultz wrote:
> > On Wed, 2009-03-11 at 17:03 +0100, Frans Pop wrote:
> > > Even with the cast you're just papering over the issue that we're
> > > moving a negative value into a field that is defined as unsigned:
> > > include/linux/clocksource.h:    u64 xtime_nsec;
> >
> > Probably agreed here, xtime_nsec probably should be converted to a
> > s64 as negative values are possible.
> >
> > However, Its unclear to me if my patch worked or not?
> > Did you try it alone?

Not exactly, but I did try a patch that was effectively the same (same
calculations, but using a few intermediate variables). It did not work.

> For a cleaner version, could you try the following, against 2.6.29-git
> with no other modification?

I've applied this patch against 28.7 and it makes no difference.
I'll try later against current mainline, but I don't expect it to work
there either.

BTW, with that patch there's are two other casts that can be removed:
-	if (unlikely((s64)clock->xtime_nsec < 0)) {
-		s64 neg = -(s64)clock->xtime_nsec;
+	if (unlikely(clock->xtime_nsec < 0)) {
+		s64 neg = -clock->xtime_nsec;


Some other observations:
* when the hang occurs we're definitely still using jiffies
* the hang is not in the clock accumulation loop (see below)
* changing the TIMERINT value does *not* make any difference, I tried a
  few different values (incl. the default 50 and 300)
* changing the nr of emulated CPUs from 2 to 1 makes no difference


I have now been able to trace the hang (full log attached). Where I added
tracing printks should be fairly obvious, and see attachment.
No idea what to make of the result.

     0.150337! init: calling smp_prepare_cpus
     0.183775! CPUs: 2 configured, 0 standby
     0.183947! s390_smp: smp_detect_cpus calling get_online_cpus
     0.184162! s390_smp: smp_detect_cpus calling __smp_rescan_cpus
     0.184381! s390_smp: smp_rescan_cpus_sigp starting loop
[!!! Hang is here !!!]

[... With 5cd1c9c5 and 6c9bacb4 reverted, the boot continues as follows ...]
[... Next two messages are from Hercules ...]
CPU0000: SIGP Set prefix (0D) CPU0001, PARM 0FEC5000: CC 0
CPU0000: SIGP Restart (06) CPU0001, PARM 00000000: CC 0
[... Time of previous message is similar for failed and good boot ...]
     0.525049! s390_smp: smp_rescan_cpus_sigp loop done
     0.525310! s390_smp: smp_detect_cpus calling put_online_cpus
     0.525555! s390_smp: smp_detect_cpus done
     0.526037! cpu 0 phys_idx=0 vers=00 ident=002623 machine=3090 unused=0000
     0.526408! s390_smp: start loop smp_create_idle
     0.531784! s390_smp: loop smp_create_idle done

The problem loop is in smp_rescan_cpus_sigp() from arch/s390/kernel/smp.c.

I tried adding printks inside the loop, but that resulted in the boot
also failing with the two patches reverted!
So it looks like that loop is somehow very sensitive to timing issues.
Note the relatively long delay between the start and end of the loop.


--Boundary-00=_sDUuJvWsoaqzwEi
Content-Type: text/plain;
  charset="utf-8";
  name="herc_2.6.28.7_hang.trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="herc_2.6.28.7_hang.trace"

     0.000000! Initializing cgroup subsys cpuset
     0.000000! Initializing cgroup subsys cpu
     0.000000! Linux version 2.6.28.7 (root@aragorn) (gcc version 4.2.4 (Debian 4.2.4-4)) #66 SMP Thu Mar 12 16:56:40 CET 2009
     0.000000! We are running native (31 bit mode)
     0.000000! This machine has an IEEE fpu
     0.000000! debug: ignoring loglevel setting.
     0.000000! Zone PFN ranges:
     0.000000!   Normal   0x00000000 -> 0x00010000
     0.000000! Movable zone start PFN for each node
     0.000000! early_node_map 1! active PFN ranges
     0.000000!     0: 0x00000000 -> 0x00010000
     0.000000! On node 0 totalpages: 65536
     0.000000!   Normal zone: 512 pages used for memmap
     0.000000!   Normal zone: 0 pages reserved
     0.000000!   Normal zone: 65024 pages, LIFO batch:15
     0.000000!   Movable zone: 0 pages used for memmap
     0.000000! Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
     0.000000! Kernel command line: ro vmpoff="LOGOFF" root=/dev/disk/by-path/ccw-0.0.0120-part1 ignore_loglevel BOOT_IMAGE=4
     0.000000! PID hash table entries: 1024 (order: 10, 4096 bytes)
     0.000000! Registering new clock device comparator
     0.000000! New clock device comparator registered
     0.000633! console  ttyS0! enabled
     0.002854! Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
     0.004258! timekeeping: clock source changed from none to jiffies (shift: 8)

     0.013649! Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
     0.137013! Memory: 251008k/262144k available (2144k kernel code, 0k reserved, 897k data, 152k init)
     0.137365! Write protected kernel read-only data: 0x12000 - 0x2d8fff
     0.139484! Calibrating delay loop (skipped)... 171.00 BogoMIPS preset
     0.140962! Security Framework initialized
     0.141155! SELinux:  Disabled at boot.
     0.142142! Mount-cache hash table entries: 512
     0.148444! Initializing cgroup subsys ns
     0.148631! Initializing cgroup subsys cpuacct
     0.149045! Initializing cgroup subsys devices
     0.150337! init: calling smp_prepare_cpus
     0.183775! CPUs: 2 configured, 0 standby
     0.183947! s390_smp: smp_detect_cpus calling get_online_cpus
     0.184162! s390_smp: smp_detect_cpus calling __smp_rescan_cpus
     0.184381! s390_smp: smp_rescan_cpus_sigp starting loop
[!!! Hang is here !!!]

[... With 5cd1c9c5 and 6c9bacb4 reverted, the boot continues as follows ...]
[... Next two messages are from Hercules ...]
CPU0000: SIGP Set prefix (0D) CPU0001, PARM 0FEC5000: CC 0
CPU0000: SIGP Restart (06) CPU0001, PARM 00000000: CC 0
[... A correct boot shows similar time lapse since last message ...]
     0.525049! s390_smp: smp_rescan_cpus_sigp loop done
     0.525310! s390_smp: smp_detect_cpus calling put_online_cpus
     0.525555! s390_smp: smp_detect_cpus done
     0.526037! cpu 0 phys_idx=0 vers=00 ident=002623 machine=3090 unused=0000
     0.526408! s390_smp: start loop smp_create_idle
     0.531784! s390_smp: loop smp_create_idle done
     0.532009! init: do_pre_smp_initcalls
     0.533334! init: start_boot_trace
     0.533499! init: smp_init
     0.535875! Registering new clock device tod
     0.536040! New clock device tod registered
     0.536254! cpu 1 phys_idx=1 vers=00 ident=102623 machine=3090 unused=0000
     0.545159! Brought up 2 CPUs
     0.545323! init: sched_init_smp
     0.545724! CPU0 attaching sched-domain:
     0.545952!  domain 0: span 0-1 level MC
     0.546182!   groups: 0 1
     0.546498! CPU1 attaching sched-domain:
     0.546717!  domain 0: span 0-1 level MC
     0.546943!   groups: 1 0
     0.548670! init: cpuset_init_smp
     0.548847! init: do_basic_setup
     0.589620! net_namespace: 524 bytes
     0.599256! NET: Registered protocol family 16
     0.715112! Switched to high resolution mode on CPU 0
     0.715262! Switched to high resolution mode on CPU 1
     0.718291! timekeeping: clock source changed from jiffies to tod (shift: 12)
     0.731545! NET: Registered protocol family 2
     0.787094! IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
     0.800004! TCP established hash table entries: 8192 (order: 4, 65536 bytes)
     0.804289! TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
     0.807714! TCP: Hash tables configured (established 8192 bind 8192)
     0.807993! TCP reno registered
     0.831294! NET: Registered protocol family 1
     0.837270! checking if image is initramfs...

In arch/s390/kernel/smp.c:
static int smp_rescan_cpus_sigp(cpumask_t avail)
{
        int cpu_id, logical_cpu;

        logical_cpu = first_cpu(avail);
        if (logical_cpu == NR_CPUS)
                return 0;
printk("s390_smp: smp_rescan_cpus_sigp starting loop\n");
        for (cpu_id = 0; cpu_id <= 65535; cpu_id++) {
                if (cpu_known(cpu_id))
                        continue;
                __cpu_logical_map[logical_cpu] = cpu_id;
                smp_cpu_polarization[logical_cpu] = POLARIZATION_UNKNWN;
                if (!cpu_stopped(logical_cpu))
                        continue;
                cpu_set(logical_cpu, cpu_present_map);
                smp_cpu_state[logical_cpu] = CPU_STATE_CONFIGURED;
                logical_cpu = next_cpu(logical_cpu, avail);
                if (logical_cpu == NR_CPUS)
                        break;
        }
printk("s390_smp: smp_rescan_cpus_sigp loop done\n");
        return 0;
}

--Boundary-00=_sDUuJvWsoaqzwEi--
