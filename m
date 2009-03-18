Return-Path: <linux-kernel-owner+w=401wt.eu-S1757089AbZCRC0Z@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator -
 hang traced
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200903121805.48041.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <1236817822.7680.148.camel@localhost.localdomain>
	 <1236818863.7680.156.camel@localhost.localdomain>
	 <200903121805.48041.elendil@planet.nl>
Content-Type: text/plain
Date: Tue, 17 Mar 2009 19:26:10 -0700
Message-Id: <1237343170.6160.131.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2009-03-12 at 18:05 +0100, Frans Pop wrote:
> Some other observations:
> * when the hang occurs we're definitely still using jiffies
> * the hang is not in the clock accumulation loop (see below)
> * changing the TIMERINT value does *not* make any difference, I tried a
>   few different values (incl. the default 50 and 300)
> * changing the nr of emulated CPUs from 2 to 1 makes no difference
> 
> 
> I have now been able to trace the hang (full log attached). Where I added
> tracing printks should be fairly obvious, and see attachment.
> No idea what to make of the result.
> 
>      0.150337! init: calling smp_prepare_cpus
>      0.183775! CPUs: 2 configured, 0 standby
>      0.183947! s390_smp: smp_detect_cpus calling get_online_cpus
>      0.184162! s390_smp: smp_detect_cpus calling __smp_rescan_cpus
>      0.184381! s390_smp: smp_rescan_cpus_sigp starting loop
> [!!! Hang is here !!!]
> 
> [... With 5cd1c9c5 and 6c9bacb4 reverted, the boot continues as follows ...]
> [... Next two messages are from Hercules ...]
> CPU0000: SIGP Set prefix (0D) CPU0001, PARM 0FEC5000: CC 0
> CPU0000: SIGP Restart (06) CPU0001, PARM 00000000: CC 0
> [... Time of previous message is similar for failed and good boot ...]
>      0.525049! s390_smp: smp_rescan_cpus_sigp loop done
>      0.525310! s390_smp: smp_detect_cpus calling put_online_cpus
>      0.525555! s390_smp: smp_detect_cpus done
>      0.526037! cpu 0 phys_idx=0 vers=00 ident=002623 machine=3090 unused=0000
>      0.526408! s390_smp: start loop smp_create_idle
>      0.531784! s390_smp: loop smp_create_idle done
> 
> The problem loop is in smp_rescan_cpus_sigp() from arch/s390/kernel/smp.c.
> 
> I tried adding printks inside the loop, but that resulted in the boot
> also failing with the two patches reverted!
> So it looks like that loop is somehow very sensitive to timing issues.
> Note the relatively long delay between the start and end of the loop.

Hey Frans,
	So I'm looking at the code and I think I've got an idea of what's going
on. Its a little messy and long winded, but stick with me :)

So, right now, I believe the timekeeping or clock steering code is
working properly as designed.

I too saw the code lock up in smp_rescan_cpus, but could find no reason
for it to block there. I do notice that interrupts seem to be working,
so I put a dump_stack() in update_wall_time() every few jiffies and I'd
get the exact same dump every time:

4.642524! ( <0000000000015d68>! show_trace+0x4c/0x88)                      
4.642885!   <0000000000059d4e>! update_wall_time+0x19e/0x778               
4.643281!   <000000000004541a>! do_timer+0x36/0xe8                         
4.643627!   <000000000005d67e>! tick_periodic+0x7a/0xf8                    
4.643977!   <000000000005d786>! tick_handle_periodic+0x8a/0xe8             
4.644350!   <0000000000019868>! clock_comparator_work+0x34/0x54            
4.644742!   <000000000001d368>! do_extint+0x60/0x104                       
4.645109!   <00000000000238ea>! ext_no_vtime+0x12/0x16                     
4.645480!   <0000000000024b52>! cpu_known+0x52/0x180                       
4.645845! ( <0000000000000000>! 0x0)                                       
4.646139!   <000000000032a466>! smp_prepare_cpus+0x172/0x4bc               
4.646523!   <0000000000320166>! kernel_init+0x52/0x364                     
4.646903!   <000000000001aae2>! kernel_thread_starter+0x6/0xc              
4.647288!   <000000000001aadc>! kernel_thread_starter+0x0/0xc   


So I added a printk in update_wall_time(), and a printk in
tick_handle_periodic(). For a short time, the two messages would
alternate, but then only update_wall_time is printed out.

So we're stuck in interrupt context. 

Somehow we're falling behind so that that the loop in
tick_handle_periodic() can't catch up and we just process interrupts
over and over.

In my testing, this isn't really specific to the recent rounding change,
however the rounding change made the issue crop up fast enough that it
could be seen, whereas before the issue wouldn't crop up before the tod
clock was installed. If you boot w/ clocksource=jiffies, you'll probably
see the hang with your working kernels as well, only at a later point
(it would be helpful if you would verify that and let me know).


So why does this happen here, but not w/ HZ != 250, or NOHZ?

Well, from my initial diagnosis, with HZ=250 we some severe error
correction initially. We don't see this with HZ=100 or HZ=1000, and
while we see some initial error correction w/ HZ=300, its not as severe.

So, with NOHZ, the desired accumulation interval is half a second. So w/
HZ=100 that's 50 jiffies, HZ=1000 its 500, HZ=300 is 150 and with HZ=250
it should be 125 jiffies.

However, its being calculated out as 124 jiffies. do_div() seems to be
giving a slightly off answer.

This causes quite a bit of interval error (seen as tick length error in
the code, but w/ NOHZ enabled, tick isn't quite the right word).
Interval error is the difference between how long a the interval should
be and the resulting clocksource interval. So an interval should be
500ms, but since we calculated out 124 jiffies per interval, we see an
4ms error per interval. This causes the jiffies clocksource freq to be
increased to correct for the error, which causes the clock to speed up
by 1/125. 

The net effect is that for each jiffy we are increasing time by more
then one jiffy.

Now, back to tick_handle_periodic(). Each interrupt, we call
tick_handle_periodic() to trigger a tick.  Each tick we increase jiffies
by one. However, if we're in oneshot mode(NOHZ) we also check the time
to see if we should "catch up", in effect, on ticks that we might have
slept through.

Now, maybe you can see the circularity here? :)

Jiffies is incremented each tick, and time is derived from jiffies.
However, we're using time to decide if we should trigger an extra tick.
This tick will in turn increase jiffies. Since the jiffies clocksource
is being sped up, we increment time by more then a tick. So then when we
check the time again, we're behind! Fire another tick! And on we go...


So two issues that I've found so far:
1) do_div() isn't dividing correctly in this case. Not sure why.

2) We *really* shouldn't be using oneshot mode while the jiffies
clocksource is in use. I believe x86 avoids this specifically, so I'm
not sure why s390 isn't doing the same. Still have to investigate.


So yea, *finally* a bit of progress here. Hopefully I can sort out a
patch shortly.

thanks
-john
