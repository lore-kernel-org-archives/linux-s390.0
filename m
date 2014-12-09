Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Dec 2014 12:01:23 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 4/6] virtio_ccw: rev 1 devices set VIRTIO_F_VERSION_1
Message-ID: <20141209120123.117ccfac.cornelia.huck@de.ibm.com>
In-Reply-To: <1418042769-25539-5-git-send-email-mst@redhat.com>
References: <1418042769-25539-1-git-send-email-mst@redhat.com>
	<1418042769-25539-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, dahi@linux.vnet.ibm.com, rusty@rustcorp.com.au, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 8 Dec 2014 15:06:03 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> What does it mean if rev 1 device does not set
> VIRTIO_F_VERSION_1? E.g. is it native endian?

My understanding is that revision only determines the set of channel
commands supported by the device, and their payload. IOW, it just
governs the transport-specific way to communicate; things like
endianness are independent of that and only governed by the VERSION_1
bit which has rev 1 as a pre-req.
> 
> Let's not even try to drive such devices:
> fail attempts to finalize features.
> virtio core will detect this and bail out.

Of course, we can still make the decision to refuse non-VERSION_1
devices if rev 1 has been negotiated, but I'm still not quite sure what
this buys us.

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index 789275f..f9f87ba 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -758,6 +758,13 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
>  	struct virtio_feature_desc *features;
>  	struct ccw1 *ccw;
> 
> +	if (vcdev->revision == 1 &&

If we decide to keep this check, it should be for rev >= 1, though.

> +	    !__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev, "virtio: device uses revision 1 "
> +			"but does not have VIRTIO_F_VERSION_1\n");
> +		return -EINVAL;
> +	}
> +
>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
>  	if (!ccw)
>  		return 0;

I'm still not convinced by this change: I'd prefer to allow rev 1
without VERSION_1, especially as the core makes all its decisions based
upon VERSION_1. Unless someone else has a good argument in favour of
this change.
