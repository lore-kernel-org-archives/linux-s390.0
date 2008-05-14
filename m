From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 14 May 2008 17:16:55 +0000
Subject: Re: [PATCH] S390:  Replace deprecated "__initcall" with equivalent
Message-Id: <alpine.LFD.1.10.0805141315490.21161@localhost.localdomain>
In-Reply-To: <20080513103543.GA12339@osiris.boeblingen.de.ibm.com>
References: <20080513103543.GA12339@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 13 May 2008, Heiko Carstens wrote:

> On Tue, May 13, 2008 at 05:27:02AM -0400, Robert P. J. Day wrote:
> > On Tue, 13 May 2008, Heiko Carstens wrote:
> > > Since when and why is __initcall deprecated?
> >
> > this goes back several years:
> >
> >   http://www.cs.helsinki.fi/linux/linux-kernel/2002-23/1209.html
> >
> > given the several levels of "init" calls these days, what used to be a
> > simple __initcall was redefined to represent device_initcall, as you
> > can see in <linux/init.h>:
> >
> > #define core_initcall(fn)               __define_initcall("1",fn,1)
> > #define core_initcall_sync(fn)          __define_initcall("1s",fn,1s)
> > #define postcore_initcall(fn)           __define_initcall("2",fn,2)
> > #define postcore_initcall_sync(fn)      __define_initcall("2s",fn,2s)
> > #define arch_initcall(fn)               __define_initcall("3",fn,3)
> > #define arch_initcall_sync(fn)          __define_initcall("3s",fn,3s)
> > #define subsys_initcall(fn)             __define_initcall("4",fn,4)
> > #define subsys_initcall_sync(fn)        __define_initcall("4s",fn,4s)
> > #define fs_initcall(fn)                 __define_initcall("5",fn,5)
> > #define fs_initcall_sync(fn)            __define_initcall("5s",fn,5s)
> > #define rootfs_initcall(fn)             __define_initcall("rootfs",fn,rootfs)
> > #define device_initcall(fn)             __define_initcall("6",fn,6)
> > #define device_initcall_sync(fn)        __define_initcall("6s",fn,6s)
> > #define late_initcall(fn)               __define_initcall("7",fn,7)
> > #define late_initcall_sync(fn)          __define_initcall("7s",fn,7s)
> >
> > #define __initcall(fn) device_initcall(fn)
> >
> >   obviously, the effect will still be the same, but the initcall
> > ordering will be more obvious when using the newer device_initcall.
>
> I wouldn't say that any of the initcall names makes it obvious to
> which level it corresponds... initcall6() would be much more
> readable than device_initcall().

> And even better would be if you could specify what your init
> function actually depends on, and let the kernel build system figure
> out the order of initcalls on its own.

i agree that that would be an even better situation, but i was just
going by what the situation is at the moment.  given the current
#define, obviously there's no actual need to change anything, so it's
entirely a judgment call.

rday
--


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
