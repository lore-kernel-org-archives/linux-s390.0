Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46009 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfJUJyw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Oct 2019 05:54:52 -0400
Date: Mon, 21 Oct 2019 11:55:00 +0200
From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191021095500.GE24768@localhost>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010135043.GA16989@phenom.ffwll.local>
 <20191011093633.GD27819@localhost>
 <20191014084847.GD11828@phenom.ffwll.local>
 <20191014161326.GO13531@localhost>
 <20191015140726.GN11828@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015140726.GN11828@phenom.ffwll.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Tue, Oct 15, 2019 at 04:07:26PM +0200, Daniel Vetter wrote:
> On Mon, Oct 14, 2019 at 06:13:26PM +0200, Johan Hovold wrote:
> > On Mon, Oct 14, 2019 at 10:48:47AM +0200, Daniel Vetter wrote:

> > > Do you have a legit usecase for interruptible sleeps in fops->release?
> > 
> > The tty layer depends on this for example when waiting for buffered
> > writes to complete (something which may never happen when using flow
> > control).
> > 
> > > I'm not even sure killable is legit in there, since it's an fd, not a
> > > process context ...
> > 
> > It will be run in process context in many cases, and for ttys we're good
> > AFAICT.
> 
> Huh, read it a bit, all the ->shutdown callbacks have void return type.
> But there's indeed interruptible sleeps in there. Doesn't this break
> userspace that expects that a close() actually flushes the tty?

This behaviour has been there since "forever" so the problem is rather
the other way round; changing it now might break user space.

> Imo if you're ->release callbacks feels like it should do a wait to
> guaranteed something userspace expects, then doing a
> wait_interruptible/killable feels like a bug. Or alternatively, the wait
> isn't really needed in the first place.

Posix says that the final tty close should cause any output to be sent.
And as mentioned before, due to flow control this may never finish. So
for usability reasons, you want to be able to interrupt that final
close, while removing the flush completely would break applications
currently expecting output to be flushed.

Also note that we have an interface for controlling how long to wait for
data to be sent (typically 30 s by default, but can be set to wait
forever).

> > > > The return value from release() is ignored by vfs, and adding a splat in
> > > > __fput() to catch these buggy drivers might be overkill.
> > > 
> > > Ime once you have a handful of instances of a broken pattern, creating a
> > > check for it (under a debug option only ofc) is very much justified.
> > > Otherwise they just come back to life like the undead, all the time. And
> > > there's a _lot_ of fops->release callbacks in the kernel.
> > 
> > Yeah, you have a point.
> > 
> > But take tty again as an example, the close tty operation called from
> > release() is declared void so there's no propagated return value for vfs
> > to check.
> > 
> > It may even be better to fix up the 100 or so callbacks potentially
> > returning non-zero and make fops->release void so that the compiler
> > would help us catch any future bugs and also serve as a hint for
> > developers that returning errnos from fops->release is probably not
> > what you want to do.
> > 
> > But that's a lot of churn of course.
> 
> Hm indeed ->release has int as return type. I guess that's needed for
> file I/O errno and similar stuff ...
> 
> Still void return value doesn't catch funny stuff like doing interruptible
> waits and occasionally failing if you have a process that likes to use
> signals and also uses some library somewhere to do something. In graphics
> we have that, with Xorg loving signals for various things.

Right, but since there arguable are legitimate uses for interruptible
sleep at release(), I don't see how we can catch that at runtime.

Johan
