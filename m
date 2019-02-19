Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 19 Feb 2019 10:45:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] s390/setup: fix early warning messages
Message-ID: <20190219184546.GA19356@roeck-us.net>
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1>
 <20190218182106.61b10ee4@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218182106.61b10ee4@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 18, 2019 at 06:21:06PM +0100, Martin Schwidefsky wrote:
> On Mon, 18 Feb 2019 18:01:46 +0100
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Mon, 18 Feb 2019 07:46:40 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > Hi,
> > > 
> > > On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:  
> > > > The setup_lowcore() function creates a new prefix page for the boot CPU.
> > > > The PSW mask for the system_call, external interrupt, i/o interrupt and
> > > > the program check handler have the DAT bit set in this new prefix page.
> > > > 
> > > > At the time setup_lowcore is called the system still runs without virtual
> > > > address translation, the paging_init() function creates the kernel page
> > > > table and loads the CR13 with the kernel ASCE.
> > > > 
> > > > Any code between setup_lowcore() and the end of paging_init() that has
> > > > a BUG or WARN statement will create a program check that can not be
> > > > handled correctly as there is no kernel page table yet.
> > > > 
> > > > To allow early WARN statements initially setup the lowcore with DAT off
> > > > and set the DAT bit only after paging_init() has completed.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>    
> > > 
> > > This patch causes s390 qemu emulations to crash with a kernel stack overflow.
> > > Reverting the patch fixes the problem. Crash log and bisect results below.  
> > 
> > Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
> > with 4K mapping where the prefix page is mapped to absolute zero.
> > 
> > Just using S390_lowcore instead of lowcore_ptr[0] does not work either
> > because low-address protection is already active. I'll think of something.
> > 
> > Thanks for bug report!
>  
> This patch should fix the problem:
> --
> >From d4393e82c3ec9b2fe5dba4b0d1b6eef29f8d15c8 Mon Sep 17 00:00:00 2001
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date: Mon, 18 Feb 2019 18:10:08 +0100
> Subject: [PATCH] s390/setup: fix boot crash for machine without EDAT-1
> 
> The fix to make WARN work in the early boot code created a problem
> on older machines without EDAT-1. The setup_lowcore_dat_on function
> uses the pointer from lowcore_ptr[0] to set the DAT bit in the new
> PSWs. That does not work if the kernel page table is set up with
> 4K pages as the prefix address maps to absolute zero.
> 
> To make this work the PSWs need to be changed with via address 0 in
> form of the S390_lowcore definition.
> 
> Cc: stable@vger.kernel.org
> Fixes: 94f85ed3e2 ("s390/setup: fix early warning messages")
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/s390/kernel/setup.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 65b22ef5141a..12934e8fbb91 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -451,13 +451,12 @@ static void __init setup_lowcore_dat_off(void)
>  
>  static void __init setup_lowcore_dat_on(void)
>  {
> -	struct lowcore *lc;
> -
> -	lc = lowcore_ptr[0];
> -	lc->external_new_psw.mask |= PSW_MASK_DAT;
> -	lc->svc_new_psw.mask |= PSW_MASK_DAT;
> -	lc->program_new_psw.mask |= PSW_MASK_DAT;
> -	lc->io_new_psw.mask |= PSW_MASK_DAT;
> +	__ctl_clear_bit(0, 28);
> +	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
> +	S390_lowcore.svc_new_psw.mask |= PSW_MASK_DAT;
> +	S390_lowcore.program_new_psw.mask |= PSW_MASK_DAT;
> +	S390_lowcore.io_new_psw.mask |= PSW_MASK_DAT;
> +	__ctl_set_bit(0, 28);
>  }
>  
>  static struct resource code_resource = {
> -- 
> 2.16.4
> 
> 
> -- 
> blue skies,
>    Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> 
