Return-Path: <linux-kernel-owner+w=401wt.eu-S965451AbXDJMer@vger.kernel.org>
Date: Tue, 10 Apr 2007 18:08:21 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: 2.6.21-rc6-mm1
Message-ID: <20070410123821.GA24782@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20070408143559.f5014629.akpm@linux-foundation.org> <20070410142421.519eb62c@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070410142421.519eb62c@gondolin.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 10, 2007 at 02:24:21PM +0200, Cornelia Huck wrote:
> On Sun, 8 Apr 2007 14:35:59 -0700,
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.21-rc6/2.6.21-rc6-mm1/
> 
> > +kprobes-the-on-off-knob-thru-debugfs-updated.patch
> > +kprobes-the-on-off-knob-thru-debugfs-updated-fix.patch
> > 
> >  kprobes work
> 
> Add the missing arch_trampoline_kprobe() for s390.

Thanks Cornelia. My bad for missing s390.

> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> ---
>  arch/s390/kernel/kprobes.c |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> --- linux-2.6.21-rc6-mm1.orig/arch/s390/kernel/kprobes.c
> +++ linux-2.6.21-rc6-mm1/arch/s390/kernel/kprobes.c
> @@ -662,3 +662,10 @@ int __init arch_init_kprobes(void)
>  {
>  	return register_kprobe(&trampoline_p);
>  }
> +
> +int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> +{
> +	if (p->addr == (kprobe_opcode_t *) & kretprobe_trampoline)
> +		return 1;
> +	return 0;
> +}
