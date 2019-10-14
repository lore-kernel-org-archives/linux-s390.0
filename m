Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Oct 2019 10:48:47 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191014084847.GD11828@phenom.ffwll.local>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010135043.GA16989@phenom.ffwll.local>
 <20191011093633.GD27819@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011093633.GD27819@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Fri, Oct 11, 2019 at 11:36:33AM +0200, Johan Hovold wrote:
> On Thu, Oct 10, 2019 at 03:50:43PM +0200, Daniel Vetter wrote:
> > On Thu, Oct 10, 2019 at 03:13:29PM +0200, Johan Hovold wrote:
> > > Two old USB drivers had a bug in them which could lead to memory leaks
> > > if an interrupted process raced with a disconnect event.
> > > 
> > > Turns out we had a few more driver in other subsystems with the same
> > > kind of bug in them.
> 
> > Random funny idea: Could we do some debug annotations (akin to
> > might_sleep) that splats when you might_sleep_interruptible somewhere
> > where interruptible sleeps are generally a bad idea? Like in
> > fops->release?
> 
> There's nothing wrong with interruptible sleep in fops->release per se,
> it's just that drivers cannot return -ERESTARTSYS and friends and expect
> to be called again later.

Do you have a legit usecase for interruptible sleeps in fops->release?

I'm not even sure killable is legit in there, since it's an fd, not a
process context ...

> The return value from release() is ignored by vfs, and adding a splat in
> __fput() to catch these buggy drivers might be overkill.

Ime once you have a handful of instances of a broken pattern, creating a
check for it (under a debug option only ofc) is very much justified.
Otherwise they just come back to life like the undead, all the time. And
there's a _lot_ of fops->release callbacks in the kernel.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
