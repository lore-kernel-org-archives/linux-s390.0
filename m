Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 22 Jan 2019 17:33:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] s390: kernel: no need to check return value of
 debugfs_create functions
Message-ID: <20190122163337.GB23510@kroah.com>
References: <20190122152151.16139-3-gregkh@linuxfoundation.org>
 <20190122162454.GA31034@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122162454.GA31034@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 22, 2019 at 05:24:54PM +0100, Heiko Carstens wrote:
> On Tue, Jan 22, 2019 at 04:21:02PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/s390/kernel/debug.c    | 6 ------
> >  arch/s390/kernel/kdebugfs.c | 2 --
> >  arch/s390/kernel/sysinfo.c  | 2 --
> >  3 files changed, 10 deletions(-)
> > diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> > index 12f80d1f0415..2ac3c9b56a13 100644
> > --- a/arch/s390/kernel/sysinfo.c
> > +++ b/arch/s390/kernel/sysinfo.c
> > @@ -545,8 +545,6 @@ static __init int stsi_init_debugfs(void)
> >  	int lvl, i;
> > 
> >  	stsi_root = debugfs_create_dir("stsi", arch_debugfs_dir);
> > -	if (IS_ERR_OR_NULL(stsi_root))
> > -		return 0;
> 
> No objections, however will you also change the odd behaviour that
> e.g. debugfs_create_file() returns -ENODEV instead of (the expected)
> NULL pointer if CONFIG_DEBUGFS is disabled?

Nope.  That is intentional.

> I do remember this since it caused at least one crash ;)

Which is why you shouldn't care about the return value of these
functions :)

> 19cdd08ba155 ("[S390] qdio: fix broken pointer in case of CONFIG_DEBUG_FS is disabled").

Odd, what crashes when passed an error pointer?  What was someone trying
to do with those pointers?  The only thing you can do with a return
value from a debugfs function is to pass it back into another debugfs
call.  Sounds like someone wasn't doing that :(

Given that that patch was from 2.6.29, I think we are safe...

thanks,

greg k-h
