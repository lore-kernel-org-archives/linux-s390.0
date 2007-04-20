Return-Path: <linux-kernel-owner+w=401wt.eu-S2992792AbXDTNFg@vger.kernel.org>
Date: Fri, 20 Apr 2007 18:39:08 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [S390] add arch_trampoline_kprobe.
Message-ID: <20070420130908.GA17273@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20070420110842.GA17147@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070420110842.GA17147@skybase>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, srinivasa@in.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 20, 2007 at 01:08:42PM +0200, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Add the missing arch_trampoline_kprobe function for s390 required by
> kprobes-the-on-off-knob-thru-debugfs-updated.patch.

Martin,

Cornelia provided this patch sometime earlier
(http://marc.info/?l=linux-kernel&m=117620748921086&w=2). Andrew has
picked it up into -mm.

Ananth

> 
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Srinivasa DS <srinivasa@in.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  arch/s390/kernel/kprobes.c |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> diff -urpN linux-2.6/arch/s390/kernel/kprobes.c linux-2.6-patched/arch/s390/kernel/kprobes.c
> --- linux-2.6/arch/s390/kernel/kprobes.c	2007-04-19 17:12:40.000000000 +0200
> +++ linux-2.6-patched/arch/s390/kernel/kprobes.c	2007-04-19 17:12:09.000000000 +0200
> @@ -658,6 +658,13 @@ static struct kprobe trampoline_p = {
>  	.pre_handler = trampoline_probe_handler
>  };
> 
> +int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> +{
> +	if (p->addr == (kprobe_opcode_t *)&kretprobe_trampoline)
> +		return 1;
> +	return 0;
> +}
> +
>  int __init arch_init_kprobes(void)
>  {
>  	return register_kprobe(&trampoline_p);
