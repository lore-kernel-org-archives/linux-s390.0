Return-Path: <linux-kernel-owner+w=401wt.eu-S1755204AbZFHSs0@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 01/38] pm: Move nvs routines into a seperate file.
Date: Mon, 8 Jun 2009 20:48:28 +0200
References: <20090604161847.513682672@de.ibm.com> <20090608063501.GC1444@ucw.cz> <20090608173611.16238cf9@gondolin>
In-Reply-To: <20090608173611.16238cf9@gondolin>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906082048.28779.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Monday 08 June 2009, Cornelia Huck wrote:
> On Mon, 8 Jun 2009 08:35:01 +0200,
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > On Thu 2009-06-04 18:18:48, Martin Schwidefsky wrote:
> > > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > 
> > > The *_nvs_* routines in swsusp.c make use of the io*map()
> > > functions, which are only provided for HAS_IOMEM, thus
> > > breaking compilation if HAS_IOMEM is not set. Fix this
> > > by moving the *_nvs_* routines into nvs.c, which is only
> > > compiled if HAS_IOMEM is set.
> > > 
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > ---
> > >  include/linux/suspend.h |   18 ++++--
> > >  kernel/power/Kconfig    |    4 +
> > >  kernel/power/Makefile   |    1 
> > >  kernel/power/nvs.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  kernel/power/swsusp.c   |  122 --------------------------------------------
> > >  5 files changed, 147 insertions(+), 129 deletions(-)
> > > 
> > > Index: linux-2.6/kernel/power/nvs.c
> > > ===================================================================
> > > --- /dev/null
> > > +++ linux-2.6/kernel/power/nvs.c
> > 
> > Ideally, filename would be a bit more descriptive. 
> 
> hibernate_nvs.c?

Yes, please.

> > > @@ -0,0 +1,131 @@
> > > +/*
> > > + * Routines for NVS memory handling
> > > + */
> > 
> > If you copy&pasted code, you need to copy&paste copyright notices, too.
> 
> Which ones? Rafael, it seems you wrote the NVS code - which copyright
> should I use?

Same as in kernel/irq/pm.c , please.

> > > --- linux-2.6.orig/kernel/power/Makefile
> > > +++ linux-2.6/kernel/power/Makefile
> > > @@ -7,5 +7,6 @@ obj-$(CONFIG_PM)		+= main.o
> > >  obj-$(CONFIG_PM_SLEEP)		+= console.o
> > >  obj-$(CONFIG_FREEZER)		+= process.o
> > >  obj-$(CONFIG_HIBERNATION)	+= swsusp.o disk.o snapshot.o swap.o user.o
> > > +obj-$(CONFIG_NVS)		+= nvs.o
> > >  
> > >  obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
> > 
> > CONFIG_NVS is definitely not descriptive enough. C_HIBERNATION_NVS?
> 
> It's a hidden config variable - but I can change it to
> CONFIG_HIBERNATION_NVS.

Please do that too.

When you're done, please send the patch to me and I'll put it into the suspend
tree for 2.6.31.

Best,
Rafael
