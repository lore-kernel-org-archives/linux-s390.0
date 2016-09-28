From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio/s390: add missing \n to end of dev_err message
Date: Wed, 28 Sep 2016 08:38:55 +0200
Message-ID: <ec73622e-075f-a14b-0a6d-af07dc4d2d8b@de.ibm.com>
References: <20160927200844.16008-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160927200844.16008-1-colin.king@canonical.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Colin King <colin.king@canonical.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/27/2016 10:08 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_err message is missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 8688ad4..9d36dc4 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -462,7 +462,7 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
>  	 * This may happen on device detach.
>  	 */
>  	if (ret && (ret != -ENODEV))
> -		dev_warn(&vq->vdev->dev, "Error %d while deleting queue %d",
> +		dev_warn(&vq->vdev->dev, "Error %d while deleting queue %d\n",
>  			 ret, index);
> 
>  	vring_del_virtqueue(vq);
> 

Thanks, applied.
