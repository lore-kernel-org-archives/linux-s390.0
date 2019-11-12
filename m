Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40109 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfKLOCA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 09:02:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so3073111wmc.5
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 06:01:58 -0800 (PST)
Date: Tue, 12 Nov 2019 15:01:55 +0100
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/4] drm/msm: fix memleak on release
Message-ID: <20191112140155.GJ23790@phenom.ffwll.local>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010131333.23635-2-johan@kernel.org>
 <20191030100146.GC4691@localhost>
 <20191112104001.GP11035@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112104001.GP11035@localhost>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, Jordan Crouse <jcrouse@codeaurora.org>, Harald Freudenberger <freude@linux.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Fabien Dessenne <fabien.dessenne@st.com>, Dave Airlie <airlied@gmail.com>

On Tue, Nov 12, 2019 at 11:40:01AM +0100, Johan Hovold wrote:
> On Wed, Oct 30, 2019 at 11:01:46AM +0100, Johan Hovold wrote:
> > On Thu, Oct 10, 2019 at 03:13:30PM +0200, Johan Hovold wrote:
> > > If a process is interrupted while accessing the "gpu" debugfs file and
> > > the drm device struct_mutex is contended, release() could return early
> > > and fail to free related resources.
> > > 
> > > Note that the return value from release() is ignored.
> > > 
> > > Fixes: 4f776f4511c7 ("drm/msm/gpu: Convert the GPU show function to use the GPU state")
> > > Cc: stable <stable@vger.kernel.org>     # 4.18
> > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > Cc: Rob Clark <robdclark@gmail.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > 
> > Rob, Sean,
> > 
> > Sending a reminder about this one, which is not yet in linux-next.
> > 
> > Perhaps Daniel can pick it up otherwise?
> 
> Another two weeks, another reminder. This one is still not in -next.

Well msm is maintained in a separate tree, so the usual group maintainer
fallback for when patches are stuck doesn't apply.

Rob, Sean, time to reconsider drm-misc for msm? I think there's some more
oddball patches that occasionally get stuck for msm ...

Also +Dave.
-Daniel

> 
> Johan
> 
> > >  drivers/gpu/drm/msm/msm_debugfs.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> > > index 6be879578140..1c74381a4fc9 100644
> > > --- a/drivers/gpu/drm/msm/msm_debugfs.c
> > > +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> > > @@ -47,12 +47,8 @@ static int msm_gpu_release(struct inode *inode, struct file *file)
> > >  	struct msm_gpu_show_priv *show_priv = m->private;
> > >  	struct msm_drm_private *priv = show_priv->dev->dev_private;
> > >  	struct msm_gpu *gpu = priv->gpu;
> > > -	int ret;
> > > -
> > > -	ret = mutex_lock_interruptible(&show_priv->dev->struct_mutex);
> > > -	if (ret)
> > > -		return ret;
> > >  
> > > +	mutex_lock(&show_priv->dev->struct_mutex);
> > >  	gpu->funcs->gpu_state_put(show_priv->state);
> > >  	mutex_unlock(&show_priv->dev->struct_mutex);

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
