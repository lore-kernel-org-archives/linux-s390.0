From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 20 Aug 2008 11:01:08 +0000
Subject: Re: [PATCH] s390: fix uninitialized spinlock use
Message-Id: <20080820110108.GA13103@osiris.boeblingen.de.ibm.com>
In-Reply-To: <1219167249-1473-1-git-send-email-jeffpc@josefsipek.net>
References: <1219167249-1473-1-git-send-email-jeffpc@josefsipek.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 19, 2008 at 01:34:09PM -0400, Josef 'Jeff' Sipek wrote:
> Ever since commit 43ca5c3a1cefdaa09231d64485b8f676118bf1e0 ([S390] Convert
> monitor calls to function calls.), the kernel refused to IPL with spinlock
> debugging enabled.
> 
> BUG: spinlock bad magic on CPU#0, swapper/0
>  lock: 00000000003a4668, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 0 Not tainted 2.6.25 #1
> Process swapper (pid: 0, task: 000000000034f958, ksp: 0000000000377d60)
> 0000000000377ab8 0000000000352628 0000000000377d60 0000000000377d60
>        0000000000016af4 00000000fffff7b5 0000000000377d60 0000000000000000
>        0000000000000000 0000000000377a18 0000000000000009 0000000000377a18
>        0000000000377a78 000000000023c920 0000000000016af4 0000000000377a18
>        0000000000000005 0000000000000000 0000000000377b58 0000000000377ab8
> Call Trace:
> ([<0000000000016a60>] show_trace+0xdc/0x108)
>  [<0000000000016b4e>] show_stack+0xc2/0xfc
>  [<0000000000016c9a>] dump_stack+0xb2/0xc0
>  [<0000000000172dd4>]

[...]

> -DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
> +DEFINE_PER_CPU(struct s390_idle_data, s390_idle) = {
> +	.lock = __SPIN_LOCK_UNLOCKED(s390_idle.lock)
> +};

Ah, thanks! Guess I didn't test a non CONFIG_SMP build.
