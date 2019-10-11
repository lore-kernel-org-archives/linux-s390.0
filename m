Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40853 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJg1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Oct 2019 05:36:27 -0400
Date: Fri, 11 Oct 2019 11:36:33 +0200
From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191011093633.GD27819@localhost>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010135043.GA16989@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010135043.GA16989@phenom.ffwll.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Oct 10, 2019 at 03:50:43PM +0200, Daniel Vetter wrote:
> On Thu, Oct 10, 2019 at 03:13:29PM +0200, Johan Hovold wrote:
> > Two old USB drivers had a bug in them which could lead to memory leaks
> > if an interrupted process raced with a disconnect event.
> > 
> > Turns out we had a few more driver in other subsystems with the same
> > kind of bug in them.

> Random funny idea: Could we do some debug annotations (akin to
> might_sleep) that splats when you might_sleep_interruptible somewhere
> where interruptible sleeps are generally a bad idea? Like in
> fops->release?

There's nothing wrong with interruptible sleep in fops->release per se,
it's just that drivers cannot return -ERESTARTSYS and friends and expect
to be called again later.

The return value from release() is ignored by vfs, and adding a splat in
__fput() to catch these buggy drivers might be overkill.

Johan
