Return-Path: <linux-kernel-owner+w=401wt.eu-S1756828AbZCMLsV@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator - hang traced
Date: Fri, 13 Mar 2009 12:48:01 +0100
References: <200903080230.10099.elendil@planet.nl> <1236818863.7680.156.camel@localhost.localdomain> <200903121805.48041.elendil@planet.nl>
In-Reply-To: <200903121805.48041.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903131248.03622.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

One more.

On Thursday 12 March 2009, Frans Pop wrote:
> I have now been able to trace the hang (full log attached). Where I
> added tracing printks should be fairly obvious, and see attachment.
> No idea what to make of the result.

I added printks that show changes in clock data. I print info for
3 consecutive calls of update_wall_time every 1000 times the function
is called and also after a change of clock source.

With the problem patches reverted this results in (only most relevant boot
messages shown):

     0.004316! timekeeping: clock source changed from none to jiffies (shift: 8)
     0.004674! timekeeping (jiffies, 8): xtime.tv: 1236941336 -> 927305000
     0.004796!    clock->xtime: 0 -> 0, error: 0 -> 0
     0.009380! timekeeping (jiffies, 8): xtime.tv: 1236941336 -> 927305000
     0.009507!    clock->xtime: 0 -> 0, error: 0 -> 0
     0.014379! timekeeping (jiffies, 8): xtime.tv: 1236941336 -> 927305000
     0.014628!    clock->xtime: 0 -> 0, error: 0 -> 0
[...]
     0.151860! init: calling smp_prepare_cpus
     0.184936! CPUs: 2 configured, 0 standby
     0.185110! s390_smp: smp_detect_cpus calling get_online_cpus
     0.185326! s390_smp: smp_detect_cpus calling __smp_rescan_cpus
     0.185544! s390_smp: smp_rescan_cpus_sigp starting loop
CPU0001: SIGP Set prefix (0D) CPU0000, PARM 0FEC5000: CC 0
CPU0001: SIGP Restart (06) CPU0000, PARM 00000000: CC 0
     0.515211! s390_smp: smp_rescan_cpus_sigp loop done
     0.515426! s390_smp: smp_detect_cpus calling put_online_cpus
     0.515648! s390_smp: smp_detect_cpus done
     0.515884! cpu 0 phys_idx=1 vers=00 ident=102623 machine=3090 unused=0000
     0.516199! s390_smp: start loop smp_create_idle
     0.521119! s390_smp: loop smp_create_idle done
     0.521304! init: do_pre_smp_initcalls
     0.522791! init: start_boot_trace
     0.522943! init: smp_init
     0.525237! cpu 1 phys_idx=0 vers=00 ident=002623 machine=3090 unused=0000                  +
     0.535315! Brought up 2 CPUs
     0.535475! init: sched_init_smp
     0.535878! CPU0 attaching sched-domain:
     0.536100!  domain 0: span 0-1 level MC
     0.536342!   groups: 0 1
     0.536661! CPU1 attaching sched-domain:
     0.536897!  domain 0: span 0-1 level MC
     0.537126!   groups: 1 0
     0.538877! init: cpuset_init_smp
     0.539072! init: do_basic_setup
     0.546056! net_namespace: 524 bytes
     0.555855! NET: Registered protocol family 16
     0.678223! Switched to high resolution mode on CPU 0
     0.678708! Switched to high resolution mode on CPU 1
     0.681215! timekeeping: clock source changed from jiffies to tod (shift: 12)
     0.681651! timekeeping (tod, 12): xtime.tv: 1236941337 -> 544275946
     0.681797!    clock->xtime: 0 -> 0, error: 0 -> 0
     0.685247! timekeeping (tod, 12): xtime.tv: 1236941337 -> 544275946
     0.685393!    clock->xtime: 0 -> 0, error: 0 -> 0
     0.689345! timekeeping (tod, 12): xtime.tv: 1236941337 -> 544275946
     0.689490!    clock->xtime: 0 -> 0, error: 0 -> 0
     0.698348! NET: Registered protocol family 2
     0.754070! IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
     0.767402! TCP established hash table entries: 8192 (order: 4, 65536 bytes)
     0.771770! TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
     0.775119! TCP: Hash tables configured (established 8192 bind 8192)
     0.775390! TCP reno registered
     0.798979! NET: Registered protocol family 1
     0.805108! checking if image is initramfs...
               timekeeping (tod, 12): xtime.tv: 1236941341 -> 544275946
     4.713613!    clock->xtime: 0 -> 0, error: 0 -> 0
     4.717402! timekeeping (tod, 12): xtime.tv: 1236941341 -> 544275946
     4.717533!    clock->xtime: 0 -> 0, error: 0 -> 0
     4.721299! timekeeping (tod, 12): xtime.tv: 1236941341 -> 544275946
     4.721429!    clock->xtime: 0 -> 0, error: 0 -> 0

