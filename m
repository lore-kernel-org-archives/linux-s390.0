Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Oct 2014 19:22:33 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v4 16/17] KVM: s390 allow virtio_ccw status writes
 to fail
Message-ID: <20141023192233.29ca143e.cornelia.huck@de.ibm.com>
In-Reply-To: <1414081380-14623-17-git-send-email-mst@redhat.com>
References: <1414081380-14623-1-git-send-email-mst@redhat.com>
	<1414081380-14623-17-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 23 Oct 2014 19:25:01 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Gracefully handle failure to write device status.
> We really should handle other errors as well, but this one is needed for
> virtio 1.0 compliance.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index a994078..26e737c 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -862,7 +862,9 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
>  static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	u8 old_status = vcdev->status;

*vcdev->status

>  	struct ccw1 *ccw;
> +	int ret;
> 
>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
>  	if (!ccw)
> @@ -874,7 +876,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>  	ccw->flags = 0;
>  	ccw->count = sizeof(status);
>  	ccw->cda = (__u32)(unsigned long)vcdev->status;
> -	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> +	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> +	/* Write failed? We assume status is unchanged. */
> +	if (ret)
> +		*vcdev->status = old_status;

If we fail the write, ccw->cda should be unchanged; but this doesn't
hurt.

>  	kfree(ccw);
>  }
> 
