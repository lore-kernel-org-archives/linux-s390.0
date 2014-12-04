Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Dec 2014 18:56:06 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 2/3] virtio_ccw: legacy: don't negotiate rev
 1/features
Message-ID: <20141204185606.61f31919.cornelia.huck@de.ibm.com>
In-Reply-To: <1417713984-23771-2-git-send-email-mst@redhat.com>
References: <1417713984-23771-1-git-send-email-mst@redhat.com>
	<1417713984-23771-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, David Hildenbrand <dahi@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 4 Dec 2014 19:26:45 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Legacy balloon device doesn't pretend to support revision 1 or 64 bit
> features.
> 
> But just in case someone implements a broken one that does, let's not
> even try to drive legacy only devices using revision 1, and let's not
> give them a chance to say they support VIRTIO_F_VERSION_1 by not reading
> high feature bits.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index 4a3e6e5..088bdf1 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -733,6 +733,9 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
> 
>  	rc = le32_to_cpu(features->features);
> 
> +	if (vcdev->revision == 0)
> +		goto out_free;
> +
>  	/* Read second half of the feature bits from the host. */
>  	features->index = 1;
>  	ccw->cmd_code = CCW_CMD_READ_FEAT;
> @@ -1182,9 +1185,13 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	vcdev->vdev.id.vendor = cdev->id.cu_type;
>  	vcdev->vdev.id.device = cdev->id.cu_model;
> 
> -	ret = virtio_ccw_set_transport_rev(vcdev);
> -	if (ret)
> -		goto out_free;
> +	if (virtio_device_is_legacy_only(vcdev->vdev.id)) {

Inverted logic?

> +		ret = virtio_ccw_set_transport_rev(vcdev);
> +		if (ret)
> +			goto out_free;
> +	} else {
> +		vcdev->revision = 0;
> +	}
> 
>  	ret = register_virtio_device(&vcdev->vdev);
>  	if (ret) {
