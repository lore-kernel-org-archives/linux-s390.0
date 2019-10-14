Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34974 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbfJNQNT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Oct 2019 12:13:19 -0400
Date: Mon, 14 Oct 2019 18:13:26 +0200
From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191014161326.GO13531@localhost>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010135043.GA16989@phenom.ffwll.local>
 <20191011093633.GD27819@localhost>
 <20191014084847.GD11828@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014084847.GD11828@phenom.ffwll.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Oct 14, 2019 at 10:48:47AM +0200, Daniel Vetter wrote:
> On Fri, Oct 11, 2019 at 11:36:33AM +0200, Johan Hovold wrote:
> > On Thu, Oct 10, 2019 at 03:50:43PM +0200, Daniel Vetter wrote:
> > > On Thu, Oct 10, 2019 at 03:13:29PM +0200, Johan Hovold wrote:
> > > > Two old USB drivers had a bug in them which could lead to memory leaks
> > > > if an interrupted process raced with a disconnect event.
> > > > 
> > > > Turns out we had a few more driver in other subsystems with the same
> > > > kind of bug in them.
> > 
> > > Random funny idea: Could we do some debug annotations (akin to
> > > might_sleep) that splats when you might_sleep_interruptible somewhere
> > > where interruptible sleeps are generally a bad idea? Like in
> > > fops->release?
> > 
> > There's nothing wrong with interruptible sleep in fops->release per se,
> > it's just that drivers cannot return -ERESTARTSYS and friends and expect
> > to be called again later.
> 
> Do you have a legit usecase for interruptible sleeps in fops->release?

The tty layer depends on this for example when waiting for buffered
writes to complete (something which may never happen when using flow
control).

> I'm not even sure killable is legit in there, since it's an fd, not a
> process context ...

It will be run in process context in many cases, and for ttys we're good
AFAICT.

> > The return value from release() is ignored by vfs, and adding a splat in
> > __fput() to catch these buggy drivers might be overkill.
> 
> Ime once you have a handful of instances of a broken pattern, creating a
> check for it (under a debug option only ofc) is very much justified.
> Otherwise they just come back to life like the undead, all the time. And
> there's a _lot_ of fops->release callbacks in the kernel.

Yeah, you have a point.

But take tty again as an example, the close tty operation called from
release() is declared void so there's no propagated return value for vfs
to check.

It may even be better to fix up the 100 or so callbacks potentially
returning non-zero and make fops->release void so that the compiler
would help us catch any future bugs and also serve as a hint for
developers that returning errnos from fops->release is probably not
what you want to do.

But that's a lot of churn of course.

Johan
