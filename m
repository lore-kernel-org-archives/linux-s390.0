From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/1] virtio/s390: one bugfix
Date: Thu, 10 Sep 2015 17:58:19 +0300
Message-ID: <20150910175807-mutt-send-email-mst@redhat.com>
References: <1441895708-70657-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441895708-70657-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 10, 2015 at 04:35:07PM +0200, Cornelia Huck wrote:
> Michael,
> 
> here's a bugfix for the virtio-ccw driver.
> 
> Question: How would you like to get patches? This one is formatted
> against your current linux-next branch; I can prepare a branch for
> you to pull from as well.

No need, patches are fine.

> Pierre Morel (1):
>   virtio/s390: handle failures of READ_VQ_CONF ccw
> 
>  drivers/s390/virtio/virtio_ccw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> -- 
> 2.3.8
