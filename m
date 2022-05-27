Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF3C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 07:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiE0Hco (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347154AbiE0Hcn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 03:32:43 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94979F748B;
        Fri, 27 May 2022 00:32:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VEW8612_1653636756;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VEW8612_1653636756)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:32:37 +0800
Message-ID: <1653636748.5919-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 5/9] virtio-mmio: implement synchronize_cbs()
Date:   Fri, 27 May 2022 15:32:28 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-6-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-6-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 27 May 2022 14:01:16 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Simply synchronize the platform irq that is used by us.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_mmio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 839684d672af..c9699a59f93c 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -345,6 +345,13 @@ static void vm_del_vqs(struct virtio_device *vdev)
>  	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
>  }
>
> +static void vm_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
> +}
> +
>  static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int index,
>  				  void (*callback)(struct virtqueue *vq),
>  				  const char *name, bool ctx)
> @@ -541,6 +548,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.finalize_features = vm_finalize_features,
>  	.bus_name	= vm_bus_name,
>  	.get_shm_region = vm_get_shm_region,
> +	.synchronize_cbs = vm_synchronize_cbs,
>  };
>
>
> --
> 2.25.1
>
