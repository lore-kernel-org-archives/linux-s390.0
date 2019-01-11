Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 11 Jan 2019 16:47:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1] s390/smp: Fix calling smp_call_ipl_cpu() from ipl
 CPU
Message-ID: <20190111164746.015e16da.cohuck@redhat.com>
In-Reply-To: <20190111141822.17262-1-david@redhat.com>
References: <20190111141822.17262-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 11 Jan 2019 15:18:22 +0100
David Hildenbrand <david@redhat.com> wrote:

> When calling smp_call_ipl_cpu() from the IPL CPU, we will try to read
> from pcpu_devices->lowcore. However, due to prefixing, that will result
> in reading from absolute address 0 on that CPU. We have to go via the
> actual lowcore instead.
> 
> This means that right now, we will read lc->nodat_stack == 0 and
> therfore work on a very wrong stack.
> 
> This BUG essentially broke rebooting under QEMU TCG (which will report
> a low address protection exception). And checking under KVM, it is
> also broken under KVM. With 1 VCPU it can be easily triggered.
> 
> :/# echo 1 > /proc/sys/kernel/sysrq
> :/# echo b > /proc/sysrq-trigger
> [   28.476745] sysrq: SysRq : Resetting
> [   28.476793] Kernel stack overflow.
> [   28.476817] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
> [   28.476820] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
> [   28.476826] Krnl PSW : 0400c00180000000 0000000000115c0c (pcpu_delegate+0x12c/0x140)
> [   28.476861]            R:0 T:1 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   28.476863] Krnl GPRS: ffffffffffffffff 0000000000000000 000000000010dff8 0000000000000000
> [   28.476864]            0000000000000000 0000000000000000 0000000000ab7090 000003e0006efbf0
> [   28.476864]            000000000010dff8 0000000000000000 0000000000000000 0000000000000000
> [   28.476865]            000000007fffc000 0000000000730408 000003e0006efc58 0000000000000000
> [   28.476887] Krnl Code: 0000000000115bfe: 4170f000            la      %r7,0(%r15)
> [   28.476887]            0000000000115c02: 41f0a000            la      %r15,0(%r10)
> [   28.476887]           #0000000000115c06: e370f0980024        stg     %r7,152(%r15)
> [   28.476887]           >0000000000115c0c: c0e5fffff86e        brasl   %r14,114ce8
> [   28.476887]            0000000000115c12: 41f07000            la      %r15,0(%r7)
> [   28.476887]            0000000000115c16: a7f4ffa8            brc     15,115b66
> [   28.476887]            0000000000115c1a: 0707                bcr     0,%r7
> [   28.476887]            0000000000115c1c: 0707                bcr     0,%r7
> [   28.476901] Call Trace:
> [   28.476902] Last Breaking-Event-Address:
> [   28.476920]  [<0000000000a01c4a>] arch_call_rest_init+0x22/0x80
> [   28.476927] Kernel panic - not syncing: Corrupt kernel stack, can't continue.
> [   28.476930] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
> [   28.476932] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
> [   28.476932] Call Trace:
> 
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/smp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I can confirm that this patch fixes rebooting for me, both under
QEMU/TCG and under QEMU/KVM (1 vcpu).

Tested-by: Cornelia Huck <cohuck@redhat.com>
