From: "Robert P. J. Day" <rpjday@mindspring.com>
Date: Fri, 14 Sep 2007 10:51:05 +0000
Subject: Re: [PATCH] S390:  Make ramdisk size for S390 8192 by default.
Message-Id: <Pine.LNX.4.64.0709140650050.19139@localhost.localdomain>
In-Reply-To: <20070914104850.GB11842@osiris.boeblingen.de.ibm.com>
References: <20070914104850.GB11842@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 14 Sep 2007, Heiko Carstens wrote:

> >   it seems pointless to have a strong recommendation when you can just
> > make it the default.  if that help text is still relevant, that is.
> >
> >
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> > index 4245b7f..39b34e5 100644
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -358,11 +358,11 @@ config BLK_DEV_RAM_COUNT
> >  config BLK_DEV_RAM_SIZE
> >  	int "Default RAM disk size (kbytes)"
> >  	depends on BLK_DEV_RAM
> > +	default "8192" if S390
> >  	default "4096"
> >  	help
> >  	  The default value is 4096 kilobytes. Only change this if you know
> > -	  what are you doing. If you are using IBM S/390, then set this to
> > -	  8192.
> > +	  what are you doing.
>
> Thanks, but I would prefer to not have any special default value for
> s390 anymore. The 8 MB is a leftover when we had a default
> INITRD_SIZE of 8 MB. But that default is gone as well (default now:
> 0). Just deleting the text that refers to s390 would be better.

ok, easy enough.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
