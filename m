Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Nov 2014 13:56:00 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v6 06/46] virtio_ccw: add support for 64 bit features.
Message-ID: <20141128135600.594dd74e.cornelia.huck@de.ibm.com>
In-Reply-To: <1417118789-18231-7-git-send-email-mst@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-7-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, dahi@linux.vnet.ibm.com, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 27 Nov 2014 22:08:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Negotiate full 64 bit features.
> Change u32 to u64, make sure to use 1ULL everywhere.
> 
> Note: devices guarantee that VERSION_1 is clear unless
> revision 1 is negotiated.
> 
> Based on patches by Rusty, Thomas Huth and Cornelia.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 

> @@ -691,6 +691,16 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
> 
>  	rc = le32_to_cpu(features->features);
> 
> +	/* Read second half feature bits from the host. */

s/half feature bits/half of the feature bits/

> +	features->index = 1;
> +	ccw->cmd_code = CCW_CMD_READ_FEAT;
> +	ccw->flags = 0;
> +	ccw->count = sizeof(*features);
> +	ccw->cda = (__u32)(unsigned long)features;

We don't need to re-setup the ccw, but it probably doesn't hurt for
clarity.

> +	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_FEAT);
> +	if (ret == 0)
> +		rc |= (u64)le32_to_cpu(features->features) << 32;
> +
>  out_free:
>  	kfree(features);
>  	kfree(ccw);

Looks good.
