Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbfFKKaX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 06:30:23 -0400
Date: Tue, 11 Jun 2019 12:30:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 7/8] virtio/s390: use DMA memory for ccw I/O and
 classic notifiers
Message-ID: <20190611123006.222aa424.cohuck@redhat.com>
In-Reply-To: <20190606115127.55519-8-pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
        <20190606115127.55519-8-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Thu,  6 Jun 2019 13:51:26 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Before virtio-ccw could get away with not using DMA API for the pieces of
> memory it does ccw I/O with. With protected virtualization this has to
> change, since the hypervisor needs to read and sometimes also write these
> pieces of memory.
> 
> The hypervisor is supposed to poke the classic notifiers, if these are
> used, out of band with regards to ccw I/O. So these need to be allocated
> as DMA memory (which is shared memory for protected virtualization
> guests).
> 
> Let us factor out everything from struct virtio_ccw_device that needs to
> be DMA memory in a satellite that is allocated as such.
> 
> Note: The control blocks of I/O instructions do not need to be shared.
> These are marshalled by the ultravisor.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 171 ++++++++++++++++---------------
>  1 file changed, 90 insertions(+), 81 deletions(-)

(...)

>  static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	struct virtio_feature_desc *features;
> +	struct ccw1 *ccw;
>  	int ret;
>  	u64 rc;
> -	struct ccw1 *ccw;

I'd probably not have included unneeded code movement here, but no need
to respin for that.

>  
> -	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
> +	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));
>  	if (!ccw)
>  		return 0;
>  
> -	features = kzalloc(sizeof(*features), GFP_DMA | GFP_KERNEL);
> +	features = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*features));
>  	if (!features) {
>  		rc = 0;
>  		goto out_free;

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
