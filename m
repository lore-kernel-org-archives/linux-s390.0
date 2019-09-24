Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392022AbfIXOEX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Sep 2019 10:04:23 -0400
Date: Tue, 24 Sep 2019 08:04:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 5/6] vringh: fix copy direction of
 vringh_iov_push_kern()
Message-ID: <20190924080413.0cc875c5@x1.home>
In-Reply-To: <20190923115930-mutt-send-email-mst@kernel.org>
References: <20190923130331.29324-1-jasowang@redhat.com>
        <20190923130331.29324-6-jasowang@redhat.com>
        <20190923094559.765da494@x1.home>
        <20190923115930-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com

On Mon, 23 Sep 2019 12:00:41 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Sep 23, 2019 at 09:45:59AM -0600, Alex Williamson wrote:
> > On Mon, 23 Sep 2019 21:03:30 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >   
> > > We want to copy from iov to buf, so the direction was wrong.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vhost/vringh.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)  
> > 
> > 
> > Why is this included in the series?  Seems like an unrelated fix being
> > held up within a proposal for a new feature.  Thanks,
> > 
> > Alex  
> 
> It's better to have it as patch 1/6, but it's a dependency of the
> example driver in the series. I can reorder when I apply.

It's a fix, please submit it separately through virtio/vhost channels,
then it will already be in the base kernel we use for the rest of the
series.  The remainder of the series certainly suggests a workflow
through the vfio tree rather than virtio/vhost.  Thanks,

Alex

> > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > index 08ad0d1f0476..a0a2d74967ef 100644
> > > --- a/drivers/vhost/vringh.c
> > > +++ b/drivers/vhost/vringh.c
> > > @@ -852,6 +852,12 @@ static inline int xfer_kern(void *src, void *dst, size_t len)
> > >  	return 0;
> > >  }
> > >  
> > > +static inline int kern_xfer(void *dst, void *src, size_t len)
> > > +{
> > > +	memcpy(dst, src, len);
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * vringh_init_kern - initialize a vringh for a kernelspace vring.
> > >   * @vrh: the vringh to initialize.
> > > @@ -958,7 +964,7 @@ EXPORT_SYMBOL(vringh_iov_pull_kern);
> > >  ssize_t vringh_iov_push_kern(struct vringh_kiov *wiov,
> > >  			     const void *src, size_t len)
> > >  {
> > > -	return vringh_iov_xfer(wiov, (void *)src, len, xfer_kern);
> > > +	return vringh_iov_xfer(wiov, (void *)src, len, kern_xfer);
> > >  }
> > >  EXPORT_SYMBOL(vringh_iov_push_kern);
> > >    
