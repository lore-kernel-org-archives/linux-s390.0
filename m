From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] s390: virtio: constify virtio_config_ops structures
Date: Mon, 16 Jan 2017 10:08:27 +0100
Message-ID: <d5917ef7-9346-7db4-3e7d-5ef375acf95e@de.ibm.com>
References: <1484333336-13443-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1484333336-13443-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, heiko.carstens@de.ibm.com, cornelia.huck@de.ibm.com, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/13/2017 07:48 PM, Bhumika Goyal wrote:
> Declare virtio_config_ops structure as const as it is only stored in the
> config field of a virtio_device structure. This field is of type const, so
> virtio_config_ops structures having this property can be declared const.
> Done using Coccinelle:
> 
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct virtio_config_ops i@p={...};
> 
> @ok1@
> identifier r1.i;
> position p;
> struct virtio_ccw_device x;
> @@
> x.vdev.config=&i@p
> 
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct virtio_config_ops i;
> 
> File size before and after applying the patch remains the same.
> text	data	bss	dec	hex   filename
> 9235	296	32928	42459	a5db  drivers/s390/virtio/virtio_ccw.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

thanks applied.

> ---
>  drivers/s390/virtio/virtio_ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 639ed4e..6508bf4 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -920,7 +920,7 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>  	kfree(ccw);
>  }
> 
> -static struct virtio_config_ops virtio_ccw_config_ops = {
> +static const struct virtio_config_ops virtio_ccw_config_ops = {
>  	.get_features = virtio_ccw_get_features,
>  	.finalize_features = virtio_ccw_finalize_features,
>  	.get = virtio_ccw_get_config,
> 
