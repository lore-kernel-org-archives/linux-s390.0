From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 05:37:13 +0000
Subject: Re: drivers/tty/serial/8250/8250.c:109:24: fatal error: asm/serial.h: No such file or directory
Message-Id: <20130329053713.GA14438@localhost>
In-Reply-To: <20130329034754.GA13698@localhost>
References: <20130329034754.GA13698@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 29, 2013 at 11:47:54AM +0800, Fengguang Wu wrote:
> Hi Paul,
> 
> > Hi Fengguang,
> > 
> > I don't think this is right.  It can't be a 14 month old change.
> > The 2nd error itself totally smells like uapi changes.
> > 
> > The 1st error makes no sense at all when you look at this:
> > 
> > config SERIAL_8250_RUNTIME_UARTS
> >         int "Number of 8250/16550 serial ports to register at runtime"
> >         depends on SERIAL_8250
> > 
> > How can you build 8250 support and not have a value for the
> > number of runtime UARTs, given the above?
> > 
> > I also just checked that mainline v3.9-rc4-158-g9064171 has no
> > problems building drivers/tty/* for s390 while x-compiling in
> > my local test of allmodconfig.
> 
> You are right! I cannot reproduce this problem in upstream and
> linux-next. It should be some problem with my build scripts..

OK I got the root cause: the error

        drivers/tty/serial/8250/8250.c:101:24: fatal error: asm/serial.h: No such file or directory

is first detected in tree/branch

        git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/r8a73a4

where 8250 is enabled on "make ARCH=s390 allmodconfig":

CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

The build script then start bisecting command

        make ARCH=s390 drivers/tty/serial/8250/8250.o

and goes all the way down to commit 9bef3d41973 ("serial: group all
the 8250 related code together"), not being aware of the
CONFIG_SERIAL_8250 was disabled in earlier kernels.

Thanks,
Fengguang
