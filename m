Return-Path: <linux-kernel-owner+w=401wt.eu-S1753097AbYDWH2f@vger.kernel.org>
Date: Wed, 23 Apr 2008 09:28:21 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC patch 7/9] S390 remove -traditional
Message-ID: <20080423072821.GA15850@osiris.boeblingen.de.ibm.com>
References: <20080422172404.502954084@polymtl.ca> <20080422172842.809030360@polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080422172842.809030360@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 22, 2008 at 01:24:11PM -0400, Mathieu Desnoyers wrote:
> Subject: [RFC patch 7/9] Re: [PATCH] Stringify support commas
>  > This is a no-no for those archs that still use -traditional.
>  > > I dunno if this is a problem for you at the moment and the
>  > > right fix is anyway to nuke -traditional.
>  > > 
>  > >     Sam
> 
> (cross-compile test ok)
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> CC: Sam Ravnborg <sam@ravnborg.org>
> CC: schwidefsky@de.ibm.com
> CC: heiko.carstens@de.ibm.com
> CC: linux390@de.ibm.com
> CC: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/Makefile   |    2 --
>  arch/s390/lib/Makefile      |    2 --
>  arch/s390/math-emu/Makefile |    1 -
>  3 files changed, 5 deletions(-)
> 
> Index: linux-2.6-lttng/arch/s390/kernel/Makefile
> ===================================================================
> --- linux-2.6-lttng.orig/arch/s390/kernel/Makefile	2008-04-21 10:04:43.000000000 -0400
> +++ linux-2.6-lttng/arch/s390/kernel/Makefile	2008-04-21 10:04:47.000000000 -0400
> @@ -2,8 +2,6 @@
>  # Makefile for the linux kernel.
>  #
> 
> -EXTRA_AFLAGS	:= -traditional
> -

Thanks, applied. This did cause problems in late 2.6.25 and I think Martin
had a similar patch ready.
