Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Nov 2017 10:22:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/9] s390: net: add SPDX identifiers to the remaining
 files
Message-ID: <20171115092243.GC800@kroah.com>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
 <20171114173808.25092-6-gregkh@linuxfoundation.org>
 <20171114202249.GA3059@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114202249.GA3059@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 14, 2017 at 09:22:49PM +0100, Heiko Carstens wrote:
> On Tue, Nov 14, 2017 at 06:38:04PM +0100, Greg Kroah-Hartman wrote:
> > It's good to have SPDX identifiers in all files to make it easier to
> > audit the kernel tree for correct licenses.
> > 
> > Update the drivers/s390/net/ files with the correct SPDX license
> > identifier based on the license text in the file itself.  The SPDX
> > identifier is a legally binding shorthand, which can be used instead of
> > the full boiler plate text.
> > 
> > This work is based on a script and data from Thomas Gleixner, Philippe
> > Ombredanne, and Kate Stewart.
> > 
> > Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
> > Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
> > index 8c14c6c3ad3d..f0c7c182b077 100644
> > --- a/drivers/s390/net/fsm.c
> > +++ b/drivers/s390/net/fsm.c
> > @@ -1,3 +1,4 @@
> >
> > +// SPDX-License-Identifier: GPL-2.0
> >  /**
> >   * A generic FSM based on fsm used in isdn4linux
> >   *
> 
> What's the rationale to add GPL-2.0 to this file? This seems to be a bit
> confusing since this file has no explicit license template, except this
> one:
> 
> MODULE_LICENSE("GPL");
> 
> Which, according to include/linux/module.h translates to
>     "GPL" [GNU Public License v2 or later]
> 
> On the other hand there are files like drivers/s390/char/zcore.c which just
> contain a statement "License: GPL", which was converted to GPL-1.0+ (see
> patch 4 of this series).
> Right now I'm not saying that anything is wrong here, but I'd like to
> understand the rationale.

For any files with no explicit license in them, like this one, the
"implicit" license of GPL-2.0 is assumed.  See commit b24413180f56
("License cleanup: add SPDX GPL-2.0 license identifier to files with no
license") in Linus's tree for a full description of this, where we
converted all in-tree files at the time that did not have a explicit
license in it.  It seems this file missed that initial commit, sorry, I
don't know how that happened, especially as this file has been in the
tree for a very very long time.

Philippe, any ideas how we missed this file in the previous large sweep?

thanks,

greg k-h
