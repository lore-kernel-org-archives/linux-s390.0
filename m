Return-Path: <linux-kernel-owner+w=401wt.eu-S1758107AbZCMReq@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator - hang traced
Date: Fri, 13 Mar 2009 18:34:30 +0100
References: <200903080230.10099.elendil@planet.nl> <200903121805.48041.elendil@planet.nl> <200903131248.03622.elendil@planet.nl>
In-Reply-To: <200903131248.03622.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903131834.32585.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Friday 13 March 2009, Frans Pop wrote:
> I added printks that show changes in clock data. I print info for
> 3 consecutive calls of update_wall_time every 1000 times the function
> is called and also after a change of clock source.

Aaarghh. I'm a moron, but most of you will already have concluded that by
now. I've been looking at nsecs as if they also included secs.

So, here's a trace with Roman's patches that really shows the relevant
data. Basic conclusion remains the same though: time really does look to
be running backwards in the very early part of the boot because the
seconds are not advancing while the nsecs are going backwards.

     0.004688! jiffies/8 (1): xtime.tv: 1236962306/99461000 -> 1236962306/99461001
     0.004793!    clock->xtime: 0 -> -256, error: 0 -> -4294867296
     0.009705! jiffies/8 (2): xtime.tv: 1236962306/99461001 -> 1236962306/99444618
     0.009821!    clock->xtime: -256 -> -256, error: -4294867296 -> -4292501984672096
     0.014514! Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
     0.014944! jiffies/8 (3): xtime.tv: 1236962306/99444618 -> 1236962306/99395467
     0.015067!    clock->xtime: -256 -> -256, error: -4292501984672096 -> -12807124325236736
     0.019704! jiffies/8 (4): xtime.tv: 1236962306/99395467 -> 1236962306/99379084
     0.019811!    clock->xtime: -256 -> -256, error: -12807124325236736 -> -14918180945433952
     0.140556! Memory: 251008k/262144k available (2144k kernel code, 0k reserved, 897k data, 152k init)
     0.140913! Write protected kernel read-only data: 0x12000 - 0x2d8fff
     0.143231! Calibrating delay loop (skipped)... 572.00 BogoMIPS preset
     0.144675! Security Framework initialized
     0.144870! SELinux:  Disabled at boot.
     0.146009! Mount-cache hash table entries: 512
     0.152474! Initializing cgroup subsys ns
     0.152671! Initializing cgroup subsys cpuacct
     0.153095! Initializing cgroup subsys devices
     0.154303! init: calling smp_prepare_cpus
     0.189342! CPUs: 2 configured, 0 standby
     0.189516! s390_smp: smp_detect_cpus calling get_online_cpus
     0.189742! s390_smp: smp_detect_cpus calling __smp_rescan_cpus
     0.189964! s390_smp: smp_rescan_cpus_sigp starting loop
[... System hangs here ...]

[... By this time it looks like the error has stabilized somewhat and nsecs are more stable ...]
[... nsecs are actually larger now than in the display at 0.019704 ...]
     0.311447! jiffies/8 (153): xtime.tv: 1236962306/599346640 -> 1236962306/599346640
     0.311567!    clock->xtime: -228 -> -29, error: -16490881133476192 -> -16490883213850976
     0.312174! jiffies/8 (154): xtime.tv: 1236962306/599346640 -> 1236962306/599346641
     0.312292!    clock->xtime: -29 -> -226, error: -16490883213850976 -> -16490885428443488
     0.312884! jiffies/8 (155): xtime.tv: 1236962306/599346641 -> 1236962306/599346641
     0.313014!    clock->xtime: -226 -> -31, error: -16490885428443488 -> -16490887508818272
[... Only here do seconds start to increase ...]
     0.320129! jiffies/8 (304): xtime.tv: 1236962307/99331656 -> 1236962307/99331656
     0.320254!    clock->xtime: -201 -> -56, error: -16426767068861792 -> -16426769149236576
     0.320844! jiffies/8 (305): xtime.tv: 1236962307/99331656 -> 1236962307/99331657
     0.320954!    clock->xtime: -56 -> -199, error: -16426769149236576 -> -16426781363829088
     0.321536! jiffies/8 (306): xtime.tv: 1236962307/99331657 -> 1236962307/99331657
     0.321651!    clock->xtime: -199 -> -58, error: -16426781363829088 -> -16426783444203872
     0.328758! jiffies/8 (455): xtime.tv: 1236962307/599316731 -> 1236962307/599316732
     0.328876!    clock->xtime: -82 -> -173, error: -16362926407417856 -> -16362928622010368
     0.329470! jiffies/8 (456): xtime.tv: 1236962307/599316732 -> 1236962307/599316732
     0.329598!    clock->xtime: -173 -> -84, error: -16362928622010368 -> -16362920702285152
     0.330192! jiffies/8 (457): xtime.tv: 1236962307/599316732 -> 1236962307/599316733
     0.330317!    clock->xtime: -84 -> -171, error: -16362920702285152 -> -16362922916877664
     0.374500! jiffies/8 (1456): xtime.tv: 1236962311/599199308 -> 1236962311/599199308
     0.374632!    clock->xtime: -165 -> -92, error: -15860566497065312 -> -15860568577440096
