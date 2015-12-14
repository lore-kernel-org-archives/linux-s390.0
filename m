From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/1] virtio/s390: one fix
Date: Mon, 14 Dec 2015 17:25:25 +0200
Message-ID: <20151214172458-mutt-send-email-mst@redhat.com>
References: <1449159840-60270-1-git-send-email-cornelia.huck@de.ibm.com>
 <20151214160233.62f4f3c2.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151214160233.62f4f3c2.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 14, 2015 at 04:02:33PM +0100, Cornelia Huck wrote:
> On Thu,  3 Dec 2015 17:23:59 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > Michael,
> > 
> > here's one fix for the virtio-ccw driver.
> > 
> > Patch is against master, as your git branches on mst/vhost.git seem
> > to be quite old. Is there some branch I can base my own branch on,
> > or do you prefer to take patches directly anyway?
> > 
> > Cornelia Huck (1):
> >   virtio/s390: handle error values in irb
> > 
> >  drivers/s390/virtio/virtio_ccw.c | 62 ++++++++++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 25 deletions(-)
> > 
> 
> Ping?

Thanks, I'll merge this, hope it can still make 4.4.

-- 
MST
