From: Aristeu Rozanski <aris@redhat.com>
Date: Thu, 01 Mar 2012 15:41:35 +0000
Subject: Re: [PATCH] s390: add missing KEYS_COMPAT Kconfig entry
Message-Id: <20120301154135.GA7721@redhat.com>
In-Reply-To: <20120301152115.GB2687@osiris.boeblingen.de.ibm.com>
References: <20120301152115.GB2687@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 01, 2012 at 04:21:15PM +0100, Heiko Carstens wrote:
> On Thu, Mar 01, 2012 at 10:11:50AM -0500, Aristeu Rozanski wrote:
> > Currently KEYS_COMPAT can't be used in s390 by lack of its Kconfig entry. This
> > patch adds the missing bit.
> > 
> > Signed-off-by: Aristeu Rozanski <aris@redhat.com>
> > 
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -637,6 +637,11 @@ source "arch/s390/Kconfig.debug"
> > 
> >  source "security/Kconfig"
> > 
> > +config KEYS_COMPAT
> > +	bool
> > +	depends on COMPAT && KEYS
> > +	default y
> > +
> >  source "crypto/Kconfig"
> 
> A similar patch from David Howells is part of today's pull request:
> https://lkml.org/lkml/2012/3/1/46
ah, cool, he didn't told me he'd send it upstream. thanks

-- 
Aristeu
