Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35695 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJNus (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 09:50:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id v8so5551419eds.2
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 06:50:47 -0700 (PDT)
Date: Thu, 10 Oct 2019 15:50:43 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191010135043.GA16989@phenom.ffwll.local>
References: <20191010131333.23635-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010131333.23635-1-johan@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Oct 10, 2019 at 03:13:29PM +0200, Johan Hovold wrote:
> Two old USB drivers had a bug in them which could lead to memory leaks
> if an interrupted process raced with a disconnect event.
> 
> Turns out we had a few more driver in other subsystems with the same
> kind of bug in them.
> 
> Note that all but the s390 patch have only been compile tested, while
> the s390 one has not even been built.

Random funny idea: Could we do some debug annotations (akin to
might_sleep) that splats when you might_sleep_interruptible somewhere
where interruptible sleeps are generally a bad idea? Like in
fops->release?

Something like non_block_start/end that I've recently done, but for
interruptible sleeps only? Would need might_sleep_interruptibly()
annotations and non_interruptly_sleep_start/end annotations.
-Daniel

> 
> Johan
> 
> 
> Johan Hovold (4):
>   drm/msm: fix memleak on release
>   media: bdisp: fix memleak on release
>   media: radio: wl1273: fix interrupt masking on release
>   s390/zcrypt: fix memleak at release
> 
>  drivers/gpu/drm/msm/msm_debugfs.c             | 6 +-----
>  drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 3 +--
>  drivers/media/radio/radio-wl1273.c            | 3 +--
>  drivers/s390/crypto/zcrypt_api.c              | 3 +--
>  4 files changed, 4 insertions(+), 11 deletions(-)
> 
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
