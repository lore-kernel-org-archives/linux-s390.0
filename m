Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Nov 2014 11:09:10 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v6 20/46] KVM: s390: enable virtio-ccw revision 1
Message-ID: <20141128110910.123a1c62.cornelia.huck@de.ibm.com>
In-Reply-To: <1417118789-18231-21-git-send-email-mst@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-21-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, dahi@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 27 Nov 2014 22:09:30 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Now that virtio-ccw has everything needed to support virtio 1.0 in
> place, try to enable it if the host supports it.
> 
> MST: enable virtio 1.0 feature bit

Stale comment?

> 
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index 79f6737..8ec68dd 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -103,7 +103,7 @@ struct virtio_rev_info {
>  };
> 
>  /* the highest virtio-ccw revision we support */
> -#define VIRTIO_CCW_REV_MAX 0
> +#define VIRTIO_CCW_REV_MAX 1
> 
>  struct virtio_ccw_vq_info {
>  	struct virtqueue *vq;
