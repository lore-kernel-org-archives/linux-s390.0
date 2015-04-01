Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <551BCB0A.4060107@de.ibm.com>
Date: Wed, 01 Apr 2015 12:40:10 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 3/6] virtio_ccw: support non-legacy balloon
 devices
References: <1427884468-23930-1-git-send-email-mst@redhat.com> <1427884468-23930-4-git-send-email-mst@redhat.com>
In-Reply-To: <1427884468-23930-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, virtio-dev@lists.oasis-open.org, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 01.04.2015 um 12:35 schrieb Michael S. Tsirkin:
> virtio_device_is_legacy_only is always false now,
> drop the test from virtio ccw.

Can you add the commit subject of patch2 here as a
prereq for this patch? This will hopefully avoid 
backport issues on distros that want to take this
patch but not the other for whatever reasons.


this patch is then.
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index 71d7802..6f1fa17 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -1201,13 +1201,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	vcdev->vdev.id.vendor = cdev->id.cu_type;
>  	vcdev->vdev.id.device = cdev->id.cu_model;
> 
> -	if (virtio_device_is_legacy_only(vcdev->vdev.id)) {
> -		vcdev->revision = 0;
> -	} else {
> -		ret = virtio_ccw_set_transport_rev(vcdev);
> -		if (ret)
> -			goto out_free;
> -	}
> +	ret = virtio_ccw_set_transport_rev(vcdev);
> +	if (ret)
> +		goto out_free;
> 
>  	ret = register_virtio_device(&vcdev->vdev);
>  	if (ret) {
> 