The values are: "from the very beginning of the function" -> "just after
the calculations". Values are from nsecs fields.
The xtime.tv_nsec which enters the function increases nicely and follows
the timestamps from Hercules, but look rather bogus after the calculations.

With Roman's patch and the later patch this changes to:

     0.004593! timekeeping: clock source changed from none to jiffies (shift: 8)
     0.005051! timekeeping (jiffies, 8): xtime.tv: 594977000 -> 594977001
     0.005097!    clock->xtime: 0 -> -256, error: 0 -> -4294867296
     0.009608! timekeeping (jiffies, 8): xtime.tv: 594977001 -> 594960618
     0.009712!    clock->xtime: -256 -> -256, error: -4294867296 -> -4292501984672096
     0.014463! Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[... Clock has gone back? ...]
     0.014859! timekeeping (jiffies, 8): xtime.tv: 594960618 -> 594911467
     0.014967!    clock->xtime: -256 -> -256, error: -4292501984672096 -> -12807124325236736
[... Followed by a major jump forward? ...]
     0.019605! timekeeping (jiffies, 8): xtime.tv: 594911467 -> 594895084
     0.019712!    clock->xtime: -256 -> -256, error: -12807124325236736 -> -14918180945433952
[...]
     0.155939! init: calling smp_prepare_cpus
     0.191122! CPUs: 2 configured, 0 standby
     0.191308! s390_smp: smp_detect_cpus calling get_online_cpus
     0.191614! s390_smp: smp_detect_cpus calling __smp_rescan_cpus
     0.191847! s390_smp: smp_rescan_cpus_sigp starting loop
[... Boot hangs here, as in previous traces ...]
[... But strangely enough after some time update_wall_time does get called again ...]
     0.348835! timekeeping (jiffies, 8): xtime.tv: 594758872 -> 594758872
     0.348933!    clock->xtime: -246 -> -11, error: -16046942240899072 -> -16046944321273856
     0.349488! timekeeping (jiffies, 8): xtime.tv: 594758872 -> 594758873
     0.349606!    clock->xtime: -11 -> -244, error: -16046944321273856 -> -16046946535866368
     0.350152! timekeeping (jiffies, 8): xtime.tv: 594758873 -> 594758873
     0.350251!    clock->xtime: -244 -> -13, error: -16046946535866368 -> -16046948616241152
[... Clock has gone back again? ...]
     0.394200! timekeeping (jiffies, 8): xtime.tv: 594643725 -> 594643725
     0.394308!    clock->xtime: -237 -> -20, error: -15554322309840896 -> -15554324390215680
     0.394852! timekeeping (jiffies, 8): xtime.tv: 594643725 -> 594643726
     0.394956!    clock->xtime: -20 -> -235, error: -15554324390215680 -> -15554326604808192
     0.395500! timekeeping (jiffies, 8): xtime.tv: 594643726 -> 594643726
     0.395602!    clock->xtime: -235 -> -22, error: -15554326604808192 -> -15554328685082976
[... And again ...]
     0.439589! timekeeping (jiffies, 8): xtime.tv: 594532128 -> 594532129
     0.439687!    clock->xtime: -28 -> -227, error: -15076881262089568 -> -15076883476682080
     0.440219! timekeeping (jiffies, 8): xtime.tv: 594532129 -> 594532129
     0.440323!    clock->xtime: -227 -> -30, error: -15076883476682080 -> -15076885557056864
     0.440864! timekeeping (jiffies, 8): xtime.tv: 594532129 -> 594532130
     0.440968!    clock->xtime: -30 -> -225, error: -15076885557056864 -> -15076887771649376
[... And again ...]
     0.484897! timekeeping (jiffies, 8): xtime.tv: 594423969 -> 594423970
     0.485002!    clock->xtime: -37 -> -218, error: -14614165981233152 -> -14614168195825664
     0.485545! timekeeping (jiffies, 8): xtime.tv: 594423970 -> 594423970
     0.485650!    clock->xtime: -218 -> -39, error: -14614168195825664 -> -14614160276200448
     0.486192! timekeeping (jiffies, 8): xtime.tv: 594423970 -> 594423971
     0.486299!    clock->xtime: -39 -> -216, error: -14614160276200448 -> -14614162490692960

Here within each set of 3 displays the values look relatively sane, but
the jumps between the bursts cannot be correct.

John: if you'd like the patches I've used for this, please shout.

Cheers,
FJP
