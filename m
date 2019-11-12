Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34923 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLKj5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 05:39:57 -0500
Date: Tue, 12 Nov 2019 11:40:01 +0100
From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/4] drm/msm: fix memleak on release
Message-ID: <20191112104001.GP11035@localhost>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010131333.23635-2-johan@kernel.org>
 <20191030100146.GC4691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030100146.GC4691@localhost>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Jordan Crouse <jcrouse@codeaurora.org>, Harald Freudenberger <freude@linux.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Fabien Dessenne <fabien.dessenne@st.com>

On Wed, Oct 30, 2019 at 11:01:46AM +0100, Johan Hovold wrote:
> On Thu, Oct 10, 2019 at 03:13:30PM +0200, Johan Hovold wrote:
> > If a process is interrupted while accessing the "gpu" debugfs file and
> > the drm device struct_mutex is contended, release() could return early
> > and fail to free related resources.
> > 
> > Note that the return value from release() is ignored.
> > 
> > Fixes: 4f776f4511c7 ("drm/msm/gpu: Convert the GPU show function to use the GPU state")
> > Cc: stable <stable@vger.kernel.org>     # 4.18
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Rob, Sean,
> 
> Sending a reminder about this one, which is not yet in linux-next.
> 
> Perhaps Daniel can pick it up otherwise?

Another two weeks, another reminder. This one is still not in -next.

Johan

> >  drivers/gpu/drm/msm/msm_debugfs.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> > index 6be879578140..1c74381a4fc9 100644
> > --- a/drivers/gpu/drm/msm/msm_debugfs.c
> > +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> > @@ -47,12 +47,8 @@ static int msm_gpu_release(struct inode *inode, struct file *file)
> >  	struct msm_gpu_show_priv *show_priv = m->private;
> >  	struct msm_drm_private *priv = show_priv->dev->dev_private;
> >  	struct msm_gpu *gpu = priv->gpu;
> > -	int ret;
> > -
> > -	ret = mutex_lock_interruptible(&show_priv->dev->struct_mutex);
> > -	if (ret)
> > -		return ret;
> >  
> > +	mutex_lock(&show_priv->dev->struct_mutex);
> >  	gpu->funcs->gpu_state_put(show_priv->state);
> >  	mutex_unlock(&show_priv->dev->struct_mutex);
