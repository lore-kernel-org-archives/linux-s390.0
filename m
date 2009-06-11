Return-Path: <linux-kernel-owner+w=401wt.eu-S1760453AbZFKVMT@vger.kernel.org>
Date: Thu, 11 Jun 2009 23:11:57 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pm: Move nvs routines into a seperate file.
Message-ID: <20090611211157.GD27376@elf.ucw.cz>
References: <20090604161847.513682672@de.ibm.com> <200906082048.28779.rjw@sisk.pl> <20090609104003.50830165@gondolin> <200906100109.20470.rjw@sisk.pl> <20090611133218.GB3146@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090611133218.GB3146@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2009-06-11 15:32:18, Heiko Carstens wrote:
> On Wed, Jun 10, 2009 at 01:09:19AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday 09 June 2009, Cornelia Huck wrote:
> > > The *_nvs_* routines in swsusp.c make use of the io*map()
> > > functions, which are only provided for HAS_IOMEM, thus
> > > breaking compilation if HAS_IOMEM is not set. Fix this
> > > by moving the *_nvs_* routines into hibernation_nvs.c, which
> > > is only compiled if HAS_IOMEM is set.
> > > 
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > Thanks, I added the GPLv2 line to the header comment and changed the name
> > of the file to hibernate_nvs.c (to match the other changes in the works).
> > 
> > I'll carry out some compilation testing on it and put it into the tree shortly.
> 
> Rafael, could you add the patch below as well?
> Or should that go in via git390?
> 
> Subject: [PATCH] PM: add empty suspend/resume device irq functions
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> git commit 0a0c5168 "PM: Introduce functions for suspending and resuming
> device interrupts" introduced some helper functions. However these
> functions are only available for architectures which support
> GENERIC_HARDIRQS.
> 
> Other architectures will see this build error:
> 
> drivers/built-in.o: In function `sysdev_suspend':
> (.text+0x15138): undefined reference to `check_wakeup_irqs'
> drivers/built-in.o: In function `device_power_up':
> (.text+0x1cb66): undefined reference to `resume_device_irqs'
> drivers/built-in.o: In function `device_power_down':
> (.text+0x1cb92): undefined reference to `suspend_device_irqs'
> 
> To fix this add some empty inline functions for !GENERIC_HARDIRQS.

I don't think that's right fix. If architecture does not use
GENERIC_HARDIRQS, it may want to implement *_device_irqs()
itself. Before your patch, it could, after your patch, it can not.

Better put those empty functions in arch/s390/include?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
