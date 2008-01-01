Return-Path: <linux-kernel-owner+w=401wt.eu-S1756642AbYAARmZ@vger.kernel.org>
Date: Tue, 1 Jan 2008 18:42:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: (Try #2) [Patch 3/8] S390: Tiny fixes for Makefile
Message-ID: <20080101174214.GB31575@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101072555.GD2496@hacking> <20080101101720.GC28913@uranus.ravnborg.org> <20080101132739.GC2499@hacking>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080101132739.GC2499@hacking>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 01, 2008 at 09:27:39PM +0800, WANG Cong wrote:
> 
> >> -binfmt_elf32.o:	$(TOPDIR)/fs/binfmt_elf.c
> >> +binfmt_elf32.o:	$(objtree)/fs/binfmt_elf.c
> >
> >This prerequisite listing looks just bogus and should be removed altogether.
> >We only need to list prerequisites explicit for generated files.
> 
> Not so sure whether this is what s390 people do on purpose.
> Thanks anyway!
> 
> The following one contains the new fix.
> 
> ------------>
> 
> This patch removes TOPDIR and fixes a bogus prerequisite
> in arch/s390/kernel/Makefile.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
> 
> ----
> 
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 56cb710..4accf27 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -20,7 +20,7 @@ obj-$(CONFIG_AUDIT)		+= audit.o
>  compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
>  obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
>  					compat_wrapper.o compat_exec_domain.o \
> -					binfmt_elf32.o $(compat-obj-y)
> +					binfmt_elf.o $(compat-obj-y)
>  
>  obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> @@ -34,4 +34,4 @@ obj-$(CONFIG_KEXEC) += $(S390_KEXEC_OBJS)
>  #
>  # This is just to get the dependencies...
>  #
> -binfmt_elf32.o:	$(TOPDIR)/fs/binfmt_elf.c
> +binfmt_elf.o:	$(objtree)/fs/binfmt_elf.c

This is wrong. s390 have a file named binfmt_elf32.c and with this
change it does no longer build.

If the output file does not exist then kbuild does not care about the
dependencies and will just build the target.
On the second invocation when the target exists then kbuild has
created a file named .<target>.cmd that list the dependencies
and this includes any included .c file.
So there is just no pint in defining this dependency explicit
in the MAkefile - kbuild will figure it out automatically.

The right fix is just to kill the explicit listed dependency.

	Sam
