Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F1C4332F
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 09:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiCIJYE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 04:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiCIJYD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 04:24:03 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0D66C1C2;
        Wed,  9 Mar 2022 01:23:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0V6iwYED_1646817777;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V6iwYED_1646817777)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 17:22:58 +0800
Message-ID: <1646817741.6086373-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
Date:   Wed, 9 Mar 2022 17:22:21 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
 <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
In-Reply-To: <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 9 Mar 2022 15:51:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2022/3/8 =E4=B8=8B=E5=8D=888:35, Xuan Zhuo =E5=86=99=E9=81=93:
> > Introduce vring_free() to free the vring of vq.
> >
> > Prevent double free by setting vq->reset.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/virtio/virtio_ring.c | 25 ++++++++++++++++++++-----
> >   include/linux/virtio.h       |  8 ++++++++
> >   2 files changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index b5a9bf4f45b3..e0422c04c903 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2442,14 +2442,10 @@ struct virtqueue *vring_new_virtqueue(unsigned =
int index,
> >   }
> >   EXPORT_SYMBOL_GPL(vring_new_virtqueue);
> >
> > -void vring_del_virtqueue(struct virtqueue *_vq)
> > +static void __vring_free(struct virtqueue *_vq)
> >   {
> >   	struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -	spin_lock(&vq->vq.vdev->vqs_list_lock);
> > -	list_del(&_vq->list);
> > -	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> > -
> >   	if (vq->we_own_ring) {
> >   		if (vq->packed_ring) {
> >   			vring_free_queue(vq->vq.vdev,
> > @@ -2480,6 +2476,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >   		kfree(vq->split.desc_state);
> >   		kfree(vq->split.desc_extra);
> >   	}
> > +}
> > +
> > +static void vring_free(struct virtqueue *vq)
> > +{
> > +	__vring_free(vq);
> > +	vq->reset =3D VIRTIO_VQ_RESET_STEP_VRING_RELEASE;
> > +}
> > +
> > +void vring_del_virtqueue(struct virtqueue *_vq)
> > +{
> > +	struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +
> > +	spin_lock(&vq->vq.vdev->vqs_list_lock);
> > +	list_del(&_vq->list);
> > +	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> > +
> > +	if (_vq->reset !=3D VIRTIO_VQ_RESET_STEP_VRING_RELEASE)
> > +		__vring_free(_vq);
> > +
> >   	kfree(vq);
> >   }
> >   EXPORT_SYMBOL_GPL(vring_del_virtqueue);
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index d59adc4be068..e3714e6db330 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -10,6 +10,13 @@
> >   #include <linux/mod_devicetable.h>
> >   #include <linux/gfp.h>
> >
> > +enum virtio_vq_reset_step {
> > +	VIRTIO_VQ_RESET_STEP_NONE,
> > +	VIRTIO_VQ_RESET_STEP_DEVICE,
> > +	VIRTIO_VQ_RESET_STEP_VRING_RELEASE,
> > +	VIRTIO_VQ_RESET_STEP_VRING_ATTACH,
> > +};
>
>
> This part looks not related to the subject.
>
> And it needs detail documentation on this.
>
> But I wonder how useful it is, anyway we can check the reset status via
> transport specific way and in the future we may want to do more than
> just resizing (e.g PASID).


I will try and remove it from here.

Thanks.

>
> Thanks
>
>
> > +
> >   /**
> >    * virtqueue - a queue to register buffers for sending or receiving.
> >    * @list: the chain of virtqueues for this device
> > @@ -33,6 +40,7 @@ struct virtqueue {
> >   	unsigned int num_free;
> >   	unsigned int num_max;
> >   	void *priv;
> > +	enum virtio_vq_reset_step reset;
> >   };
> >
> >   int virtqueue_add_outbuf(struct virtqueue *vq,
>
