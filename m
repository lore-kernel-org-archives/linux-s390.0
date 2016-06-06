Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Jun 2016 10:21:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 4.7-rc1/s390: WARNING: CPU: 5 PID: 1 at
 kernel/events/core.c:8485 perf_pmu_register+0x420/0x428
Message-ID: <20160606082124.GA30154@twins.programming.kicks-ass.net>
References: <201606060737.u567YMPJ012970@mx0a-001b2d01.pphosted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201606060737.u567YMPJ012970@mx0a-001b2d01.pphosted.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 06, 2016 at 09:37:41AM +0200, Christian Borntraeger wrote:
> Peter, Hendrik,
> 
> commit 26657848502b ("perf/core: Verify we have a single perf_hw_context PMU") seems to 
> trigger the newly created warning on a z196.
> 
> 
> [    2.202363] ------------[ cut here ]------------
> [    2.202372] WARNING: CPU: 5 PID: 1 at kernel/events/core.c:8485 perf_pmu_register+0x420/0x428
> [    2.202373] Modules linked in:
> [    2.202377] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc1+ #2
> [    2.202379] task: 00000009c5240000 ti: 00000009c5234000 task.ti: 00000009c5234000
> [    2.202381] Krnl PSW : 0704c00180000000 0000000000220c50 (perf_pmu_register+0x420/0x428)
> [    2.202385]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: ffffffffffffffff 0000000000b15ac6 0000000000000000 00000009cb440000
> [    2.202388]            000000000022087a 0000000000000000 0000000000b78fa0 0000000000000000
> [    2.202390]            0000000000a9aa90 0000000000000084 0000000000000005 000000000088a97a
> [    2.202405]            0000000000000004 0000000000749dd0 000000000022087a 00000009c5237cc0
> [    2.202415] Krnl Code: 0000000000220c44: a7f4ff54            brc     15,220aec
>            0000000000220c48: 92011000           mvi     0(%r1),1
>           #0000000000220c4c: a7f40001           brc     15,220c4e
>           >0000000000220c50: a7f4ff12           brc     15,220a74
>            0000000000220c54: 0707               bcr     0,%r7
>            0000000000220c56: 0707               bcr     0,%r7
>            0000000000220c58: ebdff0800024       stmg    %r13,%r15,128(%r15)
>            0000000000220c5e: a7f13fe0           tmll    %r15,16352
> [    2.202431] Call Trace:
> [    2.202433] ([<000000000022087a>] perf_pmu_register+0x4a/0x428)
> [    2.202438] ([<0000000000b2c25c>] init_cpum_sampling_pmu+0x14c/0x1f8)
> [    2.202441] ([<0000000000100248>] do_one_initcall+0x48/0x140)
> [    2.202444] ([<0000000000b25d26>] kernel_init_freeable+0x1e6/0x2a0)
> [    2.202449] ([<000000000072bda4>] kernel_init+0x24/0x138)
> [    2.202453] ([<000000000073495e>] kernel_thread_starter+0x6/0xc)
> [    2.202455] ([<0000000000734958>] kernel_thread_starter+0x0/0xc)
> [    2.202456] Last Breaking-Event-Address:
> [    2.202458]  [<0000000000220c4c>] perf_pmu_register+0x41c/0x428
> [    2.202460] ---[ end trace 0c6ef9f5b771ad97 ]---
> 
> Looks like perf_pmu_register does not like to be called twice (once for the counter
> and once for the sampling facility).

Twice isn't the problem per se, its trying to register two PMUs for
perf_hw_context that is the problem.

The perf core does not expect or deal well with that.

The perf core expects a single HW PMU in that when it schedules
hw_context events, and encounters an failure to pmu::add() (because the
hw pmu is 'full') it stops trying to add more events.

So if you mix two PMUs in, you get horrible PMU utilization issues,
because as soon as one is full, it will not try and add more events and
can leave the other empty.
