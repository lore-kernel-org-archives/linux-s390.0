Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E0C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 07:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbiE0HcI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbiE0HcG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 03:32:06 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4993EC3F9;
        Fri, 27 May 2022 00:32:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VEWDhhD_1653636721;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VEWDhhD_1653636721)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:32:01 +0800
Message-ID: <1653636712.2244692-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 4/9] virtio-pci: implement synchronize_cbs()
Date:   Fri, 27 May 2022 15:31:52 +0800
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
 <20220527060120.20964-5-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-5-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 27 May 2022 14:01:15 +0800, Jason Wang <jasowang@redhat.com> wrote:
> We can simply reuse vp_synchronize_vectors() for .synchronize_cbs().
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
>  drivers/virtio/virtio_pci_legacy.c | 1 +
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 7fe4caa4b519..a5e5721145c7 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -192,6 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_cbs = vp_synchronize_vectors,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 4acb34409f0b..623906b4996c 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_cbs = vp_synchronize_vectors,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> @@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_cbs = vp_synchronize_vectors,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> --
> 2.25.1
>
