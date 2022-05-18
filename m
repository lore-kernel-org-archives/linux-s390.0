Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE5C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 18 May 2022 10:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiERKE1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 May 2022 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiERKEB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 06:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58D2B5EDD4
        for <linux-s390@vger.kernel.org>; Wed, 18 May 2022 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652868239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHBgBjMyseW/Lrzc/9+U6d8EH43uYJQ4y4ogp1VkNaE=;
        b=IXfZsVJBGugNy40yaJEdKWZciwd6lHPZmNFQV735vlq43R9OARQ85yEBd4gf2a0CrR/c1T
        sDCfNZ82pahR5feFHKgoBVFOEkxCJj66VRavKC/P+xyCJYOhxV/g8adk19Y8LtQ8n98U1b
        l1mKTgkoUASeN2qCqR12sGxHayUoUpY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357--aai4pw_MguMuKxj32vTXg-1; Wed, 18 May 2022 06:03:58 -0400
X-MC-Unique: -aai4pw_MguMuKxj32vTXg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2CEB1C04B40;
        Wed, 18 May 2022 10:03:57 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F3AE492C3B;
        Wed, 18 May 2022 10:03:57 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V5 7/9] virtio: allow to unbreak virtqueue
In-Reply-To: <20220518035951.94220-8-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-8-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 18 May 2022 12:03:56 +0200
Message-ID: <87r14rf983.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch allows the new introduced __virtio_break_device() to
> unbreak the virtqueue.
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
>  include/linux/virtio.h       |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cfb028ca238e..5b7df7c455f0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2397,6 +2397,27 @@ void virtio_break_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_break_device);
>  
> +/*
> + * This should allow the device to be used by the driver. You may
> + * need to grab appropriate locks to flush. This should only be used

Hm, to flush what?

> + * in some specific case e.g (probing and restoring). Driver should
> + * not call this directly.

Maybe "This function should only be called by the core, not directly by
the driver."?

> + */
> +void __virtio_unbreak_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *_vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(_vq, &dev->vqs, list) {
> +		struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +		WRITE_ONCE(vq->broken, false);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +
>  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);

